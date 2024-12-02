import taichi as ti
import numpy as np

# 配置 Taichi
ti.init(arch=ti.gpu)  # 使用 GPU 加速，也可以切换为 ti.cpu

# 粒子数目
num_particles = 1000

# 粒子的物理属性
particle_position = ti.Vector.field(2, dtype=ti.f32, shape=num_particles)
particle_velocity = ti.Vector.field(2, dtype=ti.f32, shape=num_particles)
particle_vorticity = ti.field(dtype=ti.f32, shape=num_particles)

# 粒子之间的相互作用力常数（可以调节）
vortex_strength = 10.0

# 初始化粒子
@ti.kernel
def initialize_particles():
    for i in range(num_particles):
        particle_position[i] = [ti.random() * 2.0 - 1.0, ti.random() * 2.0 - 1.0]  # 随机位置
        particle_velocity[i] = [0.0, 0.0]  # 初始速度为零
        particle_vorticity[i] = vortex_strength * ti.sin(particle_position[i].x * 10.0)  # 根据位置初始化涡旋强度

# 计算涡旋对粒子的速度影响
@ti.kernel
def compute_vortex_velocity():
    for i in range(num_particles):
        velocity = ti.Vector([0.0, 0.0])
        for j in range(num_particles):
            if i != j:
                r_ij = particle_position[i] - particle_position[j]
                distance = r_ij.norm()  # 计算距离
                if distance > 1e-5:  # 避免除以零
                    r_hat = r_ij / distance
                    velocity += particle_vorticity[j] * r_hat / (distance ** 2)  # 涡旋引力计算
        particle_velocity[i] = velocity

# 更新粒子位置
@ti.kernel
def update_position(dt: ti.f32):
    for i in range(num_particles):
        particle_position[i] += particle_velocity[i] * dt  # 根据速度更新位置

# 更新涡旋强度（局部扩散模型）
@ti.kernel
def update_vorticity(dt: ti.f32):
    for i in range(num_particles):
        diffusion = 0.0
        for j in range(num_particles):
            if i != j:
                r_ij = particle_position[i] - particle_position[j]
                distance = r_ij.norm()
                if distance > 1e-5:
                    diffusion += particle_vorticity[j] * (1.0 / distance)  # 扩散计算
        particle_vorticity[i] += 0.01 * diffusion * dt  # 扩散系数控制涡旋的扩散程度

# 主循环，更新粒子
def run_simulation(dt: float, num_steps: int):
    for step in range(num_steps):
        # 计算涡旋速度
        compute_vortex_velocity()
        # 更新位置
        update_position(dt)
        # 更新涡旋强度
        update_vorticity(dt)
        
        # 打印一些信息以观察模拟进程
        if step % 50 == 0:
            print(f"Step {step}: Position[0] = {particle_position[0]}")

# 初始化粒子
initialize_particles()

# 运行模拟
run_simulation(dt=0.01, num_steps=500)
