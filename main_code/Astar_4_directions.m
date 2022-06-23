%% A* - 4 directions
load field_szdx_yh.mat ;
load colormap.mat ;
figure( 1 );
draw_grid_map( field, cmap, 0 );
tic;
close = nan * zeros( 1, 6 );
open = [  ];
path = [  ];
open = [ r_s_cord, 0, r_s_cord, 0 ];
neighbor = [ 0, 1; 1, 0; 0, -1; -1, 0 ];
g_cost = 10;
h_cost = 10;
while 1
    if isempty( open )
        disp( "Cannot reach the goal!" );
        break
    end
    point_c = open( 1, 1:2 );
    if point_c==r_g_cord
        break
    end
    neighbor_point = point_c + neighbor;
    j = 0;
    for i = 1:4
        point_n = neighbor_point( i, : );
        g = g_distance( point_n, point_c, g_cost );
        h = h_distance( point_n, r_g_cord, h_cost, 1 );
        current = [ point_n, g + h, point_c, g ];
        current( 3 ) = current( 3 ) + open( 1, 3 );
        current( 6 ) = current( 6 ) + open( 1, 6 );
        if point_n( 1 )<=0 || point_n( 2 )<=0 || point_n( 1 )>c || point_n( 2 )>r
            j = j + 1;
            continue
        end
        if ~isempty( find( ismember( obs_cord, point_n, "rows" ), 1 ) )
            j = j + 1;
            continue
        end
        if ~isempty( find( ismember( close( :, 1:2 ), point_n, "rows" ), 1 ) )
            j = j + 1;
            continue
        else
            if isempty( find( ismember( open( :, 1:2 ), point_n, "rows" ), 1 ) )
                open = [ open( 1, : ); current; open( 2:height( open ), : ) ];
            else
                ii = find( ismember( open( :, 1:2 ), point_n, "rows" ), 1 );
                if current( 1, 3 )<open( ii, 3 )
                    open( ii, : ) = current;
                elseif current( 1, 3 )==open( ii, 3 )
                    if round( rand )
                        open( ii, : ) = current;
                    end
                end
            end
        end
    end
    close = [ close; open( 1, : ) ];
    open( 1, : ) = [  ];
    open = sortrows( open, 3 );
end
if isnan( close( 1, 1 ) )
    close( 1, : ) = [  ];
end
if ~isempty( open )
    disp( "Successfully find the path by four-way moving A* algorithm!" );
    disp( [ 'The distance value is ', num2str( open( 1, 6 ) ), '.' ] );
    point_p = open( 1, 4:5 );
    path = [ r_g_cord; point_p ];
    while 1
        find_r = find( ismember( close( :, 1:2 ), point_p, "rows" ) );
        point_p = close( find_r, 4:5 );
        path = [ path; point_p ];
        if point_p==r_s_cord
            break
        end
    end
    path_n = coor_to_serial_num( path( :, 1 ), path( :, 2 ), r );
    path_n = path_n.';
    path_n( 1, : ) = [  ];
    path_n( length( path_n ), : ) = [  ];
else
end
timespend = toc;
disp( [ 'Timespend: ', num2str( timespend ), 's.' ] );
draw_path;
save szdx_yh2_astar4_path 'close' 'path' 'path_n' 'timespend' ;