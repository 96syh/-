function second_derivative = calculate_second_derivative(x, y)
    n = length(x);
    second_derivative = zeros(1, n);
    
    for i = 2:n-1
        h_i = x(i+1) - x(i);
        second_derivative(i) = (y(i+1) - 2*y(i) + y(i-1)) / (h_i^2);
    end
end
% function first_derivative = calculate_first_derivative(x, y)
%     n = length(x);
%     first_derivative = zeros(1, n);
%     
%     for i = 2:n-1
%         h_i = x(i+1) - x(i-1);
%         first_derivative(i) = (y(i+1) - y(i-1)) / (2*h_i);
%     end
% end