cur1=load('D:\test_a1\move1.txt');
cur2  = load('D:\test_a1\move2.txt');
[zoomv,movev,rev] = CurveMatchEx2(cur1,cur2,1);%zoom�������죬movev��ƽ�ƣ�rev�Ƿ�ֵ�仯��������1�ǿ���������˼
% zoomv=1;
% movev=0;
[Z,M] = iterZoom(cur1,cur2,zoomv,movev);
a=size(cur1,1);
b=size(cur2,1);
c=Distance(cur1,a,cur2,b, Z ,M);
disp(c);
d=Distance(cur1,a,cur2,b, 1 ,0);
disp(d);
% fb1=fftshift(abs(fft([cur1;zeros(192-size(cur1,1),1)])));%fftshift,��Ƶ�׵���Ƶ�ʣ�ֱ��������λ��Ƶ�����������λ�á�
% fb2=fftshift(abs(fft([cur2;zeros(192-size(cur2,1),1)])));
%  figure;plot(fb1),hold all;plot(fb2)
% [zoom,move,rev] = CurveMatchEx2(fb1,fb2,1);
% 
% [zoomf,movef,rev] =CurveMatchEx2(diff(fb1),diff(fb2),1);
% 
% d=Distance(fb1,192,fb2,192, zoom ,move);
% %e=Distance(diff(fb1),192,diff(fb2),192, zoomf ,movef);
% %CurveMatchEx2(diff(fb1(97:120)),diff(fb2(97:120)),1);
% disp(d);
% disp(e);