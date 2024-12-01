import taichi as ti
import taichi.math as tm

# 初始化 Taichi，选择 GPU 进行计算
ti.init(arch=ti.gpu)

# 定义分形图像的分辨率
n = 320
# 创建一个像素字段，用于存储每个像素的值（灰度值）
pixels = ti.field(dtype=float, shape=(n * 2, n))

# 计算复数平方的函数
@ti.func
def complex_sqr(z):  # 计算二维向量的复数平方
    return tm.vec2(z[0] * z[0] - z[1] * z[1], 2 * z[0] * z[1])

# 渲染每一帧的函数
@ti.kernel
def paint(t: float):
    for i, j in pixels:  # 对每个像素并行处理
        c = tm.vec2(-0.8, tm.cos(t) * 0.2)  # Julia 集的常数 c
        z = tm.vec2(i / n - 1, j / n - 0.5) * 2  # 每个像素的初始复数值（映射到复平面）
        iterations = 0
        # 迭代计算直到达到收敛或迭代次数上限
        while z.norm() < 20 and iterations < 50:
            z = complex_sqr(z) + c  # 进行复数迭代
            iterations += 1
        # 根据迭代次数计算灰度值，越多迭代则颜色越浅
        pixels[i, j] = 1 - iterations * 0.02

# 创建 GUI 窗口，显示分形图像
gui = ti.GUI("Julia Set", res=(n * 2, n))

i = 0
# 循环渲染图像并展示
while gui.running:
    paint(i * 0.03)  # 更新分形图像
    gui.set_image(pixels)  # 将图像传递给 GUI
    gui.show()  # 显示当前图像
    i += 1  # 增加时间步长，使动画循环
