function[mat_coordinate_clu] = updateClusterAssignmentSOM(sgn_tmp, winner, mat_coordinate_clu, eta)

[nr_clu, nc_clu] = size(mat_coordinate_clu);


coordinate_winner = mat_coordinate_clu(winner, :);
coordinate_winner_new = coordinate_winner + eta*(sgn_tmp - coordinate_winner);
mat_coordinate_clu(winner, :) = coordinate_winner_new;

if winner == 1
    coordinate_vicino = mat_coordinate_clu(2, :);
    
    coordinate_vicino_new = coordinate_vicino + eta*(sgn_tmp-coordinate_vicino);  
    
    mat_coordinate_clu(2, :) = coordinate_vicino_new;
elseif winner == nr_clu
    coordinate_vicino = mat_coordinate_clu((winner-1), :);
    
    coordinate_vicino_new = coordinate_vicino + eta*(sgn_tmp-coordinate_vicino);  
    
    mat_coordinate_clu((winner-1), :) = coordinate_vicino_new;
else
    coordinate_vicino_sx = mat_coordinate_clu((winner-1), :);
    
    coordinate_vicino_sx_new = coordinate_vicino_sx + eta*(sgn_tmp-coordinate_vicino_sx);
    
    mat_coordinate_clu((winner-1), :) = coordinate_vicino_sx_new;
    coordinate_vicino_dx = mat_coordinate_clu((winner+1), :);
    
    coordinate_vicino_dx_new = coordinate_vicino_dx + eta*(sgn_tmp-coordinate_vicino_dx);
    
    mat_coordinate_clu((winner+1), :) = coordinate_vicino_dx_new;
end