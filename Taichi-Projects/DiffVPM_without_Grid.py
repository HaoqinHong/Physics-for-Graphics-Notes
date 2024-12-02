import taichi as ti
import numpy as np
import matplotlib.pyplot as plt
from matplotlib.animation import FuncAnimation

'''
VPM的可微性：VPM方法的力计算（基于涡旋相互作用）通常是连续和可微的，特别是在不涉及零距离或奇异点的情况下。
如果力计算公式存在不光滑的部分（例如，在粒子距离过近时），可能会导致不可微的行为。
'''


# 初始化Taichi
ti.init(arch=ti.gpu)

# 参数设置
num_particles = 1000  # 粒子数量
dt = 5e-6             # 时间步长 (减小时间步长，让粒子变化变慢)
domain_size = 1.0     # 模拟域大小

# 创建Taichi字段
'''
pos：每个粒子的二维位置，通过ti.Vector.field(2, dtype=ti.f32)定义为(x, y)类型。
vorticity：每个粒子的涡旋强度，表示每个粒子的涡旋程度。
velocity：每个粒子的速度，初始化为二维向量。
'''
pos = ti.Vector.field(2, dtype=ti.f32, shape=num_particles)  # 粒子位置
vorticity = ti.field(dtype=ti.f32, shape=num_particles)      # 涡旋强度
velocity = ti.Vector.field(2, dtype=ti.f32, shape=num_particles)  # 速度

# 粒子的初始状态
'''
粒子的位置是通过ti.random()生成的随机数，并映射到模拟域内（大小为domain_size）。
涡旋强度是随机的，范围在0到10之间。
初始速度为零，表示粒子一开始是静止的。
'''
@ti.kernel
def initialize():
    for i in range(num_particles):
        pos[i] = ti.Vector([ti.random() * domain_size, ti.random() * domain_size])
        vorticity[i] = ti.random() * 10.0  # 随机涡旋强度
        velocity[i] = ti.Vector([0.0, 0.0])  # 初始速度为零

# 计算涡旋力
'''
compute_forces()：该方法计算每个粒子与其他粒子之间的涡旋相互作用力。
对每一对粒子 (i, j)，首先计算两粒子间的距离 r 和距离的模长 r_mag。
使用 r_hat 计算方向向量。
涡旋强度的相互作用力 gamma 是基于粒子涡旋强度和距离的平方反比。
涡旋相互作用力的计算通过取垂直向量 (perpendicular_r_hat) 来模拟旋转效应。
力的计算是将两粒子的涡旋力相加。
'''
@ti.kernel
def compute_forces():
    for i in range(num_particles):
        force = ti.Vector([0.0, 0.0])
        for j in range(num_particles):
            if i != j:
                # 计算两粒子之间的距离和方向
                r = pos[j] - pos[i]
                r_mag = r.norm() + 1e-6  # 避免除以零
                r_hat = r.normalized()
                
                # 计算涡旋相互作用力
                gamma = vorticity[i] * vorticity[j] / (r_mag**2)
                
                # 手动计算垂直向量
                perpendicular_r_hat = ti.Vector([-r_hat[1], r_hat[0]])  # 计算垂直向量
                
                force += gamma * perpendicular_r_hat  # 涡旋相互作用

        # 更新速度
        velocity[i] += force * dt

# 更新粒子位置，加入周期性边界条件
'''
update_particles()：更新粒子的位置，并施加周期性边界条件，使粒子从一个边界出去后从另一个边界进入。
'''
@ti.kernel
def update_particles():
    for i in range(num_particles):
        # 更新位置
        pos[i] += velocity[i] * dt
        
        # 添加周期性边界条件
        pos[i][0] = (pos[i][0] + domain_size) % domain_size  # x方向周期性边界
        pos[i][1] = (pos[i][1] + domain_size) % domain_size  # y方向周期性边界

# 初始化粒子
initialize()

# 可视化设置
fig, ax = plt.subplots(figsize=(6, 6))
scat = ax.scatter([], [], s=1)
ax.set_xlim(0, domain_size)
ax.set_ylim(0, domain_size)
ax.set_aspect('equal', adjustable='box')

# 更新函数
def update(frame):
    # 计算力并更新粒子
    compute_forces()
    update_particles()
    
    # 获取粒子位置并更新可视化
    particle_positions = pos.to_numpy()
    scat.set_offsets(particle_positions)
    
    return scat,

# 创建动画，增大动画间隔，让粒子移动更慢
ani = FuncAnimation(fig, update, frames=1000, interval=50, blit=True)

# 显示动画
plt.show()
