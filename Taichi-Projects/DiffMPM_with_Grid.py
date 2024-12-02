import taichi as ti
import numpy as np
import matplotlib.pyplot as plt
from matplotlib.animation import FuncAnimation

'''
MPM的可微性：在大多数情况下，MPM方法的粒子到网格的映射、网格力计算、粒子更新都是可微的，
尤其是当物理模型和网格粒子设置合理时。但需要注意的是，如果粒子数过少、网格过粗或存在不连续的物理模型，可能会影响可微性。
'''

'''
1.初始化粒子（位置、速度、质量等）。
2.将粒子的位置和速度映射到网格。
3.计算网格上的力（如弹性力、外力）。
4.更新粒子的速度和位置。
5.通过网格计算力的影响并更新网格的物理量（如压力、应力）。
'''
# Taichi初始化
ti.init(arch=ti.gpu)

# 参数设置
num_particles = 1000  # 粒子数量
dt = 5e-6  # 时间步长
domain_size = 1.0  # 模拟区域大小
grid_size = 64     # 网格大小
particle_radius = 0.01  # 粒子半径

# 创建字段
pos = ti.Vector.field(2, dtype=ti.f32, shape=num_particles)  # 粒子位置
vel = ti.Vector.field(2, dtype=ti.f32, shape=num_particles)  # 粒子速度
mass = ti.field(dtype=ti.f32, shape=num_particles)  # 粒子质量

# 网格相关
grid_mass = ti.field(dtype=ti.f32, shape=(grid_size, grid_size))  # 网格上的质量
grid_vel = ti.Vector.field(2, dtype=ti.f32, shape=(grid_size, grid_size))  # 网格上的速度

# 初始化粒子
@ti.kernel
def initialize():
    for i in range(num_particles):
        pos[i] = ti.Vector([ti.random() * domain_size, ti.random() * domain_size])
        vel[i] = ti.Vector([0.0, 0.0])
        mass[i] = 1.0  # 设置粒子质量为1.0

# 将粒子映射到网格
@ti.kernel
def map_particles_to_grid():
    for i in range(num_particles):
        grid_x = int(pos[i][0] * grid_size / domain_size)
        grid_y = int(pos[i][1] * grid_size / domain_size)
        
        # 使用加权方式将粒子质量和速度映射到网格
        grid_mass[grid_x, grid_y] += mass[i]
        grid_vel[grid_x, grid_y] += vel[i] * mass[i]

# 计算网格上的力（此处简单的假设外力）
@ti.kernel
def compute_forces():
    for i, j in grid_mass:
        if grid_mass[i, j] > 0:
            grid_vel[i, j] *= 0.99  # 模拟黏性阻尼
            grid_vel[i, j] += ti.Vector([0.0, -0.1])  # 施加重力（向下）

# 更新粒子位置和速度
@ti.kernel
def update_particles():
    for i in range(num_particles):
        grid_x = int(pos[i][0] * grid_size / domain_size)
        grid_y = int(pos[i][1] * grid_size / domain_size)
        
        # 通过网格的速度更新粒子位置
        vel[i] = grid_vel[grid_x, grid_y]
        pos[i] += vel[i] * dt

# 可视化设置
fig, ax = plt.subplots(figsize=(6, 6))
scat = ax.scatter([], [], s=1)
ax.set_xlim(0, domain_size)
ax.set_ylim(0, domain_size)
ax.set_aspect('equal', adjustable='box')

# 更新函数
def update(frame):
    # 粒子映射到网格
    map_particles_to_grid()

    # 计算网格力
    compute_forces()

    # 更新粒子
    update_particles()

    # 获取粒子位置并更新可视化
    particle_positions = pos.to_numpy()
    scat.set_offsets(particle_positions)
    
    return scat,

# 初始化粒子
initialize()

# 创建动画
ani = FuncAnimation(fig, update, frames=1000, interval=50, blit=True)

# 显示动画
plt.show()
