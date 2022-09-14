%% Dijkstra - 4 directions
% by ZhuYufan
%% 创建栅格地图 或 导入栅格地图
% 栅格地图 .mat包括
% 地图大小 [r, c], 与colormap配合的场地 field, 障碍物序号 obs_Index,
% 障碍物坐标 obs_cord, 起点序号 r_s, 起点坐标 rs_cord,
% 终点序号 r_g, 终点坐标 r_g_cord.

% grid_map; % 创建栅格地图
load field_20x20_2.mat; % 加载地图
load colormap.mat; % 加载色图 cmap
%% 四向Dijkstra算法
figure(1); draw_grid_map(field, cmap, 0); % 绘制栅格地图
tic; % 计时

close = nan * zeros(1, 5); % 初始化CloseList
open = []; % 初始化OpenList
path = []; % 初始化路径（坐标）
% open = [当前点坐标x, 当前点坐标y, G, 父节点坐标x, 父节点坐标y]
% 首先将起点加入OpenList
open = [r_s_cord, 0, r_s_cord];
% 邻居坐标，共四个
neighbor = [0, 1; 1, 0; 0, -1; -1, 0];

while 1
    if isempty(open)
        % 所有地方都已寻找完，OpenList被清空，无法到达终点
        disp("无法到达终点！");
        break;
    end
    point_c = open(1, 1:2); % 目前判定的坐标
    % 如果为终点则跳出
    if point_c == r_g_cord
        break;
    end
    % 判定目前坐标的邻点
    neighbor_point = point_c + neighbor;
    for i = 1:4 % 四个邻点
        point_n = neighbor_point(i,:); % 对于该邻点
        % 拟更新该邻点的距离值
        % 距离衡量值 = 距离起点的代价g
        % 距离起点的代价g = 10*线段距离
        current = [point_n, g_distance(point_n, point_c, 10), point_c];
        current(3) = current(3) + open(1, 3); % 累加g值
        % 判断是否超出地图边界
        if point_n(1)<=0||point_n(2)<=0||point_n(1)>c||point_n(2)>r
            continue; % 超出边界，跳过该点
        end
        % 判断是否为障碍点
        if ~isempty(find(ismember(obs_cord, point_n, "rows"), 1))
            continue; % 是障碍点，跳过该点
        end
        % 判断在CloseList中是否有该邻点
        if ~isempty(find(ismember(close(:, 1:2), point_n, "rows"), 1))
            continue; % 在CloseList中有该邻点，跳过该点
        else
            % 在CloseList中无该邻点
            if isempty(find(ismember(open(:, 1:2), point_n, "rows"), 1))
                % 既不在CloseList也不在OpenList
                % 则将该邻点加入OpenList并且将该点设置为其父节点
                % 设置点与邻点距离为单位距离*10
                open = [open; current];
            else % 不在CloseList但在OpenList，检查当前点到邻点是否更佳
                ii = find(ismember(open(:, 1:2), point_n, "rows"), 1); % 当前邻点在OpenList中的行数
                if current(1, 3)<open(ii, 3)
                    % 如果值更小则将该邻点的父节点更换为目前点
                    open(ii, :) = current;
                elseif current(1, 3)==open(ii, 3)
                    % 如果相等则随机选择更换或不更换
                    if round(rand)
                        open(ii, :) = current;
                    end
                end
            end
        end
    end
    % 判定完目前点的邻点后
    close = [close; open(1, :)]; % 加入CloseList
    open(1, :) = []; % 将其移除OpenList
end
% 搜索完成后的操作
% 删除CloseList中为NaN的第一行
if isnan(close(1,1))
    close(1, :) = [];
end
if ~isempty(open)
    % 找到路径后的操作
    disp("成功通过四向移动的Dijkstra算法找到路径！");
    distance = open(1, 3);
    disp(['距离估值为 ', num2str(open(1, 3)),' 。']);
    % 设置回溯初始点
    point_p = open(1, 4:5);
    path = [r_g_cord; point_p];
    while 1
        find_r = find(ismember(close(:, 1:2), point_p, "rows"));
        point_p = close(find_r, 4:5); % 下一个回溯点
        path = [path; point_p]; % 更新路径
        % 若回溯到起点则跳出
        if point_p == r_s_cord
            break;
        end
    end
    % 转换为路径各点的序号
    path_n = coor_to_serial_num(path(:,1), path(:,2) ,r);
    path_n  = path_n.';
    % 去除起点和终点
    path_n(1,:) = [];
    path_n(length(path_n),:) = [];
else
end

timespend = toc;% 计时结束
disp(['用时', num2str(timespend), 's。']);
% draw_dynamic_path; % 绘制动态的规划路径图
draw_path; % 绘制规划路径图
% 保存路径信息
% save szdx_yh_3_Dj4_path 'close' 'path' 'path_n' 'timespend' 'distance';