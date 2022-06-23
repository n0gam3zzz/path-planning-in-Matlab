% 将图片转化为二值图并生成地图
%% 导入图片
clc; clear; close all;
A = imread('szdx_yh2_1.png');
figure(1);
subplot(2, 2, 1);
imshow(A); title('原图');
[rows, cols, colors] = size(A);
Res = zeros(rows , cols);
Res = uint8(Res);
for i = 1 : rows
    for j = 1 : cols
        Res(i, j) = A(i, j, 1)*0.30 + A(i, j, 2)*0.59 + A(i, j, 3)*0.11;
    end
end
subplot(2, 2, 2), imshow(Res), title('灰度图');
Ag = rgb2gray(A);
subplot(2, 2, 3), imshow(Ag), title('Matlab rgb2gray');

i = 250;
black = find(Ag>=i);
white = find(Ag<i);
Ag2 = Ag;
Ag2(black) = 255;
Ag2(white) = 0;
subplot(2, 2, 4), imshow(Ag2), title('Matlab black-white');
figure, imshow(Ag2), title('Matlab black-white');
imwrite(Ag2, 'szdx_yh2_bw.png');
% field = double(Ag2);
%% 边缘提取
% 测试各个算子的效果
figure,
Ag3 = ~edge(Ag2, "sobel");
subplot(2, 4 ,1), imshow(Ag3), title("sobel");
Ag3 = ~edge(Ag2, "prewitt");
subplot(2, 4 ,2), imshow(Ag3), title("prewitt");
Ag3 = ~edge(Ag2, "roberts");
subplot(2, 4 ,3), imshow(Ag3), title("roberts");
Ag3 = ~edge(Ag2, "log");
subplot(2, 4 ,4), imshow(Ag3), title("log");
Ag3 = ~edge(Ag2, "canny");
subplot(2, 4 ,5), imshow(Ag3), title("canny");
Ag3 = ~edge(Ag2, "canny_old");
subplot(2, 4 ,6), imshow(Ag3), title("canny_old");
Ag3 = ~edge(Ag2, "zerocross");
subplot(2, 4 ,7), imshow(Ag3), title("zerocross");
Ag3 = ~edge(Ag2, "approxcanny");
subplot(2, 4 ,8), imshow(Ag3), title("approxcanny");

Ag3 = ~edge(Ag2, "log");
imwrite(Ag3, 'szdx_yh2_bw2.png');
%% 生成并存储地图
field = double(Ag3);
Ag3(Ag3==0) = 2;
field(field==255) = 1;
field(field==0) = 2;
[r, c] = size(field);
obs_Index = find(field==2);
[obs_cord(:,1), obs_cord(:,2)] = serial_num_to_coor(obs_Index, r);
r_s_cord = [10, 100]; % change it!
r_g_cord = [190, 117]; % change it!
r_s = coor_to_serial_num(r_s_cord(1), r_s_cord(2) , r);
r_g = coor_to_serial_num(r_g_cord(1), r_g_cord(2) , r);
field(r_s) = 3;
field(r_g) = 4;
figure, draw_grid_map(field, 0);
cmap = [1 1 1;
        0 0 0;
        0 1 0;
        1 0 0;
        0 0 1;
        0 0.686 0.784];
save field_szdx_yh2 'c' 'cmap' 'field' 'obs_cord' 'obs_Index' 'r' 'r_g' 'r_g_cord' 'r_s' 'r_s_cord';