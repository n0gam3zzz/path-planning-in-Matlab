function [h] = h_distance(initial, goal, cost, option)
% H_DISTANCE 估价算法，表示当前点到目标点的距离代价值

dx = abs(initial(1) - goal(1));
dy = abs(initial(2) - goal(2));

if option == 1
    h_strt = abs(dx + dy);
    h_diag = min(dx, dy);
    h = cost*sqrt(2)*h_diag + cost*(h_strt - 2*h_diag);
elseif option == 2
    h = cost*sqrt(dx^2 + dy^2);
else
    h = cost*(dx + dy);
end
end