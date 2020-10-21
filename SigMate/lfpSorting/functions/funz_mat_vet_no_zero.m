function[vett] = funz_mat_vet_no_zero(matrix)

[nr nc] = size(matrix);

vett = [];
k = 1;

for i = 1:nr
    for j = 1:nc
        val_tmp = matrix(i,j);
        if (i ~= j)
            vett(k) = val_tmp;
            k = k+1;
        end
    end
end