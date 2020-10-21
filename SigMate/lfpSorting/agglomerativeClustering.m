function[cluster_mat, cluster_vet_stop, vect_distance, K, mat_dendrogram] = agglomerativeClustering(mat_data, measure, rule, K)

% measure = input('Digit 1 for the Euclidean distance, 2 for the centered correlation, 3 for the uncenterd correlation: ');
condizione = 0;
while condizione == 0        
    if (measure ~= 1) & (measure ~= 2) & (measure ~= 3)
        measure = input('digit 1 (Euclidean distance) or 2 (centered corr.) or 3 (uncentered corr.): ');
    else 
        condizione = 1;
    end
end

mat_distance = calculateDistanceMatrix(mat_data, measure);
[nr nc] = size(mat_distance);

mat_dendrogram = zeros((nr-1),3);

% rule = input('Digit 1 to use SL rule, 2 to use AL rule or 3 to use ML rule: ');
condizione = 0;
while condizione == 0
    if (rule ~= 1) & (rule ~= 2) & (rule ~= 3)
        rule = input('Inser: 1-->SL or 2-->AL or 3-->ML ');
    else
        condizione = 1;
    end
end
    
% K = input(['Insert the number of clusters that you want in output, choose a number between 1 and ', num2str(nr-1), ' or choose 0 if you want to cut the tree in correspondence of the longer brantch ']);
condizione = 0;
while condizione == 0
    if K == 0
        condizione = 1;        
    elseif (K < 1) | (K > (nr-1))
        K = input(['choose a number between 1 and ', num2str(nr-1), ' or choose 0 ']);
    else 
        condizione = 1;
    end
end

if K ~= 0
    stop_iter = nr-K+1;
else
    stop_iter = nr;
end

k=1;
cluster_mat = {};
cluster_vet = {};
for i = 1:nr
    cluster_vet{i,1} = num2str(i);
    for j = 1:nc
        if j == 1;
            cluster_mat{i,j} = num2str(k);
            k = k+1;
        else
            cluster_mat{i,j} = ' ';
        end
    end
end

% memorizziamo di volta in volta il valore minimo selezionato
vect_distance = zeros(nr,1);
cluster_vet_stop = {};
vet_dendro_sup = (1:1:nr)';

for i = 2:nr   
    [mat_distance_new, cluster_vet_new, dist_select, vet_dendrogram, vet_dendro_sup_new] = updateDistanceMatrix(mat_distance, cluster_vet, rule, vet_dendro_sup);
    
    % aggiornamento vettore delle distanze minime
    vect_distance(i) = dist_select;
    
    % aggiornamento matrice delle distanze
    mat_distance = mat_distance_new;
    
    for j = 1:length(cluster_vet_new)
        cluster_mat{j,i} = cluster_vet_new(j);
    end

    if i == stop_iter
        cluster_vet_stop = cluster_vet_new;
    end
    
    cluster_vet = cluster_vet_new;
    
    mat_dendrogram((i-1),:) = vet_dendrogram;
    vet_dendro_sup = vet_dendro_sup_new;
end

if K == 0
    cluster_vet_stop = {};
    vect_diff = [];
    k = 1;
    for i = 2:length(vect_distance), 
        vect_diff(k,1) = vect_distance(i) - vect_distance(i-1); 
        k = k+1; 
    end
    brantch_longher = find(vect_diff == max(vect_diff), 1);
    stop_iter = brantch_longher + 1;
    
    k = 1;
    for i = 1:(nr - stop_iter + 1)       
        cluster_vet_stop{i,1} = cluster_mat{i, stop_iter};
        k = k+1;
    end
end

K = length(cluster_vet_stop);
