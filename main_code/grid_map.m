% 栅格地图的创建
clc; clear; close all;
% 参考 https://wenku.baidu.com/view/e866f6d9cbd376eeaeaad1f34693daef5ef71326.html
cmap = [1 1 1;
        0 0 0;
        0 1 0;
        1 0 0;
        0 0 1;
        1 0.686 0.784];
colormap(cmap); close all;
r = 10;
c = 10;
field = ones(r, c);
obs_Index = [0, 0];
obs_cord = [0, 0];
obs_Rate = 0.3;
% [obs_Index, obs_cord] = obstacle_random(field, obs_Rate);

% ###TSET01
% obs_Index = [21 22 23 24 25 26 27 60 59 58 57 56 55 54 64 74]; % 10*10
% [obs_cord(:,1), obs_cord(:,2)] = serial_num_to_coor(obs_Index, r);
% ###TEST02
% load obs_cord_10x10_1;
% obs_Index = coor_to_serial_num(obs_cord(:, 1), obs_cord(:, 2), r);
% obs_Index = obs_Index.';
% r_s = 1; r_g = 87;
if ~(obs_Index == [0, 0])
    field(obs_Index) = 2;
end

r_s = 1;
[r_s_cord(1), r_s_cord(2)] = serial_num_to_coor(r_s, r);
r_g = r*c;
[r_g_cord(1), r_g_cord(2)] = serial_num_to_coor(r_g, r);
field(r_s) = 3;
field(r_g) = 4;
if find(obs_Index==r_g)
    i = find(obs_Index==r_g);
    obs_Index(i) = [];
    obs_cord(i, :) = [];
end
