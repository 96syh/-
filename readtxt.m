
folderPath = '\\10.170.241.176\�����ִ����ݲ�������0814\95R_0908_79'; % �滻ΪҪ��ȡ���ļ��е�·��
%outputFileName = 'C:\Users\Administrator\Desktop\a9.txt'; % ����ļ���
outputFileName ='C:\Users\Administrator\Desktop\a9.txt'; % ����ļ���

% ��ȡָ��·�����ļ����е������ļ���
files = dir(fullfile(folderPath, '*.*'));
fileNames = {files.name}';

% ����Ƿ����ļ��У�����ǣ�����б����Ƴ�
isDir = [files.isdir];
fileNames = fileNames(~isDir);

% ���ļ������д洢��txt�ļ���
fileId = fopen(outputFileName, 'w');
for i = 1:numel(fileNames)
    fprintf(fileId, '%s\n', fileNames{i});
end
fclose(fileId);
