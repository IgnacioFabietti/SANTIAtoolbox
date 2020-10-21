function[variance_tra] = funz_variance_tra(mat_appartenenze, mat_coordinate_clu, mat_coordinate_sgn)

[nr, nc] = size(mat_coordinate_sgn);
[nr_cl, nc_cl] = size(mat_coordinate_clu);

media_totale_clu = mean(mat_coordinate_clu);

variance_tra = 0;
sommation = 0;
for a = 1:nr_cl    
    pos = find(mat_appartenenze(:,2) == a);
    num_sgn_app_clu_tmp = length(pos);
    coordinate_clu_tmp = mat_coordinate_clu(a,:);    % coordinate del centroide del cluster
    sommation = sommation + num_sgn_app_clu_tmp*(sum(abs(media_totale_clu - coordinate_clu_tmp)))^2;       
    variance_tra = variance_tra + sommation;
end
variance_tra = variance_tra/nr;