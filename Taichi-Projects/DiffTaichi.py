import taichi as ti
import numpy as np

# 初始化 Taichi，选择 GPU 进行计算
ti.init(arch=ti.gpu)

# 配置分辨率的质量
quality = 1  # 使用较大的值进行高分辨率仿真
n_particles, n_grid = 9000 * quality ** 2, 128 * quality  # 粒子和网格数量
dx, inv_dx = 1 / n_grid, float(n_grid)  # 网格间距及其倒数
dt = 1e-4 / quality  # 时间步长
p_vol, p_rho = (dx * 0.5)**2, 1  # 粒子体积和密度
p_mass = p_vol * p_rho  # 粒子质量
E, nu = 0.1e4, 0.2  # 杨氏模量和泊松比
mu_0, lambda_0 = E / (2 * (1 + nu)), E * nu / ((1 + nu) * (1 - 2 * nu))  # 拉梅参数
x = ti.Vector.field(2, dtype=float, shape=n_particles)  # 粒子位置
v = ti.Vector.field(2, dtype=float, shape=n_particles)  # 粒子速度
C = ti.Matrix.field(2, 2, dtype=float, shape=n_particles)  # 仿真速度场
F = ti.Matrix.field(2, 2, dtype=float, shape=n_particles)  # 变形梯度
material = ti.field(dtype=int, shape=n_particles)  # 材料类型 ID
Jp = ti.field(dtype=float, shape=n_particles)  # 塑性变形因子
grid_v = ti.Vector.field(2, dtype=float, shape=(n_grid, n_grid))  # 网格节点动量/速度
grid_m = ti.field(dtype=float, shape=(n_grid, n_grid))  # 网格节点质量

# 每个时间步长的计算
@ti.kernel
def substep():
  # 重置网格速度和质量
  for i, j in grid_m:
    grid_v[i, j] = [0, 0]
    grid_m[i, j] = 0

  # 粒子状态更新并散射到网格 (P2G)
  for p in x:
    base = (x[p] * inv_dx - 0.5).cast(int)
    fx = x[p] * inv_dx - base.cast(float)
    # 使用二次核函数计算权重
    w = [0.5 * (1.5 - fx) ** 2, 0.75 - (fx - 1) ** 2, 0.5 * (fx - 0.5) ** 2]
    # 更新变形梯度
    F[p] = (ti.Matrix.identity(float, 2) + dt * C[p]) @ F[p]
    h = ti.exp(10 * (1.0 - Jp[p]))  # 硬化系数：压缩时雪变硬
    if material[p] == 1:  # 如果是果冻材质，设置软化
      h = 0.3
    mu, la = mu_0 * h, lambda_0 * h  # 动态拉梅参数
    if material[p] == 0:  # 液体，令粘性为零
      mu = 0.0
    # 计算 SVD 分解
    U, sig, V = ti.svd(F[p])
    J = 1.0
    for d in ti.static(range(2)):
      new_sig = sig[d, d]
      if material[p] == 2:  # 雪的塑性变形
        new_sig = min(max(sig[d, d], 1 - 2.5e-2), 1 + 4.5e-3)  # 塑性限制
      Jp[p] *= sig[d, d] / new_sig
      sig[d, d] = new_sig
      J *= new_sig
    # 液体物质重置变形梯度，避免数值不稳定
    if material[p] == 0:
      F[p] = ti.Matrix.identity(float, 2) * ti.sqrt(J)
    elif material[p] == 2:
      F[p] = U @ sig @ V.transpose()  # 雪的弹性变形梯度恢复
    # 计算应力
    stress = 2 * mu * (F[p] - U @ V.transpose()) @ F[p].transpose() + ti.Matrix.identity(float, 2) * la * J * (J - 1)
    stress = (-dt * p_vol * 4 * inv_dx * inv_dx) * stress
    affine = stress + p_mass * C[p]

    # 将应力和质量散射到周围网格节点
    for i, j in ti.static(ti.ndrange(3, 3)):
      offset = ti.Vector([i, j])
      dpos = (offset.cast(float) - fx) * dx
      weight = w[i][0] * w[j][1]
      grid_v[base + offset] += weight * (p_mass * v[p] + affine @ dpos)
      grid_m[base + offset] += weight * p_mass

  # 更新网格节点速度，并施加重力和边界条件
  for i, j in grid_m:
    if grid_m[i, j] > 0:
      grid_v[i, j] = (1 / grid_m[i, j]) * grid_v[i, j]  # 动量转换为速度
      grid_v[i, j][1] -= dt * 50  # 重力
      # 边界条件处理
      if i < 3 and grid_v[i, j][0] < 0:          grid_v[i, j][0] = 0
      if i > n_grid - 3 and grid_v[i, j][0] > 0: grid_v[i, j][0] = 0
      if j < 3 and grid_v[i, j][1] < 0:          grid_v[i, j][1] = 0
      if j > n_grid - 3 and grid_v[i, j][1] > 0: grid_v[i, j][1] = 0

  # 从网格节点更新粒子速度和位置 (G2P)
  for p in x:
    base = (x[p] * inv_dx - 0.5).cast(int)
    fx = x[p] * inv_dx - base.cast(float)
    w = [0.5 * (1.5 - fx) ** 2, 0.75 - (fx - 1.0) ** 2, 0.5 * (fx - 0.5) ** 2]
    new_v = ti.Vector.zero(float, 2)
    new_C = ti.Matrix.zero(float, 2, 2)
    for i, j in ti.static(ti.ndrange(3, 3)):  # 遍历 3x3 的网格邻域
      dpos = ti.Vector([i, j]).cast(float) - fx
      g_v = grid_v[base + ti.Vector([i, j])]
      weight = w[i][0] * w[j][1]
      new_v += weight * g_v
      new_C += 4 * inv_dx * weight * g_v.outer_product(dpos)
    v[p], C[p] = new_v, new_C
    x[p] += dt * v[p]  # 更新粒子位置

# 初始化粒子和网格
group_size = n_particles // 3
@ti.kernel
def initialize():
  for i in range(n_particles):
    x[i] = [ti.random() * 0.2 + 0.3 + 0.10 * (i // group_size), ti.random() * 0.2 + 0.05 + 0.32 * (i // group_size)]
    material[i] = i // group_size  # 0: 液体, 1: 果冻, 2: 雪
    v[i] = ti.Matrix([0, 0])
    F[i] = ti.Matrix([[1, 0], [0, 1]])  # 初始变形梯度为单位矩阵
    Jp[i] = 1  # 初始塑性变形因子为1

initialize()

# 创建 GUI 并显示仿真结果
gui = ti.GUI("Taichi MLS-MPM-99", res=512, background_color=0x112F41)
while not gui.get_event(ti.GUI.ESCAPE, ti.GUI.EXIT):
  for s in range(int(2e-3 // dt)):  # 执行多个子步骤以确保流体稳定
    substep()
  colors = np.array([0x068587, 0xED553B, 0xEEEEF0], dtype=np.uint32)  # 为不同物质设置颜色
  gui.circles(x.to_numpy(), radius=1.5, color=colors[material.to_numpy()])
  gui.show()  # 显示窗口，或者将图像保存到文件（例如：gui.save_image())
