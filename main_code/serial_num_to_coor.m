function [x, y] = serial_num_to_coor(serial_num, rows)
% SERIAL_NUM_TO_COOR 对于在栅格地图上的点，将其序号转化为坐标
n = length(serial_num);
x = zeros(n, 1);
y = zeros(n, 1);
for i = 1:n
    if mod(serial_num(i), rows) == 0
        y(i) = rows;
    else
        y(i) = mod(serial_num(i), rows);
    end
    x(i) = ceil(serial_num(i)/rows);
end

