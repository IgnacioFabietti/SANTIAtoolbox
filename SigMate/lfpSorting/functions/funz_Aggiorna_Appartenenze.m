function[mat_appartenenze, mat_coordinate_clu] = funz_Aggiorna_Appartenenze(mat_appartenenze, mat_coordinate_clu, mat_coordinate_sgn, measure)

[nr, nc] = size(mat_coordinate_sgn);
[nr_cl, nc_cl] = size(mat_coordinate_clu);
K = nr_cl;

for a = 1:nr
    coord_tmp_sgn = mat_coordinate_sgn(a,:);
    
    appartenenza_old = mat_appartenenze(a,2);
    
    dist_old = 10^9;
    
    b_old = 0;
    switch measure
        case 1
            for b = 1:K
                coord_tmp_clu = mat_coordinate_clu(b,:);
                dist_new = findEuclideanDistance(coord_tmp_sgn, coord_tmp_clu);
                if dist_new < dist_old
                    dist_old = dist_new;
                    b_old = b;  
                end
            end
        case 2
            for b = 1:K
                coord_tmp_clu = mat_coordinate_clu(b,:);
                dist_new = findPearsoncorrelation(coord_tmp_sgn, coord_tmp_clu);
                dist_new = abs(1-dist_new);
                if dist_new < dist_old
                    dist_old = dist_new;
                    b_old = b;  
                end
            end
        case 3
            for b = 1:K
                coord_tmp_clu = mat_coordinate_clu(b,:);
                dist_new = findPearsoncorrelationUncentered(coord_tmp_sgn, coord_tmp_clu);
                dist_new = abs(1-dist_new);
                if dist_new < dist_old
                    dist_old = dist_new;
                    b_old = b;  
                end
            end
    end
    
    if appartenenza_old == b_old
        mat_appartenenze(a,2) = b_old;
    else
        mat_appartenenze(a,2) = b_old;
        mat_coordinate_clu = updateClusterCoordinates(mat_coordinate_clu, mat_coordinate_sgn, mat_appartenenze);
    end
    
end