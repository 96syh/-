function quadratic_functions = generate_quadratic_functions(coefficients,new_x)

    % ��ʼ���洢�������������
quadratic_functions = cell(1, size(coefficients, 1));
    
    for i = 1:size(coefficients, 1)-1
        % ��ȡ��ǰ�е�ϵ��
        a = coefficients(i+1, 4);
        b = coefficients(i+1, 3);
        c = coefficients(i+1, 2);
        d = coefficients(i+1, 1);
        k=gt(i,1);
        %k=0;
        
        % �����������ߺ������
        %quadratic_functions{i} = @(x) a+b*(x-k)+c*(x-k).^2 + d*(x-k).^3 ;
        quadratic_functions{i} = @(x) b+2*c*(x-k) + 3*d*(x-k).^2 ;
        %quadratic_functions{i} = @(x) b+2*c*(x-k);
    end
end
