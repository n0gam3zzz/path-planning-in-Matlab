function [g] = g_distance(point1, point2, cost)
% G_DISTANCE 估价算法，表示两点的距离代价值
dx = abs(point1(1) - point2(1));
dy = abs(point1(2) - point2(2));
g = cost*sqrt(dx.^2 + dy.^2);
end