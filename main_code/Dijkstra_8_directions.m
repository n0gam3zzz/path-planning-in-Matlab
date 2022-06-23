%% Dijkstra - 8 directions
load field_szdx_yh.mat ;
load colormap.mat ;
figure( 1 );
draw_grid_map( field, cmap, 0 );
tic;
close = nan * zeros( 1, 5 );
open = [  ];
path = [  ];
open = [ r_s_cord, 0, r_s_cord ];
neighbor = [ -1, 1; 0, 1; 1, 1; 1, 0; 1, -1; 0, -1; -1, -1; -1, 0 ];
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
    for i = 1:8
        point_n = neighbor_point( i, : );
        current = [ point_n, g_distance( point_n, point_c, 10 ), point_c ];
        current( 3 ) = current( 3 ) + open( 1, 3 );
        if point_n( 1 )<=0 || point_n( 2 )<=0 || point_n( 1 )>c || point_n( 2 )>r
            continue
        end
        if ~isempty( find( ismember( obs_cord, point_n, "rows" ), 1 ) )
            continue
        end
        if i==1
            if (~isempty( find( ismember( obs_cord, neighbor_point( 2, : ), "rows" ), 1 ) )) && (~isempty( find( ismember( obs_cord, neighbor_point( 8, : ), "rows" ), 1 ) ))
                continue
            end
        elseif i==3
            if (~isempty( find( ismember( obs_cord, neighbor_point( 2, : ), "rows" ), 1 ) )) && (~isempty( find( ismember( obs_cord, neighbor_point( 4, : ), "rows" ), 1 ) ))
                continue
            end
        elseif i==5
            if (~isempty( find( ismember( obs_cord, neighbor_point( 4, : ), "rows" ), 1 ) )) && (~isempty( find( ismember( obs_cord, neighbor_point( 6, : ), "rows" ), 1 ) ))
                continue
            end
        elseif i==7
            if (~isempty( find( ismember( obs_cord, neighbor_point( 6, : ), "rows" ), 1 ) )) && (~isempty( find( ismember( obs_cord, neighbor_point( 8, : ), "rows" ), 1 ) ))
                continue
            end
        end
        if ~isempty( find( ismember( close( :, 1:2 ), point_n, "rows" ), 1 ) )
            continue
        else
            if isempty( find( ismember( open( :, 1:2 ), point_n, "rows" ), 1 ) )
                open = [ open; current ];
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
end
if isnan( close( 1, 1 ) )
    close( 1, : ) = [  ];
end
if ~isempty( open )
    disp( "Successfully find the path by eight-way moving Dijkstra algorithm!" );
    disp( [ 'The distance value is ', num2str( open( 1, 3 ) ), '.' ] );
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
save szdx_yh_Dj8_path 'close' 'path' 'path_n' 'timespend' ;