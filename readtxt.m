
folderPath = '\\10.170.241.176\第五轮大数据测试数据0814\95R_0908_79'; % 替换为要读取的文件夹的路径
%outputFileName = 'C:\Users\Administrator\Desktop\a9.txt'; % 输出文件名
outputFileName ='C:\Users\Administrator\Desktop\a9.txt'; % 输出文件名

% 获取指定路径下文件夹中的所有文件名
files = dir(fullfile(folderPath, '*.*'));
fileNames = {files.name}';

% 检查是否是文件夹，如果是，则从列表中移除
isDir = [files.isdir];
fileNames = fileNames(~isDir);

% 将文件名按列存储在txt文件中
fileId = fopen(outputFileName, 'w');
for i = 1:numel(fileNames)
    fprintf(fileId, '%s\n', fileNames{i});
end
fclose(fileId);
