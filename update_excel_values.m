function update_excel_values(input_file, m_column)
    % ��ȡ Excel ���
    table_data = readtable(input_file);

    % ��ȡ B ������
    b_column_data = table_data{:, 2};

    % ���� B �е�ֵ���� M ��
    for i = 1:length(b_column_data)
        if b_column_data(i) == 22
            table_data{i, m_column} = '��';
        elseif b_column_data(i) == 26
            table_data{i, m_column} = '��';
        end
    end

    % ���޸ĺ�Ľ��д��ԭ�ļ�
    writetable(table_data, input_file, 'Sheet', 1, 'Range', ['M1:M' num2str(size(table_data, 1))]);
end
