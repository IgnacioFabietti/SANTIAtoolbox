function[mat_distance] = calculateDistanceMatrix(mat_coordinate_sgn, measure)

[nr, nc] = size(mat_coordinate_sgn);
mat_distance = zeros(nr,nr); 

for i = 1:nr
    sgn_tmp_1 = mat_coordinate_sgn(i,:);
    for j = 1:nr
        sgn_tmp_2 = mat_coordinate_sgn(j,:);
        switch measure
            case 1
                dist_tmp = findEuclideanDistance(sgn_tmp_1,sgn_tmp_2);
            case 2
                dist_tmp = 1 - findPearsonCorrelation(sgn_tmp_1,sgn_tmp_2);
            case 3
                dist_tmp = 1 - findPearsonCorrelationUncentered(sgn_tmp_1,sgn_tmp_2);
        end
        mat_distance(i,j) = dist_tmp;
        if (measure == 2) | (measure == 3)
            if (i == j)
                mat_distance(i,j) = 3;
            end
        end
    end
end