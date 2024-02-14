close all;
file_path = 'E:\syh_work\CV22距离曲线拟合\1.xlsx';
% 读取Excel文件
data = xlsread(file_path);
disp(data);
gt=data(:,1);
st=data(:,2);
gt9=data(:,5);
st9=data(:,6);
long=size(gt)-1
x = generateArray(long);
x=  x';
xx = 0:0.03:max(x);
xx= xx';
time=data(:,7);
[re,Mfitting,OrdAndVal] = GetCurvePoleAndFitting3B( st);
K=generate_quadratic_functions(Mfitting, st );
values=[];
for i = 1:size(st, 1)-1
       id=i;
    if(id>2)
        time3=time(id-1)-time(id-2);
        values1=K{i}(1);
        values1=1/(0.03*time3)*values1;
        values = [ values; values1];
    end;
%      values1=K{i}(1);
%      values = [ values; values1];
end
%values = moving_average(values, 30)
 figure (56); plot(values)
values = [ 0;values];
values = [ 0;values];
values = [ 0;values];
%values=values*30;
% values = values(10:(end-0),:);
% gt = gt(10:(end-0),:);
% st = st(10:(end-0),:);
% gt9 = gt9(10:(end-0),:);
t=0
gt= gt';
st= st';
values= values';
gt9= gt9';
 figure (4);plot(gt9);hold on;plot(values);
% 初始化状态向量
x = [0;0]; % [x, y, vx, vy]
P = eye(2); % 初始化状态协方差矩阵
A = [1 t ;0 1]; % 状态转移矩阵
H = [1 0 ; 
     0 1 ];% 观测矩阵
R = 300*eye(2); % 观测噪声协方差矩阵
Q = 0.3*eye(2); % 过程噪声协方差矩阵

% 模拟数据
T = size(gt, 2)-1; % 时间步数
true_position = gt;
true_velocity = gt9;

% 添加噪声
observation_noise = sqrt(R) * randn(2, T);
observation = cat(1, gt,values )%观测

% 卡尔曼滤波
filtered_position = zeros(2, T);
for t = 1:T
    % 预测步骤
    x = A * x;
    P = A * P * A' + Q;
    
    % 更新步骤
    K = (P * H')/(H * P * H' + R);
    x = x + K * (observation(:, t) - H * x);
    P = (eye(2) - K * H) * P;
    
    % 存储滤波后的位置
    filtered_position(:, t) = x(1:2);
end
ds=filtered_position(2,:)'
ds = [ ds;0.02];
ds= ds';
 figure (5);plot(ds,'g');hold on;plot(values,'r');
 figure (11);plot(xx, gt9);
  figure (13);plot(xx, ds);
 figure (12);plot(xx, gt9,'g');hold on;plot(xx, ds,'r');hold on;plot(xx, st9,'b')

