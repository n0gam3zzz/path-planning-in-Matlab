% DRAW_PATH 绘制规划路径图
field(coor_to_serial_num(close(2:height(close), 1), close(2:height(close), 2), r)) = 6;
draw_grid_map(field, cmap, 0);
if ~isempty(path)
    field(path_n) = 5;
end
draw_grid_map(field, cmap, 2);
if ~isempty(path)
    hold on;
%     plot(path(:,1) + 0.5, path(:,2) + 0.5, '-y', 'MarkerFaceColor', 'yellow', 'LineWidth', 5);
    plot(path(:,1) + 0.5, path(:,2) + 0.5, '-y', 'LineWidth', 2);
end