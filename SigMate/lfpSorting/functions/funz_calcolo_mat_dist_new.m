function[mat_distance] = funz_calcolo_mat_dist_new(mat_coordinate_sgn, measure)

[nr, nc] = size(mat_coordinate_sgn);
mat_distance = zeros(nr,nr); 

for i = 1:nr
    sgn_tmp_1 = mat_coordinate_sgn(i,:);
    for j = 1:nr
        sgn_tmp_2 = mat_coordinate_sgn(j,:);
        switch measure
            case 1
                dist_tmp = funz_Euclidian_distance(sgn_tmp_1,sgn_tmp_2);
            case 2
                dist_tmp = 1 - funz_Pearson_correlation(sgn_tmp_1,sgn_tmp_2);
            case 3
                dist_tmp = 1 - funz_Pearson_correlation_uncentered(sgn_tmp_1,sgn_tmp_2);
        end
        mat_distance(i,j) = dist_tmp;
        if (measure == 2) | (measure == 3)
            if (i == j)
                mat_distance(i,j) = 3;
            end
        end
    end
end