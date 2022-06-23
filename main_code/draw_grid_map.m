function [] = draw_grid_map(field, cmap, option)
% DRAW_GRID_MAP 给定栅格地图信息绘制栅格地图
[r, c] = size(field);

colormap(cmap);
image(1.5, 1.5, field);
grid on, axis equal, hold on;
if option==1
    set(gca, 'gridline', '-', 'gridcolor', 'k', 'linewidth', 2, 'GridAlpha', 0.5);
elseif option ==2
    p = find(field==3);
    [x, y] = serial_num_to_coor(p, r);
    scatter(x+0.5, y+0.5, 50, 'green', 'filled'); hold on,
    p = find(field==4);
    [x, y] = serial_num_to_coor(p, r);
    scatter(x+0.5, y+0.5, 50, 'red', 'filled'); hold on,
end

% 设置网格：为以d格为步长
d = fix(max(r, c)/10);
if d == 0
    d = 1;
end
set(gca, 'xtick', 1:d:c+1, 'ytick', 1:d:r+1);
axis image;
end