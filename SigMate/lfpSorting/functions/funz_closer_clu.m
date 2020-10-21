function[winner] = funz_closer_clu(sgn_tmp, mat_coordinate_clu, measure)

[nr_clu, nc_clu] = size(mat_coordinate_clu);

dist_old = 10^9;
winner = 0;
for i = 1:nr_clu
    clu_tmp = mat_coordinate_clu(i,:);
    switch measure
        case 1
            distance_tmp = funz_Euclidian_distance(clu_tmp,sgn_tmp);
        case 2
            distance_tmp = abs(1 - funz_Pearson_correlation(clu_tmp,sgn_tmp));
        case 3
            distance_tmp = abs(1 - funz_Pearson_correlation_uncentered(clu_tmp,sgn_tmp));
    end
    if distance_tmp < dist_old
        winner = i;
        dist_old = distance_tmp;
    end        
end