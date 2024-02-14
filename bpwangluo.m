close all;

X = cur1;

[re,Mfitting,OrdAndVal] = GetCurvePoleAndFitting3B(cur1);

num = size(OrdAndVal,1);

J = 2000;

scale = randi([400,2500],J,1)/1000;

maxn = 10;

pn = size(re,1);

P = zeros(maxn*3,J);

Y = zeros(maxn,J);

epoint1 = 4;

epoint2 = 10;

for i = 1:J

  tmp = randn(1,pn);

  [~,a] = sort(tmp);

  a = a(1:maxn);

  a = sort(a);

  q = re(:,1)*scale(i) + randi([-30,30],1,1) + 0.1*randn(pn,1);

  tmp1 = q(a);

  tmp2 = re(a,2) + randn(maxn,1)/50;

  tmp3 = (re(a,3)-0.5)*2;

  tmp4 = (re(a,4)+randn(maxn,1)/100).*tmp3;

  P(:,i) = reshape([tmp1,tmp2,tmp4]',1,[]);

  Y(:,i) = (tmp1 - q(epoint1))/(q(epoint2)-q(epoint1));

end

En = 1000;

S1 = P(:,1:En);

Y1 = Y(:,1:En);

S2 = P(:,(En+1):end);

Y2 = Y(:,(En+1):end);

outn = size(Y2,1);

net = newff(minmax(P),[50,30,outn],{'tansig','tansig','purelin'},'trainlm');

view(net)

% 3.???¨²????????????¡¤?????¡Á?????????

y1 = sim(net,S1);

net.trainParam.lr=0.03;

net.trainParam.epochs=1000;

net.trainParam.goal=1e-4;

%net.trainParam.goal=1e-5;%

[net,tr]=train(net,S1,Y1);

y2 = sim(net,P);

m = ['r';'g';'b';'c';'k';'y'];

for i = 1:maxn

  nc = mod(i,size(m,1))+1;

  figure;

  plot(Y(i,:),'color','r');

  hold all;

  plot(y2(i,:),'color','b');

end

figure;

plot(Y(6,1500:1800),'color','r');

hold all;

plot(y2(6,1500:1800),'color','b');

figure;

plot(Y(3,1500:1800),'color','r');

hold all;

plot(y2(3,1500:1800),'color','b');