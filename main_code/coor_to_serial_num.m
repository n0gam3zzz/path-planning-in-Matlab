function [serial_num] = coor_to_serial_num(x, y ,rows)
% COOR_TO_SERIAL_NUM 对于在栅格地图上的点，将其坐标转化为序号
n = length(x);
serial_num = zeros(1, n);
for i = 1:n
    serial_num(i) = (x(i) - 1)*rows + y(i);
end
end