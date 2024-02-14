function update_excel_values(input_file, m_column)
    % 读取 Excel 表格
    table_data = readtable(input_file);

    % 获取 B 列数据
    b_column_data = table_data{:, 2};

    % 根据 B 列的值更新 M 列
    for i = 1:length(b_column_data)
        if b_column_data(i) == 22
            table_data{i, m_column} = '是';
        elseif b_column_data(i) == 26
            table_data{i, m_column} = '否';
        end
    end

    % 将修改后的结果写回原文件
    writetable(table_data, input_file, 'Sheet', 1, 'Range', ['M1:M' num2str(size(table_data, 1))]);
end
