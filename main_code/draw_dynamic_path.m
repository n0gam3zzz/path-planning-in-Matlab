% DRAW_DYNAMIC_PATH 绘制动态规划路径地图
for i = 2:height(close)
    if i > height(close)
        break;
    end
    pause(0.0001);
    x = close(i, 1);
    y = close(i, 2);
    field(coor_to_serial_num(x, y, r)) = 6;
%     fill([x, x+1, x+1, x], [y, y, y+1, y+1], cmap(6, :), 'EdgeColor', 'none');
    draw_grid_map(field, cmap, 0);
end
if ~isempty(path)
    field(path_n) = 5;
end
draw_grid_map(field, cmap, 2);
if ~isempty(path)
    hold on;
%     plot(path(:,1) + 0.5, path(:,2) + 0.5, '-y', 'MarkerFaceColor', 'yellow', 'LineWidth', 5);
    plot(path(:,1) + 0.5, path(:,2) + 0.5, '-y', 'LineWidth', 2);
end