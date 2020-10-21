function[mat_coordinate_clu_best, mat_coordinate_clu_old_best, mat_appartenenze_best, num_clu_sel] = fun_clustering_kmeans(mat_data)

mat_coordinate_sgn = mat_data;
[nr nc] = size(mat_coordinate_sgn);

K = input(['Insert the number of clusters you want in output, choose a number between 1 and ', num2str(nr), ' ']);
K = round(K);
condizione = 0;
while condizione == 0        
    if (K < 1) | (K > nr)| (K == NaN)
        K = input(['choose a number between 1 and ', num2str(nr), ' ']);
        K = round(K);
    else 
        condizione = 1;
    end
end

num_clu_sel = K;

max_iter = input('Insert the number of iterations ');

display('criteria 1 = minimization of the sum of the distances');
display('criteria 2 = minimization of the sum of variances of the different clusters');
display('criteria 3 = minimization of the ratio of the variance inside clusters and between clusters');

criteria = input('Insert the number of the criteria you want to use, choose a number between 1, 2 and 3: ');
condizione = 0;
while condizione == 0        
    if (criteria ~= 1) & (criteria ~= 2) & (criteria ~= 3)
        criteria = input('digit 1, 2 or 3: ');
    else 
        condizione = 1;
    end
end

measure = input('Digit 1 for the Euclidean distance, 2 for the centered correlation, 3 for the uncenterd correlation: ');
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

for h = 1:max_iter
    
    mat_coordinate_clu = funz_initial_positions_gen(mat_coordinate_sgn, K);
    mat_coordinate_clu_old = mat_coordinate_clu;

    mat_appartenenze = zeros(nr,2);
    mat_appartenenze(:,1) = 1:1:nr;
    mat_appartenenze(:,2) = round(1 + (K-1)*rand(nr,1))';

    condizione = 1;
    iterazioni = 1000;
    mat_appartenenze_old = mat_appartenenze;

    while condizione == 1
        for i = 1:iterazioni
            [mat_appartenenze mat_coordinate_clu] = funz_Aggiorna_Appartenenze(mat_appartenenze, mat_coordinate_clu, mat_coordinate_sgn, measure);
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
        % criterio di ottimizzazione 1
        % minimizzo la somma totale delle distanze dei segnali dai cluster a
        % cui appartengono.
    
        variance = funz_variance_calc(mat_appartenenze, mat_coordinate_clu, mat_coordinate_sgn);
        if variance < variance_old
            mat_coordinate_clu_best = mat_coordinate_clu;
            mat_coordinate_clu_old_best = mat_coordinate_clu_old; 
            mat_appartenenze_best = mat_appartenenze;
            variance_old = variance;            
        end
%--------------------------------------------------------------------------  
        case 2
        % criterio di ottimizzazione 2
        % minimizzo la somma della varianza di tutti i K cluster in cui sono
        % suddivisi i segnali.
    
        variance = funz_variance_calc_new(mat_appartenenze, mat_coordinate_clu, mat_coordinate_sgn);
        if variance < variance_old
            mat_coordinate_clu_best = mat_coordinate_clu;
            mat_coordinate_clu_old_best = mat_coordinate_clu_old; 
            mat_appartenenze_best = mat_appartenenze;
            variance_old = variance;
        end
%-------------------------------------------------------------------------- 
        case 3
        % criterio di ottimizzazione 3
        % minimizzo il rapporto tra la varianza entro cluster e la varianza tra
        % cluster.
    
        variance_entro = funz_variance_entro(mat_appartenenze, mat_coordinate_clu, mat_coordinate_sgn);
        varince_tra = funz_variance_tra(mat_appartenenze, mat_coordinate_clu, mat_coordinate_sgn);
        ratio = variance_entro/varince_tra;
        if ratio < ratio_old
            mat_coordinate_clu_best = mat_coordinate_clu;
            mat_coordinate_clu_old_best = mat_coordinate_clu_old; 
            mat_appartenenze_best = mat_appartenenze;
            ratio_old = ratio;
        end
    end    
end