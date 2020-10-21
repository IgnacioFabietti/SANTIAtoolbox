function[mat_coordinate_clu_new, mat_coordinate_clu_old, mat_assegnamenti_finali, num_clu_sel] = somClustering(mat_data, K, measure)

mat_coordinate_sgn = mat_data;
[nr nc] = size(mat_coordinate_sgn);

% K = input(['Insert the number of clusters you want in output, choose a number between 1 and ', num2str(nr), ': ']);
K = round(K);
condizione = 0;
while condizione == 0        
    if (K < 1) | (K > nr)
        K = input(['choose a number between 1 and ', num2str(nr), ' ']);
        K = round(K);
    else 
        condizione = 1;
    end
end

num_clu_sel = K;

max_iter = 1000;% input('Insert the number of iterations, (default = 10000): ');

eta_max = 1.5;% input('Insert the value of the parameter eta, (default = 1.5): ');

% measure = input('Digit 1 for the Euclidean distance, 2 for the centered correlation, 3 for the uncenterd correlation: ');
condizione = 0;
while condizione == 0        
    if (measure ~= 1) & (measure ~= 2) & (measure ~= 3)
        measure = input('digit 1 (Euclidean distance) or 2 (centered corr.) or 3 (uncentered corr.): ');
    else 
        condizione = 1;
    end
end

vet_indici = 1:1:nr;

mat_coordinate_clu = generateInitialAssignments(mat_coordinate_sgn, K);
mat_coordinate_clu_old = mat_coordinate_clu;

num_iterazioni = max_iter;
for i = 1:num_iterazioni
    
    eta = eta_max*(1 - (i/num_iterazioni));
    
    % 1. random selection of a signal
    sgn_selected_tmp = ramdomAssignment(vet_indici);
    sgn_tmp = mat_coordinate_sgn(sgn_selected_tmp,:);
    
    % 2. selection of the closer neuron to the selected signal
    winner = calculateCloserCluster(sgn_tmp, mat_coordinate_clu, measure);
    
    % 3. modification of the position of the winner and of its neighbors
    mat_coordinate_clu = updateClusterAssignmentSOM(sgn_tmp, winner, mat_coordinate_clu, eta);
        
end

mat_assegnamenti_finali = clusterAssignmentSOM(mat_coordinate_sgn, mat_coordinate_clu, measure);

mat_coordinate_clu_new = mat_coordinate_clu;