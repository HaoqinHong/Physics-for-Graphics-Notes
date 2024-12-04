// 本次作业的任务是填写一个旋转矩阵和一个透视投影矩阵。
// 给定三维下三个点 v0(2.0,0.0,−2.0), v1(0.0,2.0,−2.0), v2(−2.0,0.0,−2.0),
// 你需要将这三个点的坐标变换为屏幕坐标并在屏幕上绘制出对应的线框三角形

#include "Triangle.hpp"
#include "rasterizer.hpp"
#include <Eigen/Eigen>
#include <iostream>
#include <opencv2/opencv.hpp>

constexpr double MY_PI = 3.1415926;

Eigen::Matrix4f get_view_matrix(Eigen::Vector3f eye_pos)
{
    Eigen::Matrix4f view = Eigen::Matrix4f::Identity(); // 用 Eigen 库创建和初始化 4x4 矩阵

    Eigen::Matrix4f translate;
    translate << 1, 0, 0, -eye_pos[0], 0, 1, 0, -eye_pos[1], 0, 0, 1,
        -eye_pos[2], 0, 0, 0, 1;

    view = translate * view;

    return view;
}

// 逐个元素地构建模型变换矩阵并返回该矩阵。
// 在此函数中，你只需要实现三维中绕 z 轴旋转的变换矩阵，而不用处理平移与缩放。
Eigen::Matrix4f get_model_matrix(float rotation_angle)
{
    Eigen::Matrix4f model = Eigen::Matrix4f::Identity();

    // TODO: Implement this function
    // Create the model matrix for rotating the triangle around the Z axis.
    // Then return it.
    Eigen::Matrix4f Rotate;

    rotation_angle = rotation_angle *  MY_PI / 180.0f; // 将角度制转换为弧度制

    // z 轴不发生变化 cross(x, y) = z 
    Rotate << cos(rotation_angle), -sin(rotation_angle), 0, 0,
              sin(rotation_angle),  cos(rotation_angle), 0, 0,
                                0,                    0, 1, 0,
                                0,                    0, 0, 1;
     
    model = Rotate * model;

    return model;
}

// 使用给定的参数逐个元素地构建透视投影矩阵并返回该矩阵。
// eye_fov: 垂直可视角度      tan(eye_fov/2) = t/n
// aspect_ratio ： 宽高比     aspect_ratio = r/t
Eigen::Matrix4f get_projection_matrix(float eye_fov, float aspect_ratio,
                                      float zNear, float zFar)
{
    // Students will implement this function

    Eigen::Matrix4f projection = Eigen::Matrix4f::Identity();

    // TODO: Implement this function
    // Create the projection matrix for the given parameters.
    // Then return it.

    // 计算 t 和 r
    float angle = eye_fov * MY_PI / 180.0f; 
    float t = tan(angle / 2) * zNear;       // b = -t
    float r = aspect_ratio * t;             // l = -r
    float b = -t;
    float l = -r;

    // cross(x, y) = -z 所以应该以 z 的负方向为朝向
    zNear = -zNear; 
    zFar = - zFar;

    Eigen::Matrix4f M_perspective2orthographic, M_orthographic_translate, M_orthographic_scale;
    // 透视投影到正交投影
    M_perspective2orthographic << zNear,            0,             0,                   0,
                                      0,        zNear,             0,                   0,
                                      0,            0,  zNear + zFar,     -(zNear * zFar),
                                      0,            0,             1,                   0;
    
    // 正交投影：平移
    M_orthographic_translate << 1,   0,   0,        -(r + l) / 2,
                                0,   1,   0,        -(t + b) / 2,
                                0,   0,   1, -(zNear + zFar) / 2,
                                0,   0,   0,                   1;
    
    // 正交投影：缩放
    M_orthographic_scale << 2 / (r - l),              0,                   0,          0,
                                      0,    2 / (t - b),                   0,          0,
                                      0,              0,  2 / (zFar - zNear),          0,
                                      0,              0,                   0,          1;

    projection = M_orthographic_scale * M_orthographic_translate * M_perspective2orthographic * projection;

    return projection;
}

int main(int argc, const char** argv)
{
    float angle = 0;
    bool command_line = false;
    std::string filename = "output.png";

    if (argc >= 3) {
        command_line = true;
        angle = std::stof(argv[2]); // -r by default
        if (argc == 4) {
            filename = std::string(argv[3]);
        }
        else
            return 0;
    }

    rst::rasterizer r(700, 700);

    Eigen::Vector3f eye_pos = {0, 0, 5};

    std::vector<Eigen::Vector3f> pos{{2, 0, -2}, {0, 2, -2}, {-2, 0, -2}};

    std::vector<Eigen::Vector3i> ind{{0, 1, 2}};

    auto pos_id = r.load_positions(pos);
    auto ind_id = r.load_indices(ind);

    int key = 0;
    int frame_count = 0;

    if (command_line) {
        r.clear(rst::Buffers::Color | rst::Buffers::Depth);

        r.set_model(get_model_matrix(angle));
        r.set_view(get_view_matrix(eye_pos));
        r.set_projection(get_projection_matrix(45, 1, 0.1, 50));

        r.draw(pos_id, ind_id, rst::Primitive::Triangle);
        cv::Mat image(700, 700, CV_32FC3, r.frame_buffer().data());
        image.convertTo(image, CV_8UC3, 1.0f);

        cv::imwrite(filename, image);

        return 0;
    }

    while (key != 27) {
        r.clear(rst::Buffers::Color | rst::Buffers::Depth);

        r.set_model(get_model_matrix(angle));
        r.set_view(get_view_matrix(eye_pos));
        r.set_projection(get_projection_matrix(45, 1, 0.1, 50));

        r.draw(pos_id, ind_id, rst::Primitive::Triangle);

        cv::Mat image(700, 700, CV_32FC3, r.frame_buffer().data());
        image.convertTo(image, CV_8UC3, 1.0f);
        cv::imshow("image", image);
        key = cv::waitKey(10);

        std::cout << "frame count: " << frame_count++ << '\n';

        if (key == 'a') {
            angle += 10;
        }
        else if (key == 'd') {
            angle -= 10;
        }
    }

    return 0;
}
