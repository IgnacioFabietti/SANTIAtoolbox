function[mat_assegnamenti] = clusterAssignmentSOM(mat_coordinate_sgn, mat_coordinate_clu, measure)

[nr, nc] = size(mat_coordinate_sgn);
[nr_clu, nc_clu] = size(mat_coordinate_clu);

mat_assegnamenti = zeros(nr,2);
mat_assegnamenti(:,1) = 1:1:nr;

for i = 1:nr
    sgn_tmp = mat_coordinate_sgn(i,:);
    dist_old = 10^9;
    winner = 0;
    for j = 1:nr_clu
        clu_tmp = mat_coordinate_clu(j,:);
        switch measure
            case 1
                dist_tmp = findEuclideanDistance(sgn_tmp,clu_tmp);
            case 2
                dist_tmp = abs(1 - findPearsonCorrelation(sgn_tmp,clu_tmp));
            case 3
                dist_tmp = abs(1 - findPearsonCorrelationUncentered(sgn_tmp,clu_tmp));
        end
        if dist_tmp < dist_old
            winner = j;
            dist_old = dist_tmp;
        end
    end
    mat_assegnamenti(i,2) = winner;    
end