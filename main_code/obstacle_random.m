function [obs_Index, obs_cord] = obstacle_random(field, obs_Rate)
% OBSTACLE_RANDOM 根据栅格地图大小和生成比例生成随机的障碍物
[r, c] = size(field);
obs_n = floor(r*c*obs_Rate);
obs_Index = randi([1, r*c], obs_n, 1);
obs_cord = zeros(obs_n, 2);
[obs_cord(:,1), obs_cord(:,2)] = serial_num_to_coor(obs_Index, r);
end

