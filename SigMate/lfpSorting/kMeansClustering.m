function[mat_coordinate_clu_best, mat_coordinate_clu_old_best, mat_appartenenze_best, num_clu_sel] = kMeansClustering(mat_data, clusNo, criteria, measure)

mat_coordinate_sgn = mat_data;
[nr nc] = size(mat_coordinate_sgn);

msgHandle=msgbox(['No. of Sweeps recognized are: ' num2str(nr)], 'Result of Sweep Recognition');

K = clusNo; %input(['Insert the number of clusters you want in output, choose a number between 1 and ', num2str(nr), ' ']);
K = round(K);
condizione = 0;
% while condizione == 0        
%     if (K < 1) || (K > nr)|| isnan(K)
%         K = input(['choose a number between 1 and ', num2str(nr), ' ']);
%         K = round(K);
%     else 
%         condizione = 1;
%     end
% end

num_clu_sel = K;

max_iter = 1000;%input('Insert the number of iterations ');

% display('criteria 1 = minimization of the sum of the distances');
% display('criteria 2 = minimization of the sum of variances of the different clusters');
% display('criteria 3 = minimization of the ratio of the variance inside clusters and between clusters');

% criteria = input('Insert the number of the criteria you want to use, choose a number between 1, 2 and 3: ');
condizione = 0;
while condizione == 0        
    if (criteria ~= 1) & (criteria ~= 2) & (criteria ~= 3)
        criteria = input('digit 1, 2 or 3: ');
    else 
        condizione = 1;
    end
end

% measure = 2; %input('Digit 1 for the Euclidean distance, 2 for the centered correlation, 3 for the uncenterd correlation: ');
condizione = 0;
while condizione == 0        
    if (measure ~= 1) & (measure ~= 2) & (measure ~= 3)
        measure = input('digit 1 (Euclidean distance) or 2 (centered corr.) or 3 (uncentered corr.): ');
    else 
        condizione = 1;
    end
end

variance_old = 10^9;
ratio_old = 10^9;
mat_coordinate_clu_best = [];
mat_appartenenze_best = [];
mat_coordinate_clu_old_best = [];

waitbarMsg ={'Please Wait...', 'Performing K-Means Clustering...',' '};
wbHandle=waitbar(0,waitbarMsg,'Name','K-Means Clustering in Progress'); 

for h = 1:max_iter
    
    comPer=sprintf('%5.2f %% Complete...',h/max_iter*100);
    updatedMssg={'Please Wait...', 'Performing K-Means Clustering...', comPer};
    waitbar(h/max_iter, wbHandle, updatedMssg)
    
    mat_coordinate_clu = generateInitialAssignments(mat_coordinate_sgn, K);
    mat_coordinate_clu_old = mat_coordinate_clu;

    mat_appartenenze = zeros(nr,2);
    mat_appartenenze(:,1) = 1:1:nr;
    mat_appartenenze(:,2) = round(1 + (K-1)*rand(nr,1))';

    condizione = 1;
    iterazioni = 1000;
    mat_appartenenze_old = mat_appartenenze;

    while condizione == 1
        for i = 1:iterazioni
            [mat_appartenenze mat_coordinate_clu] = updateClusterAssignment(mat_appartenenze, mat_coordinate_clu, mat_coordinate_sgn, measure);
            if mat_appartenenze_old == mat_appartenenze;
                condizione = 0;
                break
            else
                mat_appartenenze_old = mat_appartenenze;
            end       
        end
        condizione = 0;
    end
%--------------------------------------------------------------------------  
    switch criteria
        case 1
        % Optimization criteria 1
        % minimizes the total sum of distances of signals from the cluster to which they belong 
    
        variance = findSumOfDistances(mat_appartenenze, mat_coordinate_clu, mat_coordinate_sgn);
        if variance < variance_old
            mat_coordinate_clu_best = mat_coordinate_clu;
            mat_coordinate_clu_old_best = mat_coordinate_clu_old; 
            mat_appartenenze_best = mat_appartenenze;
            variance_old = variance;            
        end
%--------------------------------------------------------------------------  
        case 2
        % Optimization criteria 2
        % minimizes the sum of variance of all K clusters in which the
        % signals are divided
    
        variance = findSumOfVariances(mat_appartenenze, mat_coordinate_clu, mat_coordinate_sgn);
        if variance < variance_old
            mat_coordinate_clu_best = mat_coordinate_clu;
            mat_coordinate_clu_old_best = mat_coordinate_clu_old; 
            mat_appartenenze_best = mat_appartenenze;
            variance_old = variance;
        end
%-------------------------------------------------------------------------- 
        case 3
        % Optimization criteria 3
        % minimizes the ratio of the variance within clusters and the
        % variance between clusters
    
        variance_entro = calculateVarianceWithinCluster(mat_appartenenze, mat_coordinate_clu, mat_coordinate_sgn);
        varince_tra = calculateVarianceBetweenClusters(mat_appartenenze, mat_coordinate_clu, mat_coordinate_sgn);
        ratio = variance_entro/varince_tra;
        if ratio < ratio_old
            mat_coordinate_clu_best = mat_coordinate_clu;
            mat_coordinate_clu_old_best = mat_coordinate_clu_old; 
            mat_appartenenze_best = mat_appartenenze;
            ratio_old = ratio;
        end
    end    
end

close(wbHandle);
close(msgHandle);