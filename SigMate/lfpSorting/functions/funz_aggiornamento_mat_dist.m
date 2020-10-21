function[mat_dist_new, cluster_vet_new, dist_select, vet_dendrogram, vet_dendro_sup_new] = funz_aggiornamento_mat_dist(mat_distance, cluster_vet, rule, vet_dendro_sup)

vet_dendrogram = zeros(1,3);

% agiornamento della matrice delle distanze
[nr nc] = size(mat_distance);

val_vett = funz_mat_vet_no_zero(mat_distance);
val_min = min(val_vett);

vet_dendrogram(1,3) = val_min;

dist_select = val_min;

[nr_min nc_min] = find(mat_distance == val_min, 1);

vett_old1 = mat_distance(nr_min, :);
vett_old2 = mat_distance(nc_min, :);


switch rule
    case 1
    % regola di aggiornamento SL = Single Linkage
    vett_new = zeros(1,nc);
    for i = 1:nc
        if vett_old1(i) <= vett_old2(i)
            vett_new(i) = vett_old1(i);
        else
            vett_new(i) = vett_old2(i);
        end
    end
    case 2
    % regola di aggiornamento AL = Average Linkage
    vett_new = zeros(1,nc);
    for i = 1:nc
        if (vett_old1(i) == 0)
            vett_new(i) = 0;
        elseif (vett_old2(i) == 0)
            vett_new(i) = 0;
        else
            vett_new(i) = (vett_old1(i) + vett_old2(i))/2;
        end
    end
    case 3
    % regola di aggiornamento ML = Maximum Linkage
    vett_new = zeros(1,nc);
    for i = 1:nc
        if vett_old1(i) >= vett_old2(i)
            vett_new(i) = vett_old1(i);
        else
            vett_new(i) = vett_old2(i);
        end
    end
end

mat_dist_new = mat_distance;
mat_dist_new(nc_min, :) = vett_new;
mat_dist_new(:,nc_min) = vett_new;

mat_dist_new = mat_dist_new([1:(nr_min-1),(nr_min+1):end],[1:(nr_min-1),(nr_min+1):end]);

% aggiornamento del vettore dei cluster
string1 = cluster_vet{nc_min};
string2 = cluster_vet{nr_min};
string4 = ' ';
string3 = [string1,string4,string2]; 

vet_dendrogram(1,1) = vet_dendro_sup(nc_min);
vet_dendrogram(1,2) = vet_dendro_sup(nr_min);

val_new = max(vet_dendro_sup)+1;

k = 1;
cluster_vet_new = {};
vet_dendro_sup_new = [];
for i = 1:length(cluster_vet)
    if (i ~= nc_min)&(i ~= nr_min)        
        cluster_vet_new{k,1} = cluster_vet{i};
        vet_dendro_sup_new(k,1) = vet_dendro_sup(i);
        k = k+1;
    elseif i == nc_min
        cluster_vet_new{k,1} = string3;
        vet_dendro_sup_new(k,1) = val_new;
        k = k+1;
    end
end
