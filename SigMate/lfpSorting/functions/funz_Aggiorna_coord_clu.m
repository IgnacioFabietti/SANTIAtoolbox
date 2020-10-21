function[mat_coord_clu] = funz_Aggiorna_coord_clu(mat_coord_clu, mat_coord_sgn, mat_appartenenze)

[nr, nc] = size(mat_coord_clu);
K = nr; % number of clusters

for a = 1:K
    pos = find(mat_appartenenze(:,2) == a);
    if length(pos) >=1
        sommation = 0;   
        for b = 1:length(pos)
            sommation = sommation + mat_coord_sgn(pos(b),:);
        end
        mat_coord_clu(a,:) = sommation/length(pos);
    end
end