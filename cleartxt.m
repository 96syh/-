filePaths = {'D://test_a1//move1.txt', 'D://test_a1//move2.txt', 'D://test_a1//move3.txt','D:/test_a1/cur1.txt','D:/test_a1/cur2.txt','C:/Users/Administrator/Desktop/7.txt','C:/Users/Administrator/Desktop/8.txt','C:/Users/Administrator/Desktop/9.txt'};

for i = 1:numel(filePaths)
    fid = fopen(filePaths{i}, 'w');
    fclose(fid);
end

disp('ÒÑÇå¿Õ¡£');
close all