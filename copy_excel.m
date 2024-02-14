filename = 'C:\Users\86150\Desktop\1.xlsx';
% 读取名为 "指标详细数据VD" 的表格
sheet = 'Sheet1';
% 读取数据
data = xlsread(filename, sheet);
% 提取第二列从第二行到最后一个元素
column_1 = data(1:end, 4);%阶段测试1
column_2=data(1:end, 5);%阶段测试2
column_3=data(1:end, 6);%阶段测试3
column_4=data(1:end, 7);%阶段测试4
average_column=((column_1+column_2+column_3+column_4)/4)
average_column=round(average_column);
xlswrite('C:\Users\86150\Desktop\1.xlsx', average_column, 1, 'H4');
average_column=average_column*0.1;
train1=data(1:end, 9);%实训1
train2=data(1:end, 10);%实训2
train3=data(1:end, 11);%实训3
average_train=((train1+train2+train3)/3)
average_train=round(average_train);
xlswrite('C:\Users\86150\Desktop\1.xlsx',average_train, 1, 'L4');
average_train=average_train*0.1;
group1=data(1:end, 13);%小组1
group2=data(1:end, 14);%小组2
average_group=(group1+group2)/2
average_group=round(average_group);
xlswrite('C:\Users\86150\Desktop\1.xlsx',average_group, 1, 'O4');
average_group=average_group*0.1;
class=data(1:end, 16);%课堂表现
class=class*0.1;
result=data(1:end, 17)%考试成绩
result=result*0.6;
lastresult=class+result+average_group+average_train+average_column;
xlswrite('C:\Users\86150\Desktop\1.xlsx', lastresult, 1, 'R4');
score=60
examresult=((60-class-average_group-average_train-average_column))/0.6
examresult=round(examresult);
xlswrite('C:\Users\86150\Desktop\1.xlsx', examresult, 1, 'S4');

% 显示结果
%disp(column_2);
 %取出第二列中二行到最后一个元素
 %在文件2中写入数据到第G2行
%xlswrite('E:\syh_work\CV22距离曲线拟合\28.xlsx', column_2, 1, 'G2');
