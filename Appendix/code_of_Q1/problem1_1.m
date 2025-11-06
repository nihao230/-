% 发射源位置
src_pos = [100, 300, 50; 
           1000, 100, 150;
           -1000, -100, 450;
           -200, -100, 1050];
 
%发射源速度参数
src_vel = [0, 0, 0;
           0, 0, 0; 
           0, 0, 8;
           20, 0, 0];
       
% 其他参数
c = 3e8; % 光速
f0 = 3e8; % 发射频率
gamma = 20; % 信道衰减系数
P0 = 100; % 标称信号强度
r0 = 1000; % 标称距离
time_interval = 0.01; % 接收采样间隔时间

% 将其保存为mat文件
save('signal_source_params.mat','src_pos','src_vel','c','f0','gamma','P0','r0','time_interval');