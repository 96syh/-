clear;
clc;
close all;

%% 构建数据集
dt=0.1;
t=[0:dt:10];
N=length(t);
v_0=10;
a_0=2;
theta=pi/3;
px=v_0*cos(theta)*t+0.5*a_0*t.^2;
py=v_0*sin(theta)*t+0.5*a_0*t.^2;
%% 添加噪声
noise=1.5*randn(1,length(px));%均值为0 方差为2.25的正态分布
noise_px=px+noise; 
noise=1.5*randn(1,length(py));%均值为0 方差为2.25的正态分布
noise_py=py+noise; 

dataset=[px;py];
noise_dateset=[noise_px;noise_py];

% plot(dataset(1,:),dataset(2,:));
% hold on ;
% plot(noise_dateset(1,:),noise_dateset(2,:));
% legend('origin','noise')% ,' estimate'

%% 设置卡尔曼滤波矩阵的参数
%CA模型
X=[noise_dateset(1,1);noise_dateset(2,1);0;0;0;0]; %初始状态 X=[位置px;位置py]
p_var=0.1;
P=diag(ones(1,6))*p_var; %状态协方差矩阵
rank=length(P);%矩阵的秩
F=[   1 0 dt 0 dt^2/2 0;
      0 1 0 dt 0 dt^2/2;
      0 0 1 0 dt 0;
      0 0 0 1 0 dt;
      0 0 0 0 1 0;
      0 0 0 0 0 1 ]; %状态转移矩阵 
  
H=[1 0 0 0 0 0;
   0 1 0 0 0 0];%传感器提供的观测矩阵

r_var=0.1;
R=diag(ones(1,2))*r_var;%传感器的观测噪声协方差矩阵

q_var=0.01;
Q=diag(ones(1,6))*q_var; %状态转移协方差矩阵

%% 卡尔曼滤波
for i = 2:N 
  X_ = F*X(:,i-1); %基于上一状态预测当前状态  X_为t时刻状态预测(这里没有控制)
  P_ = F*P(:,rank*(i-1)-5:rank*(i-1))*F'+Q;%更新协方差  Q系统过程的协方差
  %% 计算卡尔曼增益
  K = P_*H'/(H*P_*H'+R);
  %% 更新
  X(:,i) = X_+K*(noise_dateset(:,i)-H*X_);% 得到当前状态的最优化估算值  增益乘以残差
  P(:,rank*i-5:rank*i) = (eye(rank)-K*H)*P_;%更新K状态的协方差 
end

%% 绘图
figure;
plot(dataset(1,:),dataset(2,:),'r-','LineWidth',1)
hold on;
plot(X(1,:),X(2,:),'g-','LineWidth',1.5); 
hold on;
plot(noise_dateset(1,:),noise_dateset(2,:),'b-','LineWidth',1)
xlabel('时间/s'),ylabel('运动距离 m')
legend('measure','kalman','noise measure')
title('CV模型卡尔曼滤波')
grid on %显示网格 

