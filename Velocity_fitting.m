close all;
clear all;
file_path = 'E:\syh_work\CV22前车减速摆拍距离曲线\1\27.xlsx';
% 读取Excel文件
data = xlsread(file_path);
% 显示读取的数据
start=982
end2=start+1;
end1=1253
%data(927:942)=[];
%end2=end1;
weizhi=data(:,1);
qishi=weizhi(start,:);
zhongjian=weizhi(end2,:);
zuihou=weizhi(end1,:);
 file_path = 'E:\syh_work\CV22距离曲线拟合\27.xlsx';
data1 = xlsread(file_path);

%data1(927:942)=[];
gt1=data1(:,1);
st1=data1(:,2);
gt91=data1(:,5);
st91=data1(:,6);
time=data1(:,7);
 figure (1);plot(data(:,2)),'b';hold on;plot(data(:,3),'r')
 v_true=data(:,2);
v_true =  v_true(start:end1,:);
  v_measured=data(:,3);
 v_measured =    v_measured(start:end1,:);
 figure (2);plot(v_true(:,1)),'b';hold on;plot(v_measured(:,1),'r')
 frameid=data(:,1);
 frameid= frameid(start:end1,:);%id
 gt9=data(:,2);
 gt9=gt9(start:end1,:);%真值纵向速度
 st9=data(:,3);
 st9=st9(start:end1,:);%算法纵向速度
 x9=data(:,4);
 x9=x9(start:end1,:);%绝对误差
 X9=data(:,5);
 X9= X9(start:end1,:);%相对误差
% time=time(start:end1,:)
%创建一个时间轴（假设时间步长为1）
t = 1:length(v_true);
v_truek=data(:,2);
v_truek =  v_truek(start:end2,:);
v_measuredk=data(:,3);
v_measuredk=  v_measuredk(start:end2,:);


% 计算交叉相关
[acor, lag] = xcorr( v_truek,v_measuredk);

% 找到最大相关性和对应的延迟
[~, idx] = max(abs(acor));
best_delay = lag(idx);
% if(best_delay>10||best_delay<-20)
%     best_delay=1;
% end;
                                          best_delay=0
%画出交叉相关函数
%figure (3);plot(lag, acor);
% title('交叉相关函数');
% xlabel('Lag');
% ylabel('Correlation');
% 画出原始速度曲线和经过延迟匹配后的速度曲线
%figure;
figure (4);plot(t, v_true, 'b', t, circshift(v_measured, best_delay), 'r');
title('延迟后曲线对比');
xlabel('Time');
ylabel('Velocity');
legend('真值', '算法');
vwucha=circshift(v_measured, best_delay)- v_true;%延迟后误差
 %figure (5);plot(t,v_true(:,1)),'b';hold on;plot(t,v_measured(:,1),'r')
% gt1 =  gt1(start:end1,:);
% st1 =  st1(start:end1,:);
% st91 =  st91(start:end1,:);
% gt91 =  gt91(start:end1,:);
ss=st1;
long=size(gt9)-1
x = generateArray(long);
x=  x';
xx = 0:0.03:max(x);
xx= xx';
 [re,Mfitting,OrdAndVal] = GetCurvePoleAndFitting3B( ss);
K=generate_quadratic_functions(Mfitting, ss );
values=[];
for i = 2:size(ss, 1)-1
    time2=time(i)-time(i-1);
     values1=K{i}(1);
     values1=1/(0.03*time2)*values1;
     %values1=1/(0.03)*values1;
     values = [ values; values1];
     
end
% n = length(xx);
%  y=values;
% first_derivative = zeros(1, n);
% for i = 2:n-1
%     time2=time(i+1)-time(i);
%         h_i(i) = (xx(i+1) - xx(i-1))*(time2);
%         first_derivative(i) = (y(i+1) - y(i-1)) /  2*h_i(i);
% end
values = moving_average(values, 30)

% first_derivative=first_derivative'
%first_derivative = moving_average(first_derivative, 30);
values = [ values;0];
figure (56); plot(values);hold on;plot(st1);
values=values(start:end1,:);
swucha=-gt9+values;

ss2=gt1;
 [re,Mfitting2,OrdAndVal2] = GetCurvePoleAndFitting3B( ss2);
K2=generate_quadratic_functions(Mfitting2, ss2 );
values2=[];
for i = 1:size(ss2, 1)-1
    %i=1351;
    id=i;
    if(id>2)
        time3=time(id-1)-time(id-2);
        values12=K2{i}(1);
        %values12=1/(0.03*time3)*values12;
        %values12=1/(0.03)*values12;
        values2 = [ values2; values12];
    end;
end
values2 = moving_average(values2, 50)
figure (57); plot(values2)
values2 = [ values2;0];
values2=values2(start:end1,:);
swucha2=-gt9+values2*30;
 figure (5);plot(xx, gt9);hold on;plot(xx, st9);hold on;plot(xx,30*values2,'k');
 legend('真值速度', '算法速度','真值拟合速度');
  figure (6);plot(xx, gt9);hold on;plot(xx, st9);hold on;plot(xx,values,'k');
  legend('真值速度', '算法速度','算法拟合速度');
    figure (7);plot(gt1);hold on;plot(st1);
     legend('真值距离', '算法距离');
   %figure (7);plot(xx, gt9);hold on;plot(xx, st9);hold on;plot(xx,300*first_derivative,'k');
%id,真值速度，算法速度，绝对误差，相对误差，延迟后速度误差，算法距离算速度误差。真值算速度误差
 combined_array = horzcat( frameid, gt9, st9, x9,vwucha,swucha,swucha2);
 combined_array =   combined_array(2:(end-2),:);
 average=horzcat( x9,vwucha,swucha,swucha2 )
 average =   average(2:(end-2),:);
 average_value = mean( average);
 
 %写帧数
 array1 = horzcat(start, end1, qishi, zuihou);
% fileID = fopen('D://test_a1//frameid.txt', 'a'); % 注意这里使用 'a' 以进行追加
% 
% for i = 1:size(array1, 1)
%     fprintf(fileID, '%d %d %d %d\n', array1(i, :));
% end
% fclose(fileID);
% disp(best_delay);
% 指定文件夹路径
% folder_path = 'E:\syh_work\CV22距离曲线拟合\creat\27';
% 
% % 检查文件夹是否存在，如果不存在则创建
% if ~exist(folder_path, 'dir')
%     mkdir(folder_path);
% end
% 
% % 保存图形到指定文件夹
% saveas(figure(5), [folder_path '真值拟合.png']);
% saveas(figure(6), [folder_path '算法拟合.png']);
% saveas(figure(7), [folder_path '距离曲线.png']);

