function smoothed_data = moving_average(data, window_size)
    % data: ��������
    % window_size: �ƶ�ƽ�����ڴ�С
    
    % ��ʼ��ƽ�������������
    smoothed_data = zeros(size(data));
    
    % �����ƶ�ƽ��
    for i = 1:length(data)
        start_idx = max(1, i - floor(window_size/2));
        end_idx = min(length(data), i + floor(window_size/2));
        smoothed_data(i) = mean(data(start_idx:end_idx));
    end
end
