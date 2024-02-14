clear;
clc;
close all;

%% �������ݼ�
dt=0.1;
t=[0:dt:10];
N=length(t);
v_0=10;
a_0=2;
theta=pi/3;
px=v_0*cos(theta)*t+0.5*a_0*t.^2;
py=v_0*sin(theta)*t+0.5*a_0*t.^2;
%% �������
noise=1.5*randn(1,length(px));%��ֵΪ0 ����Ϊ2.25����̬�ֲ�
noise_px=px+noise; 
noise=1.5*randn(1,length(py));%��ֵΪ0 ����Ϊ2.25����̬�ֲ�
noise_py=py+noise; 

dataset=[px;py];
noise_dateset=[noise_px;noise_py];

% plot(dataset(1,:),dataset(2,:));
% hold on ;
% plot(noise_dateset(1,:),noise_dateset(2,:));
% legend('origin','noise')% ,' estimate'

%% ���ÿ������˲�����Ĳ���
%CAģ��
X=[noise_dateset(1,1);noise_dateset(2,1);0;0;0;0]; %��ʼ״̬ X=[λ��px;λ��py]
p_var=0.1;
P=diag(ones(1,6))*p_var; %״̬Э�������
rank=length(P);%�������
F=[   1 0 dt 0 dt^2/2 0;
      0 1 0 dt 0 dt^2/2;
      0 0 1 0 dt 0;
      0 0 0 1 0 dt;
      0 0 0 0 1 0;
      0 0 0 0 0 1 ]; %״̬ת�ƾ��� 
  
H=[1 0 0 0 0 0;
   0 1 0 0 0 0];%�������ṩ�Ĺ۲����

r_var=0.1;
R=diag(ones(1,2))*r_var;%�������Ĺ۲�����Э�������

q_var=0.01;
Q=diag(ones(1,6))*q_var; %״̬ת��Э�������

%% �������˲�
for i = 2:N 
  X_ = F*X(:,i-1); %������һ״̬Ԥ�⵱ǰ״̬  X_Ϊtʱ��״̬Ԥ��(����û�п���)
  P_ = F*P(:,rank*(i-1)-5:rank*(i-1))*F'+Q;%����Э����  Qϵͳ���̵�Э����
  %% ���㿨��������
  K = P_*H'/(H*P_*H'+R);
  %% ����
  X(:,i) = X_+K*(noise_dateset(:,i)-H*X_);% �õ���ǰ״̬�����Ż�����ֵ  ������Բв�
  P(:,rank*i-5:rank*i) = (eye(rank)-K*H)*P_;%����K״̬��Э���� 
end

%% ��ͼ
figure;
plot(dataset(1,:),dataset(2,:),'r-','LineWidth',1)
hold on;
plot(X(1,:),X(2,:),'g-','LineWidth',1.5); 
hold on;
plot(noise_dateset(1,:),noise_dateset(2,:),'b-','LineWidth',1)
xlabel('ʱ��/s'),ylabel('�˶����� m')
legend('measure','kalman','noise measure')
title('CVģ�Ϳ������˲�')
grid on %��ʾ���� 

