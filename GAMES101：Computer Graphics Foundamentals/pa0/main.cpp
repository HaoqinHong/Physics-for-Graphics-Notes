#define _USE_MATH_DEFINES
#include <cmath>
#include <Eigen/Core>
#include <Eigen/Dense>
#include <iostream>

int main()
{

//     // Basic Example of cpp
//     std::cout << "Example of cpp \n";
//     float a = 1.0, b = 2.0;
//     std::cout << a << std::endl;
//     std::cout << a / b << std::endl;
//     std::cout << std::sqrt(b) << std::endl;
//     std::cout << std::acos(-1) << std::endl;
//     std::cout << std::sin(30.0 / 180.0 * acos(-1)) << std::endl;

//     // Output
//     // 1           // a
//     // 0.5         // a / b
//     // 1.41421     // sqrt(b)
//     // 3.14159     // arcos(-1)
//     // 0.5         // sin(30.0/180.0*acos(-1)) = sin(pi/6)

//     // Example of vector
//     // 如何定义一个三维浮点向量并且进行输出、加减、数乘
//     std::cout << "Example of vector \n";
//     // vector definition
//     Eigen::Vector3f v(1.0f, 2.0f, 3.0f); // 三维浮点向量
//     Eigen::Vector3f w(1.0f, 0.0f, 0.0f);

//     // vector output
//     std::cout << "Example of output \n";
//     std::cout << v << std::endl;

//     // Example of output
//     // 1
//     // 2
//     // 3

//     // vector add
//     std::cout << "Example of add \n";
//     std::cout << v + w << std::endl;

//     // Example of add
//     // 2
//     // 2
//     // 3

//     // vector scalar multiply
//     std::cout << "Example of scalar multiply \n";
//     std::cout << v * 3.0f << std::endl;
//     std::cout << 2.0f * v << std::endl;

//     // Example of scalar multiply
//     // 3
//     // 6
//     // 9

//     // 2
//     // 4
//     // 6

//     // Example of matrix
//     // 如何定义一个三维浮点矩阵进行输出
//     std::cout << "Example of matrix \n";
//     // matrix definition
//     Eigen::Matrix3f i, j;
//     i << 1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0, 9.0;
//     j << 2.0, 3.0, 1.0, 4.0, 6.0, 5.0, 9.0, 7.0, 8.0;

//     // matrix output
//     std::cout << "Example of output \n";
//     std::cout << i << std::endl;
//     std::cout << "\n" << j << std::endl;

//     // Output
//     // 1 2 3
//     // 4 5 6
//     // 7 8 9

//     // 2 3 1
//     // 4 6 5
//     // 9 7 8

//     // matrix add i + j
//     std::cout << "Matrix addition (i + j): \n" << i + j << std::endl;

//     // 3  5  4
//     // 8 11 11
//     // 16 15 17

//     // matrix scalar multiply i * 2.0
//     std::cout << "Matrix scalar multiply (i * 2.0): \n" << i * 2.0f << std::endl;

//     // 2  4  6
//     // 8 10 12
//     // 14 16 18

//     // matrix multiply i * j
//     std::cout << "Matrix multiply (i * j): \n" << i * j << std::endl;

//     // 37  36  35
//     // 82  84  77
//     // 127 132 119

//     // matrix multiply vector i * v
//     // (1 * 3) * (3 * 3) = (1 * 3)
//     std::cout << "Matrix multiply (i * v): \n" << i * v << std::endl;
    
//     // 14
//     // 32
//     // 50

    // 作业描述
    // 给定一个点 P=(2,1), 将该点绕原点先逆时针旋转 45◦, 再平移 (1,2), 计算出变换后点的坐标（要求用齐次坐标进行计算）。
    
    // 定义齐次坐标点 P
    Eigen::Vector3f P(2.0f, 1.0f, 1.0f);

    // 定义旋转矩阵
    Eigen::Matrix3f R;
    float theta = M_PI / 4; // 定义旋转角为 45◦
    R << cos(theta), -sin(theta),   0, 
         sin(theta),  cos(theta),   0,
                  0,           0,   1;
    
    // 定义平移矩阵
    Eigen::Matrix3f T;
    T << 1, 0, 1,
         0, 1, 2,
         0, 0, 1;


    // 变换后的点坐标
    // (1 * 3) * (3 * 3) = (1 * 3)
    std::cout << "Homogenous Coordinates: \n" << P << std::endl;
    std::cout << "Rotation Matrix: \n" << R << std::endl;
    std::cout << "Translation Matrix: \n" << T << std::endl;
    std::cout << "Transformation Result \n" << T * R * P << std::endl;

    return 0;
}