I1_rgb = imread('C:\Users\Administrator\Desktop\truck1.jpg');
I2_rgb = imread('C:\Users\Administrator\Desktop\truck2.jpg');
%I1_rgb = imread('C:\Users\Administrator\Desktop\dog_2.jpg');
%I2_rgb = imread('C:\Users\Administrator\Desktop\dog_rotation.jpg');
I1 = rgb2gray(I1_rgb);
I2 = rgb2gray(I2_rgb);
% imshow(I1_rgb);
% [x1,y1]  = ginput(1);
% [x2,y2]  = ginput(1);
% width1 = x2-x1;
% height1 = y2-y1;
% imshow(I2_rgb);
% [x3,y3]  = ginput(1);
% [x4,y4]  = ginput(1);
% width2 = x4-x3;
% height2 = y4-y3;
% close all;
%points1 = detectSURFFeatures(I1,'MetricThreshold',100,'NumOctaves',5,'NumScaleLevels',4,'ROI',[x1,y1,width1,height1]);
%points2 = detectSURFFeatures(I2,'MetricThreshold',100,'NumOctaves',5,'NumScaleLevels',4,'ROI',[x3,y3,width2,height2]);
points1 = detectSURFFeatures(I1,'MetricThreshold',2000,'NumOctaves',3,'NumScaleLevels',4,'ROI',[1,1,size(I1,2),size(I1,1)]);
points2 = detectSURFFeatures(I2,'MetricThreshold',2000,'NumOctaves',3,'NumScaleLevels',4,'ROI',[1,1,size(I2,2),size(I2,1)]);
[f1, vpts1] = extractFeatures(I1, points1);   %返回从二进制或强度图像中提取的特征向量（也称为描述符）及其对应位置。
[f2, vpts2] = extractFeatures(I2, points2);       
%返回两个输入特征集中匹配特征的索引surf,MatchThreshold阈值表示距离完美匹配的百分比,MaxRatio最小距离d1/第二小距离d2
[indexPairs,matchmetric] = matchFeatures(f1, f2);
 
% 构建三角形abc，求出alpha和theta角
tmp  = matchmetric;
otherPairs = indexPairs;
[mindistance1,minindex1] = min(tmp);
tmp(minindex1) = [];
otherPairs(minindex1,:) = [];
[mindistance2,minindex2] = min(tmp);
tmp(minindex2) = [];
otherPairs(minindex2,:) = [];
Location1 = vpts1.Location(indexPairs(:, 1),:);
Location2 = vpts2.Location(indexPairs(:, 2),:);
a1 = Location1(minindex1,:);
b1 = Location1(minindex2,:);
ab1 = double(b1) - double(a1);
ac1 = double(vpts1.Location(otherPairs(:, 1),:)) - double(a1);
bc1 = double(vpts1.Location(otherPairs(:, 1),:)) - double(b1);
a2 = Location2(minindex1,:);
b2 = Location2(minindex2,:);
ab2 = double(b2) - double(a2);
ac2 = double(vpts2.Location(otherPairs(:, 2),:)) - double(a2);
bc2 = double(vpts2.Location(otherPairs(:, 2),:)) - double(b2);
alpha1 = [];
theta1 = [];
alpha2 = [];
theta2 = [];
for i = 1:size(ac1,1)
    alpha1 = [alpha1,acos(dot(ab1,ac1(i,:))/(norm(ab1)*norm(ac1(i,:))))];
    theta1 = [theta1,acos(dot(-ab1,bc1(i,:))/(norm(-ab1)*norm(bc1(i,:))))];
    alpha2 = [alpha2,acos(dot(ab2,ac2(i,:))/(norm(ab2)*norm(ac2(i,:))))];
    theta2 = [theta2,acos(dot(-ab2,bc2(i,:))/(norm(-ab2)*norm(bc2(i,:))))];
end
s1alpha = 0.5*(norm(ac1))*sin(real(alpha1'))*norm(ab1);
s2alpha = 0.5*(norm(ac1))*sin(real(alpha2'))*norm(ab1);
s1theta = 0.5*(norm(bc1))*sin(real(theta1'))*norm(ab1);
s2theta = 0.5*(norm(bc1))*sin(real(theta2'))*norm(ab1);
difference = abs((s1alpha+s1theta)-(s2alpha+s2theta))./(s1alpha+s1theta);
difference = difference';
[diff_sort,diff_index]=sort(difference,"ascend"); 
radio = 0.8;   
match  = diff_index(1:int16(size(diff_index,2)*radio));
nomatch  = diff_index(int16(size(diff_index,2)*radio)+1:size(diff_index,2));
match  = [match,minindex1];
match  = [match,minindex2];
new_indexPairs = indexPairs(match,:);  %得到最新的匹配对
matchedPoints1 = vpts1(new_indexPairs(:, 1));
matchedPoints2 = vpts2(new_indexPairs(:, 2));
nonew_indexPairs = indexPairs(nomatch,:);  %不匹配的
nomatchedPoints1 = vpts1(nonew_indexPairs(:, 1));
nomatchedPoints2 = vpts2(nonew_indexPairs(:, 2)); 
%cheak resize
new_Location1 = vpts1.Location(new_indexPairs(:, 1),:);
new_Location2 = vpts2.Location(new_indexPairs(:, 2),:);
D1 = pdist(new_Location1);
D2 = pdist(new_Location2);
scale = D2./D1;
temp1 = scale(~isinf(scale));
scale_removenan_inf = temp1(~isnan(temp1));
averagescale = median(scale_removenan_inf);
fprintf("The median of scaling is %f\n",averagescale")
figure; distanceradio = histogram(scale','Normalization','probability');
distanceradio.BinEdges = (0:5);
distanceradio.NumBins = 25;
title('Resize');
 
%cheak rotation
C1 = [nchoosek(new_Location1(:,1),2),nchoosek(new_Location1(:,2),2)];
C1(:,[2 3]) = C1(:,[3 2]);
C2 = [nchoosek(new_Location2(:,1),2),nchoosek(new_Location2(:,2),2)];
C2(:,[2 3]) = C2(:,[3 2]);
AB = [C1(:,3)-C1(:,1),C1(:,4)-C1(:,2)];
CD = [C2(:,3)-C2(:,1),C2(:,4)-C2(:,2)];
sigma = [];
for i = 1:size(AB,1)
    sigma = real([sigma,acos(dot(AB(i,:),CD(i,:))/(norm(AB(i,:))*norm(CD(i,:))))/pi*180]);
end
temp2 = sigma(~isinf(sigma));
rotation_removenan_inf = temp2(~isnan(temp2));
averagerotation = median(rotation_removenan_inf);
fprintf("The median of rotation angle is %f°\n",averagerotation)
figure; distanceradio = histogram(sigma','Normalization','probability');
distanceradio.BinEdges = (0:180);
distanceradio.NumBins = 25;
title('Rotation');
 
% Visualize putative matches
figure; img = showMatchedFeatures(I1_rgb,I2_rgb,matchedPoints1,matchedPoints2,'montage','PlotOptions',["d","+","y"]);
title('SURF');
legend('matchedPts1','matchedPts2'); 
imwrite(img,'C:\Users\Administrator\Desktop\truck_surf','jpg')
figure; showMatchedFeatures(I1_rgb,I2_rgb,nomatchedPoints1,nomatchedPoints2,'montage','PlotOptions',["d","+","g"]);
title('mistakeSURF');
legend('nomatchedPts1','nomatchedPts2'); 
