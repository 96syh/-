%data:1 ��ֵ������룬2�㷨������룬3 ������������� 4������������5 ��ֵ�����ٶȣ�6�㷨�����ٶ�
close all;
clear all;
file_path = 'E:\syh_work\CV22�����������\12.xlsx';
data = xlsread(file_path);
disp(data);
gt=data(:,1);
st=data(:,2);
gt9=data(:,5);
st9=data(:,6);
% 
% start=10;
% % %end2=489;
% end1=615;
% gt =  gt(start:end,:);
% st =  st(start:end,:);
% st9 =  st9(start:end,:);
% gt9 =  gt9(start:end,:);
% figure (1);plot(gt,'r');hold on;plot(st,'b')

 %���������
long=size(gt)-1
x = generateArray(long);
x=  x';
k = getparabola1(gt,x);
 a = k(1);
 b = k(2);
 c = k(3);
fprintf('��ϵ������߷���Ϊ: y = %.2fx^2 + %.2fx + %.2f\n', a, b, c);
n = length(st);  
m = floor(n / 10);  
new_x = zeros(1, m);  
for i = 1:m
    idx = (i-1)*10+1  
    new_x(i) = st(idx);  
end

% ʹ��linspace�����µ�xx
% xx = linspace(min(myArray), max(myArray), numPoints);
% xx=xx';
%xx = linspace(min( myArray), max( myArray), 695); % �������ڻ������ߵ�xֵ
xx = 0:0.03:max(x);
yy = a * xx.^2 + b * xx + c; % �����Ӧ��yֵ
% figure (2);plot(xx,gt);hold on;plot(xx, yy, '-');
% figure (3);plot(xx, yy, '-'); % ����ԭʼ���ݵ���������
legend('���������');
xx= xx';
%B������ֵ
 ss=st
[re,Mfitting,OrdAndVal] = GetCurvePoleAndFitting3B( ss);
K=generate_quadratic_functions(Mfitting, ss );
values=[];
for i = 1:size(ss, 1)-1
     values1=K{i}(1);
     values = [ values; values1];
end
values = moving_average(values, 300)
% figure (56); plot(values)
values = [ values;0];
wucha=gt9-values;
%  best_delay=-4;
%  values=circshift(values, best_delay)
  figure (5);plot(xx, gt9);hold on;plot(xx, st9);hold on;plot(xx,values*30,'k');
%figure (6);plot(xx,gt);hold on; plot(xx+1,OrdAndVal(:,2));
%figure (7);plot(xx,gt);hold on; plot(xx,values);
 ss2=gt
[re,Mfitting2,OrdAndVal] = GetCurvePoleAndFitting3B( ss2);
K2=generate_quadratic_functions(Mfitting2, ss2 );
values2=[];
for i = 1:size(ss, 1)-1
     values12=K2{i}(1);
     values2 = [ values2; values12];
end
values2 = moving_average(values2, 30)
values2 = [ values2;0];
  figure (6);plot(xx, gt9);hold on;plot(xx, st9);hold on;plot(xx,values2*30,'k');
%%˲ʱ�仯�ʷ�
%  n = length(xx);
%  y=gt;
% first_derivative = zeros(1, n);
% for i = 2:n-1
%         h_i = xx(i+1) - xx(i-1);
%         first_derivative(i) = (y(i+1) - y(i-1)) / (2*h_i);
% end
% disp(first_derivative );
% first_derivative=  first_derivative';
% first_derivative(1)=gt9(1);
%  figure (4);plot(xx,first_derivative);hold on;plot(xx, gt9, '-');hold on;plot(xx, st9, '-');


% 
%  %������ֵ��
% pp = spline(xx, gt);
% coefficients=pp.coefs;
% newdata=[];
% newdata = gt(1:(end-0),:);
%  % ����һ�������3x20ϵ������
% quadratic_functions = generate_quadratic_functions(coefficients,newdata );
% start_value = 0;
% increment = 0.03;
% array_size = 694;
%  values=[];
% for i = 1:694
%      values1=quadratic_functions{i}(0.03*(i-1));
%      values = [ values; values1];
% end
%  figure (56); plot(values)
% % ��������
% x_values = linspace(-10, 10, 6941); % ����һЩ x ֵ
% y_values = quadratic_functions{1}(x_values);
% figure (16);plot(x_values, y_values);
% % 
% % %K=S(:,1)+S(:,2)*(a-newData )+S(:,3)*(a-newData )^2+S(:,4)*(a-newData )^3;
% % %K=S(;,1)+
% % % ����������ֵ���ߵ�һ�׵���
% % pp_derivative = fnder(pp, 1);
% % % ��ָ����xֵ������һ�׵���
% % x_value = 3; % ָ����xֵ
% % y_derivative = ppval(pp_derivative, xx);
% % y_derivative=  y_derivative';


% xx2 = 0:0.03:max(x);
%  n1 = length(xx2);
%  y1=OrdAndVal(:,2);
% derivative = zeros(1, n);
% for i = 2:n-1
%         h_i = xx2(i+1) - xx2(i-1);
%        derivative(i) = (y1(i+1) - y1(i-1)) / (2*h_i);
% end
% disp(derivative );
% derivative= derivative';
% derivative(1)=gt9(1);
% smoothed_data = moving_average(derivative, 3)
% % nn = length(derivative); 
% % m = floor(nn / 5); 
% % for i = 1:m
% %     idx = (i-1)*5+1 : i*5;  
% %     avg = mean(derivative(idx));  
% %     derivative(idx) = avg;  
% % end
%  figure (5);plot(xx,first_derivative);hold on;plot(xx, gt9);hold on;plot(xx, st9);hold on;plot( derivative);
% figure (7);plot(xx,gt);hold on; plot(xx-0.03,OrdAndVal(:,2));
% y_double_prime = diff(gt, x, 2);
% 
% % ������׵���
% disp('���׵���Ϊ��');
% disp(y_double_prime);
