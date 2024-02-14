data1=load('D:\test_a1\_1.txt');%深度学习数据
newData = [];
% 遍历原始数据
for i = 1:size(data1, 1)
   % if data1(i, 2)==5&&data1(i,5)>0
   if data1(i, 2) ==34;
        newData = [newData; data1(i, :)];  
    end
end
newData = newData(24:(end-0),:);
newData(:,5) = 2*newData(:,5);
subplot(2, 4, 1);
x1 = newData(:, 1);
y1 =newData(:, 5);
plot(x1, 1./y1);
% plot(1./(2*newData(:,5))),'r';hold on;plot(1./(newData2(:,5)),'b')


data2=load('D:\test_a1\_2.txt');%原定位数据
newData2 = [];
% 遍历原始数据
for i = 1:size(data2, 1)
     %if data2(i, 2) == 9&&data2(i, 6) == 1;
    if data2(i, 2) ==37;
        newData2 = [newData2; data2(i, :)];
    end
end
newData2 = newData2(9:(end-0),:);
subplot(2, 4, 2);
x2 = newData2(:, 1);
y2 =newData2(:, 5)
plot(x2, 1./y2);

subplot(2, 4, 3);
plot(x1,1./y1,'r',x2, 1./y2,'b');%红色加，蓝色未加

 data3=load('D:\test_a1\_3.txt');
newData3 = [];
% 遍历原始数据
for i = 1:size(data3, 1)
   %if data3(i, 2) == 26&&data3(i, 2) == 88;
   if data3(i, 2) == 65;
        newData3 = [newData3; data3(i, :)];
    end
end
newData3 = newData3(14:(end-0),:);
% %disp(newData);
% subplot(2, 4, 4);
x3 = newData3(:, 1);
y3 =newData3(:, 5)
plot(x3, 1./y3);%单possible结果
figure;plot(1./(newData(:,5)),'r');hold on;plot(1./(newData2(:,5)),'b');hold on;plot(1./(newData3(:,5)),'k');
newData4 = [];
for i = 1:size(newData2, 1)
   %if data3(i, 2) == 26&&data3(i, 2) == 88;
   if newData2(i, 8) == 0&&newData2(i, 6)==0 ;
        newData4 = [newData4; newData2(i, :)];
    end
end
%plot(1./(2*newData(:,5))),'r';hold on;plot(1./(newData2(:,5)),'b';hold on;plot(1./(newData3(:,5)));
% subplot(2, 4, 5);
% plot(x1,1./y1,'r',x2, 1./y2,'b',x3,1./y3,'g');
% 
% data5=load('D:\test_a1\18.txt');
% newData5 = [];
% % 遍历原始数据
% for i = 1:size(data5, 1)
%     %if data5(i, 2) == 9||data3(i, 2) == 100;
%     if data5(i, 2) == 5;
%         newData5 = [newData5; data5(i, :)];
%     end
% end
% newData5 = newData5(1:(end-6),:);
% x7 = newData5(:, 1);
% y7 =newData5(:, 5)
% subplot(2, 4, 7);
% plot(x7, 1./y7,'b')
%  subplot(2, 4, 5);
%  plot( x7,y7,'g',x3,y3,'r');%红色深度，蓝色locate
%  newData4=[];
%  for i = 1:size(newData3, 1)
%     %if data5(i, 2) == 9||data3(i, 2) == 100;
%     if newData3(i, 6) == 1&&newData3(i, 7)==0&&newData3(i, 8)==0;
%         newData4 = [newData4; newData3(i, :)];
%     end
%  end
% subplot(2, 4, 6);
% plot(x7,1./y7,'g',x3, 1./y3,'r');%hold on;plot(x7, y7,'b*');
% % data5=load('D:\test_a1\shujuku2.txt');%我的
% % newdata5=[];
% % for i = 1:size(data5, 1)
% %     if data5(i, 7) == 2
% %         newdata5 = [newdata5; data5(i, :)];
% %     end
% % end
% % subplot(2, 4, 7);
% % data5=load('D:\test_a1\shujuku2.txt');
% % x5 = data5(:, 1);
% % y5 =data5(:, 4);
% % plot(x2,1./y2,x3, 1./y3);
% % 
% % subplot(2, 4, 8);
% % data6=load('D:\test_a1\move1.txt');
% % x6 = data6(:, 1);
% % y6 =data6(:, 4);
% % plot(x1,1./y1,x3, 1./y3);
% % % % 读取第二个数据文件
% % % data2 = load('D:\test_a1\_1.txt');
% % % x2 = data2(:, 1);
% % % y2 = 2*data2(:, 5);
% % % plot(x2,y2);
% % % % data3 = load('D:\test_a1\_2.txt');
% % % % x3 = data3(:, 1);
% % % % y3 = 2*data3(:, 5);
% % % % 绘制两条曲线，并将它们叠加在同一张图上
% % % plot(x1, 1./y2, x2,1./y12);
% 
% 
