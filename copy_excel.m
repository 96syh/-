filename = 'C:\Users\86150\Desktop\1.xlsx';
% ��ȡ��Ϊ "ָ����ϸ����VD" �ı��
sheet = 'Sheet1';
% ��ȡ����
data = xlsread(filename, sheet);
% ��ȡ�ڶ��дӵڶ��е����һ��Ԫ��
column_1 = data(1:end, 4);%�׶β���1
column_2=data(1:end, 5);%�׶β���2
column_3=data(1:end, 6);%�׶β���3
column_4=data(1:end, 7);%�׶β���4
average_column=((column_1+column_2+column_3+column_4)/4)
average_column=round(average_column);
xlswrite('C:\Users\86150\Desktop\1.xlsx', average_column, 1, 'H4');
average_column=average_column*0.1;
train1=data(1:end, 9);%ʵѵ1
train2=data(1:end, 10);%ʵѵ2
train3=data(1:end, 11);%ʵѵ3
average_train=((train1+train2+train3)/3)
average_train=round(average_train);
xlswrite('C:\Users\86150\Desktop\1.xlsx',average_train, 1, 'L4');
average_train=average_train*0.1;
group1=data(1:end, 13);%С��1
group2=data(1:end, 14);%С��2
average_group=(group1+group2)/2
average_group=round(average_group);
xlswrite('C:\Users\86150\Desktop\1.xlsx',average_group, 1, 'O4');
average_group=average_group*0.1;
class=data(1:end, 16);%���ñ���
class=class*0.1;
result=data(1:end, 17)%���Գɼ�
result=result*0.6;
lastresult=class+result+average_group+average_train+average_column;
xlswrite('C:\Users\86150\Desktop\1.xlsx', lastresult, 1, 'R4');
score=60
examresult=((60-class-average_group-average_train-average_column))/0.6
examresult=round(examresult);
xlswrite('C:\Users\86150\Desktop\1.xlsx', examresult, 1, 'S4');

% ��ʾ���
%disp(column_2);
 %ȡ���ڶ����ж��е����һ��Ԫ��
 %���ļ�2��д�����ݵ���G2��
%xlswrite('E:\syh_work\CV22�����������\28.xlsx', column_2, 1, 'G2');
