function[variance] = findSumOfDistances(mat_appartenenze, mat_coordinate_clu, mat_coordinate_sgn)

[nr, nc] = size(mat_coordinate_sgn);
[nr_cl, nc_cl] = size(mat_coordinate_clu);

sommation_big = 0;
for a = 1:nr_cl
    
    coord_tmp_clu = mat_coordinate_clu(a,:);
    pos = find(mat_appartenenze(:,2) == a);
    
    sommation = 0;   
    for b = 1:length(pos)
        coord_tmp_sgn = mat_coordinate_sgn(pos(b),:);
        sommation = sommation + findEuclideanDistance(coord_tmp_sgn,coord_tmp_clu);        
    end
    sommation_big = sommation_big + sommation;
    
end
variance = sommation_big/nr;