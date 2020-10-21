function[variance_entro] = funz_variance_entro(mat_appartenenze, mat_coordinate_clu, mat_coordinate_sgn)

[nr, nc] = size(mat_coordinate_sgn);
[nr_cl, nc_cl] = size(mat_coordinate_clu);

variance_tot = 0;
for a = 1:nr_cl    
    pos = find(mat_appartenenze(:,2) == a);   % posizioni dei sgn appartenenti al cluster i-esimo 
    coord_punto_medio_tmp = mat_coordinate_clu(a,:);    % coordinate del centroide del cluster
    sommation = 0;
    for b = 1:length(pos)
        coord_tmp_sgn = mat_coordinate_sgn(pos(b),:);
        sommation = sommation + (sum(abs(coord_tmp_sgn - coord_punto_medio_tmp)))^2;
    end    
    if (length(pos) == 1)
        variance = 10^9;
    else
        variance = sommation/(length(pos)-1);
    end
    variance_tot = variance_tot + variance;
end

variance_entro = variance_tot/nr_cl;