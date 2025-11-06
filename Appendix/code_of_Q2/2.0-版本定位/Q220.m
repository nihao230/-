% 加载数据
load('signal_source_params.mat'); % 包含发射源参数
load('reception_case1_data.mat'); % 包含接收情况1的数据

% 提取接收数据
TOA1 = reception_case1_data(:, 1);
TOA4 = reception_case1_data(:, 2);
TDOA12 = reception_case1_data(:, 3);
TDOA34 = reception_case1_data(:, 4);
DFD12 = reception_case1_data(:, 5);
AOAtanalpha4 = reception_case1_data(:, 6);
AOAtanbeta4 = reception_case1_data(:, 7);
RSSI1 = reception_case1_data(:, 8);
RSSI2 = reception_case1_data(:, 9);
RSSI3 = reception_case1_data(:, 10);

% 光速
c = 3e8;

% 根据 TOA 计算距离
d1 = c * TOA1;
d4 = c * TOA4;

% 根据 TDOA 计算距离差
d12 = c * TDOA12;
d34 = c * TDOA34;

% 根据 DFD 计算相对速度
v12 = (DFD12 / f0) * c;

% 根据 RSSI 计算距离
r1 = r0 * (P0 ./ RSSI1).^(1/gamma);
r2 = r0 * (P0 ./ RSSI2).^(1/gamma);
r3 = r0 * (P0 ./ RSSI3).^(1/gamma);

% 使用 AOA 信息计算位置
% 假设接收源位置已知为 [xr, yr, zr]
xr = 0;
yr = 0;
zr = 0;

alpha = atan(AOAtanalpha4);
beta = atan(AOAtanbeta4);

% 根据 AOA 计算位置
x_aoa = d4 .* cos(alpha) .* cos(beta);
y_aoa = d4 .* sin(alpha) .* cos(beta);
z_aoa = -d4 .* sin(beta);

% 使用卡尔曼滤波进行位置估计
N = length(TOA1); % 数据点数
dt = time_interval; % 采样时间间隔

% 状态向量 [x; y; z; vx; vy; vz]
x = zeros(6, N);
x(:, 1) = [0; 0; 0; 0; 0; 0]; % 初始状态

% 状态转移矩阵
A = [1 0 0 dt 0 0;
     0 1 0 0 dt 0;
     0 0 1 0 0 dt;
     0 0 0 1 0 0;
     0 0 0 0 1 0;
     0 0 0 0 0 1];

% 观测矩阵（假设可以直接测量位置）
H = [1 0 0 0 0 0;
     0 1 0 0 0 0;
     0 0 1 0 0 0];

% 过程噪声协方差矩阵
Q = 0.01 * eye(6);

% 观测噪声协方差矩阵
R = 0.1 * eye(3);

% 预测误差协方差矩阵
P = eye(6);

% 使用接收情况1的观测数据进行估计
for k = 2:N
    % 预测步骤
    x(:, k) = A * x(:, k-1);
    P = A * P * A' + Q;
    
    % 计算观测值
    obs = [x_aoa(k); y_aoa(k); z_aoa(k)];
    
    % 更新步骤
    K = P * H' / (H * P * H' + R); % 卡尔曼增益
    x(:, k) = x(:, k) + K * (obs - H * x(:, k));
    P = (eye(6) - K * H) * P;
end

% 绘制结果
figure;
plot3(x(1, :), x(2, :), x(3, :), 'b', 'DisplayName', '估计轨迹');
hold on;
plot3(x_aoa, y_aoa, z_aoa, 'r--', 'DisplayName', '真实轨迹');
legend;
xlabel('X');
ylabel('Y');
zlabel('Z');
title('接收情况1的飞行器轨迹估计');
grid on
saveas(gcf,'问题2.0轨迹.jpg', 'jpeg')
;

% 导出估计轨迹到Excel表格
estimated_trajectory = x(1:3, :)'; % 提取 x, y, z 位置
writematrix(estimated_trajectory, 'Q2定位结果.xlsx', 'Sheet', 1, 'Range', 'A1');