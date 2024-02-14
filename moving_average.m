function smoothed_data = moving_average(data, window_size)
    % data: 输入数据
    % window_size: 移动平均窗口大小
    
    % 初始化平滑后的数据数组
    smoothed_data = zeros(size(data));
    
    % 计算移动平均
    for i = 1:length(data)
        start_idx = max(1, i - floor(window_size/2));
        end_idx = min(length(data), i + floor(window_size/2));
        smoothed_data(i) = mean(data(start_idx:end_idx));
    end
end
