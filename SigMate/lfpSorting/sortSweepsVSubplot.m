function[res1, res2, res3, res4] = sortSweepsVSubplot(Signal_Matrix, method_to_use, clustering_type, clusNo, criteria, measure, fileLength)

format long g

[nr nc] = size(Signal_Matrix);
N = nc;
Ts = 5.00500e-05;
Fs = 1/Ts;
t = (1:1:nc)'*Ts;
stimulus_onset = 0.15; % sec
posS = closer_point(t, stimulus_onset);

z = mean(Signal_Matrix);

%--------------------------------------------------------------------------
% filtering the signal with a butter_worth filter
cutoff_freq = 500; % 1kHZ
order = 5;
F_Matrix = zeros(nr,nc);
for a = 1:nr
    signal_tmp = Signal_Matrix(a, :);
    F_Matrix(a,:) = PB_butter_worth_filter(signal_tmp, Fs, cutoff_freq, order);
end

%--------------------------------------------------------------------------
% traslation of the signal as to bring to zero the point corresponding to
% the stimulus-onset istant.
TF_Matrix = zeros(nr,nc); % scaled signal matrix
for a=1:nr
    sgn_tmp = F_Matrix(a,:);
    if sgn_tmp(posS) > 0
        TF_Matrix(a,:) = sgn_tmp - sgn_tmp(posS);
    elseif sgn_tmp(posS) < 0
        TF_Matrix(a,:) = sgn_tmp + abs(sgn_tmp(posS));
    else
        TF_Matrix(a,:) = sgn_tmp;
    end
end

%--------------------------------------------------------------------------
% Generation of a single signal constitutes by the union of all the single
% sweep filtered and traslated 
Segnale_BIG_filtrato_posS_0 = lowPassFilterMatrix(TF_Matrix);
Segnale_BIG = Segnale_BIG_filtrato_posS_0;

%--------------------------------------------------------------------------
% variance
varianze = zeros(nr,1);
for a = 1:nr
    sgn_tmp = TF_Matrix(a,1:(posS-1));
    varianze(a) = var(sgn_tmp);
end

%--------------------------------------------------------------------------
% it's possible to notice that each signal presents a negative peak in the
% time interval [0.15 0.2].
pos_02 = closer_point(t, 0.2);
minimum_pos_matrix = zeros(nr,1);
for a = 1:nr
    vett_tmp = TF_Matrix(a, posS:pos_02);
    minimum_next_to_posS = find(vett_tmp == min(vett_tmp),1) + posS -1;
    minimum_pos_matrix(a) = minimum_next_to_posS;
end

%--------------------------------------------------------------------------
% 1) ricerca di punti preceduti e seguiti da 700 punti i cui valori risultano essere
% tutti o più grandi o piccoli dei loro, tali punti risultano quindi essere
% rispettivamente punti di minimo o di massimo.
% 2) modifica della sequenza di massimi e minimi ottenuta mediante il
% metodo "elimina_punti_specifici_prova5".
% 3) individuazione dell'istante di response-offset mediante il metodo 
% "ricerca_fine_risposta".

ending_points = zeros(nr,1);
first_max_points = zeros(nr,1);
num_MinMax_point = zeros(nr,1);
for c = 1:nr
    vett_pos_ok = zeros(nr,3);
    sgn_tmp = TF_Matrix(c, minimum_pos_matrix(c):end);
    f = 300;
    p = 1;
    for a = (f+1):(length(sgn_tmp)-f)
        if ( sgn_tmp(a) > sgn_tmp((a-f):(a-1)) & sgn_tmp(a) > sgn_tmp((a+1):(a+f)))
            vett_pos_ok(p,1) = a;
            vett_pos_ok(p,2) = 2;
            vett_pos_ok(p,3) = sgn_tmp(a);
            p = p+1;
        end
        if ( sgn_tmp(a) < sgn_tmp((a-f):(a-1)) & sgn_tmp(a) < sgn_tmp((a+1):(a+f)))
            vett_pos_ok(p,1) = a;
            vett_pos_ok(p,2) = 1;
            vett_pos_ok(p,3) = sgn_tmp(a);
            p = p+1;
        end
    end
    pos_10 = find(vett_pos_ok(:,1) == 0,1);
    vett_pos_ok = vett_pos_ok(1:(pos_10-1),:);
    
    [vett_pos_ok_max, vett_pos_ok_min] = elimina_punti_specifici_prova5(vett_pos_ok);
    
    first_max_points(c) = vett_pos_ok_max(1);
    
    vett_massimi = zeros(length(vett_pos_ok_max), 2);
    vett_massimi(:,1) = vett_pos_ok_max';
    vett_massimi(:,2) = 2;    
    vett_minimi = zeros(length(vett_pos_ok_min),2);
    vett_minimi(:,1) = vett_pos_ok_min';
    vett_minimi(:,2) = 1;
    
    [nrM, ncM] = size(vett_massimi);
    [nrm, ncm] = size(vett_minimi);
    vett_MinMax = zeros(nrM+nrm, 2);
    vett_MinMax(1:nrM,:) = vett_massimi;
    if nrm ~= 0
        vett_MinMax(nrM+1:end,:) = vett_minimi;
    end
    
    vett_MinMax_ord = sortrows(vett_MinMax);
    if length(vett_MinMax_ord) == 1
        m = 1;
        num_MinMax_point(c) = m;
    elseif length(vett_MinMax_ord) == 2
        m = 2;
        num_MinMax_point(c) = m;
    elseif length(vett_MinMax_ord) == 3
        m = 3;
        num_MinMax_point(c) = m;
    elseif length(vett_MinMax_ord) == 4
        m = 4;
        num_MinMax_point(c) = m;
    else
        m = 5;
        num_MinMax_point(c) = m;
    end    
    pos_best_next_to_zero = findEndOfResponse(sgn_tmp, vett_MinMax_ord,m);
    ending_points(c) = pos_best_next_to_zero + minimum_pos_matrix(c)-1;   
end
first_max_points = first_max_points + minimum_pos_matrix;

%--------------------------------------------------------------------------
% ricerca del punto di response-onset.
% metodo: individuazione del punto di massimo (pos_max_tmp) nell'intervallo identificato
% da posS e dal punto di minimo trovato nell'intervallo [0.15 0.2].
% Successiva ricerca del punto di minimo all'interno dell'intervalo 
% [posS pos_max_tmp].

starting_points = zeros(nr,1);
for a = 1:nr
    sgn_tmp = TF_Matrix(a,:);
    sgn_tmp = sgn_tmp(posS:minimum_pos_matrix(a));
    if sgn_tmp(1) >= 0
        sgn_tmp = sgn_tmp - abs(sgn_tmp(1));
    else
        sgn_tmp = sgn_tmp + abs(sgn_tmp(1));
    end
    
    [max_sgn_tmp pos_max_tmp] = max(sgn_tmp);    
    
    pos_min_tmp = 1;
    if pos_max_tmp ~= 1
        sgn_tmp2 = sgn_tmp(1:pos_max_tmp);
        [min_sgn_tmp pos_min_tmp] = min(sgn_tmp2);
    end
    
    starting_points(a) = pos_min_tmp + posS -1;    
end

%--------------------------------------------------------------------------
% generazione della template: 
% 1) calcolo della durata della template
% 2) allineamento delle onde rispetto al punto fiduciario (punto di minimo
%    nell'intervallo [0.15 0.2])
% 3) zero-padding.
num_punti_int_massimo_dopo_min = max(ending_points - minimum_pos_matrix)+1;
num_punti_int_massimo_prima_min = max(minimum_pos_matrix - starting_points)+1;
durata_TMP = num_punti_int_massimo_dopo_min + num_punti_int_massimo_prima_min -1;

TMP_matrix = zeros(100, durata_TMP);
for a = 1:nr    
    inizio = starting_points(a);
    fine = ending_points(a);
    pos_minimo_tmp = minimum_pos_matrix(a) - inizio + 1;
    inizio_inserimento = num_punti_int_massimo_prima_min - pos_minimo_tmp + 1;
    sgn_tmp = TF_Matrix(a,inizio:fine);
    TMP_matrix(a,inizio_inserimento:(length(sgn_tmp)+inizio_inserimento-1)) = sgn_tmp;
end

%--------------------------------------------------------------------------
% generazione della template come media dei segnali allineati.
avg_TMP = mean(TMP_matrix);
t_TMP = 1:1:length(avg_TMP);

%--------------------------------------------------------------------------
varianze2 = var(TF_Matrix);

%--------------------------------------------------------------------------
% Down-Sampling
%caso1
z_cut = avg_TMP(1:end);

passo = 10;
z_sc = zeros(fix(length(z_cut)/10),1);
varianze_sc = zeros(fix(length(z_cut)/10),1);
k = 1;
for a = 1:length(z_cut)
    if rem(a,passo)==0
        z_sc(k) = z_cut(a);
        varianze_sc(k) = varianze2(a);
        k = k+1;
    end
end
t_sc = passo:passo:(length(z_sc)*passo);
% t_sc = t_sc'*Ts;
t_sc = t_sc';

%--------------------------------------------------------------------------
%--------------------------------------------------------------------------
% Fitting the signal.

waitbarMsg ={'Please Wait...', 'Perfoming Signal Estimation for Template Generation...',' '};
wbHandle=waitbar(0,waitbarMsg,'Name','Signal Estimation in Progress');        


y_pred_avg_long = zeros(length(avg_TMP),1);
q = 0;
t = (1:1:length(avg_TMP))';

for f = 4:2:30
%     f
    waitbar(f/30);
    
    q = q+1;    
    
    N_sc = length(z_sc);
    vett_pos_ok = zeros(100,3);
    vett_pos_ok_min = zeros(1,100);
    vett_pos_ok_max = zeros(1,100);
    p = 1;
    h = 1;
    k = 1;

    for a = (f+1):(N_sc-f)
        if ( z_sc(a) > z_sc((a-f):(a-1)) & z_sc(a) > z_sc((a+1):(a+f)))
            vett_pos_ok(p,1) = a;
            vett_pos_ok(p,2) = 2;
            vett_pos_ok(p,3) = z_sc(a);
            p = p+1;
            vett_pos_ok_max(k) = a;
            k = k+1;
        end 
        if ( z_sc(a) < z_sc((a-f):(a-1)) & z_sc(a) < z_sc((a+1):(a+f)))
            vett_pos_ok(p,1) = a;
            vett_pos_ok(p,2) = 1;
            vett_pos_ok(p,3) = z_sc(a);
            p = p+1;
            vett_pos_ok_min(h) = a;
            h = h+1;
        end   
    end

    pos_10 = find(vett_pos_ok(:,1) == 0,1);
    vett_pos_ok = vett_pos_ok(1:(pos_10-1),:);
    pos_10_max = find(vett_pos_ok_max == 0,1);
    vett_pos_ok_max = vett_pos_ok_max(1:(pos_10_max-1));     
    pos_10_min = find(vett_pos_ok_min == 0,1);
    vett_pos_ok_min = vett_pos_ok_min(1:(pos_10_min-1));
    
%     figure(1)
%     hold on
%     plot(t_sc, z_sc, 'bo', t_sc, zeros(length(t_sc),1), 'k-.')
%     plot(t_sc(vett_pos_ok_min), z_sc(vett_pos_ok_min),'go',t_sc(vett_pos_ok_max), z_sc(vett_pos_ok_max),'mo')
%     hold off
%     title(['Min-Max points found in z-sc, f = ', num2str(f)])
%     xlabel('time [sec]')
%     ylabel('voltage [mV]')
%     legend('down-sampled signal', 'zero', 'minimum points', 'maximum points')
    
%--------------------------------------------------------------------------
    struct.t = t_sc;
    struct.z = z_sc;
    struct.sd = sqrt(varianze_sc);

%--------------------------------------------------------------------------
% PARAMETERS INIZIALIZATION   

    m = vett_pos_ok(:,1)'.*passo;  
    A = vett_pos_ok(:,3)';
    B = 200*ones(1,length(A));
    for a = 1:length(vett_pos_ok)
        Mom = vett_pos_ok(a,2);
        if ((Mom == 1) & (A(a) > 0))
            A(a) = -1*A(a);
        end
        if ((Mom == 2) & (A(a) < 0))
            A(a) = -1*A(a);
        end
    end
    struct.p = [m,A,B]';
    
    %--------------------------------------------------------------------------
    y = zeros(length(t_sc),1);
    for b = 1:length(m)
        sigma_tmp = B(b)/(sqrt(2*pi)*A(b));
        y = y+ A(b)*exp(-1/2*((t_sc-m(b))/sigma_tmp).^2);
    end
    
%     figure(1)    
%     plot(t_sc, z_sc, 'bo', t_sc, y, 'r', t_sc, zeros(length(t_sc),1), 'k-.')
%     title(['Initial fit funciton, f = ', num2str(f)])
%     xlabel('time [sec]')
%     ylabel('voltage [mV]')
%     legend('Down-sampled signal','initial fit function', 'zero')
    
%--------------------------------------------------------------------------

% creation of the parameters upper and lower bounds
    options = optimset('TolFun', 1e-15, 'TolX', 1e-15, 'MaxFunEval', 1e15, 'MaxIter', 400);

    m_lim = 1000;
    struct.pup = zeros(length(struct.p),1);
    struct.pdown = zeros(length(struct.p),1);
    for a = 1:length(struct.p)
        if struct.p(a) > 0
            struct.pup(a) = struct.p(a)*m_lim;
            struct.pdown(a) = struct.p(a)/m_lim;
        else
            struct.pup(a) = struct.p(a)/m_lim;
            struct.pdown(a) = struct.p(a)*m_lim;
        end
    end

    p_est = lsqnonlin('gauss_generic', struct.p, struct.pdown, struct.pup, options, struct);
    
    num_gaussiane = length(p_est)/3;
    m = p_est(1:num_gaussiane);
    A = p_est((num_gaussiane+1):(2*num_gaussiane));
    B = p_est((2*num_gaussiane+1):end);

    y_pred_long = zeros(length(avg_TMP),1);
    for b = 1:num_gaussiane
        sigma_tmp = B(b)/(sqrt(2*pi)*A(b));
        y_pred_long = y_pred_long + A(b)*exp(-1/2*((t-m(b))/sigma_tmp).^2);
    end  
    y_pred_avg_long = y_pred_avg_long + y_pred_long;    
end

close(wbHandle)

y_pred_avg_long = y_pred_avg_long/q;

%--------------------------------------------------------------------------
%--------------------------------------------------------------------------
% Wavesform Recognition
% Methods proposed: matched filter, contourn method.

% method_to_use = input('Insert 1 if you want to use the matched filter or insert 2 if you want to use the contourn method: ');

switch method_to_use
    
    case 1
        % Contourn method.
        
        TMP_fit = y_pred_avg_long';
        
        N_TMP = length(TMP_fit);
        pos_sf = (nc:nc:(nc*nr))';
        t_BIG = (1:1:(nc*nr))';
        
        % Generation of the variance signal 
        VTMP = zeros(1,length(TMP_fit));
        for i=1:length(TMP_fit)
            summation = 0;
            for j=1:nr
                sgn_tmp = TMP_matrix(j,:);
                summation = summation + (sgn_tmp(i) - TMP_fit(i))^2;
            end
            VTMP(i) = summation/nr;
        end

        Sup_lim = zeros(1,length(TMP_fit));
        Inf_lim = zeros(1,length(TMP_fit));

        variance = mean(VTMP);
        SD = sqrt(variance);
        
        % variable parameters
        a = SD;
        b = 3*SD;

        waitbarMsg ={'Please Wait...', 'Calculating Upper and Lower Bounds of Template...',' '};
        wbHandle=waitbar(0,waitbarMsg,'Name','Upper and Lower Bounds Calculation in Progress');         
        
        % calculus of upper and lower bounds
        for i = 1:length(TMP_fit)
            Sup_lim(i) = TMP_fit(i) + (a*sqrt(VTMP(i))+b);
            Inf_lim(i) = TMP_fit(i) - (a*sqrt(VTMP(i))+b);
            
            waitbar(i/length(TMP_fit));
        end
        
        close(wbHandle)
        
        % calculus of the time instants
        istant_time_ok = [];
        k = 1;
        
        waitbarMsg ={'Please Wait...', 'Calculating Parameters for Waveform Recognition...',' '};
        wbHandle=waitbar(0,waitbarMsg,'Name','Parameters Calculation in Progress');         
        
        for i=N_TMP:length(Segnale_BIG)
            x_tmp = Segnale_BIG((i-N_TMP+1):i);
            if (x_tmp >= Inf_lim) 
                if (x_tmp <= Sup_lim)                
                    istant_time_ok(k) = i;
                    k = k+1;
                end
            end
            comPer=sprintf('%5.2f %% Complete...',i/length(Segnale_BIG)*100);
            updatedMssg={'Please Wait...', 'Calculating Parameters for Waveform Recognition...', comPer};
            waitbar(i/length(Segnale_BIG), wbHandle, updatedMssg)
        end
        
        close(wbHandle)
        
        % calculus of the correct assignement probability
        VP_num = 0;
        FP_num = 0;
        FN_num = 0;
        VN_num = 0;
        single_sweep_recognized=[];
        x = 1;

        waitbarMsg ={'Please Wait...', 'Performing Single Sweep Recognition...',' '};
        wbHandle=waitbar(0,waitbarMsg,'Name','Single Sweep Recognition in Progress');                 
        
        for i=fileLength:fileLength:length(Segnale_BIG)
            pos = i;

            if (~isempty(find(istant_time_ok == pos)))&&(~isempty(find(pos_sf == pos)))
                VP_num = VP_num+1;
                single_sweep_recognized(x) = i;
                x = x+1;

            elseif (~isempty(find(istant_time_ok == pos)))
                FP_num = FP_num+1;
            
            elseif (~isempty(find(pos_sf == pos)))
                FN_num = FN_num+1;
            
            else
                VN_num = VN_num+1;
            end    
            
            waitbar(i/length(Segnale_BIG))            
        end
        
        close(wbHandle)
        
        Prob_correct_assignment = (VP_num + VN_num)/length(Segnale_BIG);

        single_sweep_recognized = single_sweep_recognized/nc;
        
        figure('NumberTitle','Off','Name','Recognized Single Sweeps with Template and its Upper and Lower Bounds');
        for i=1:nr
            hold on
            plot(t',TMP_matrix(i,:))
        end
        plot(t',TMP_fit,'r-')
        plot(t',Sup_lim,'g-',t',Inf_lim,'g-')
        hold off

%         figure(2)
%         hold on
%         plot(t_BIG', Segnale_BIG, t_BIG', zeros(length(t_BIG),1),'k-.')
%         plot(t_BIG(istant_time_ok)',0*Segnale_BIG(istant_time_ok), 'r*')
%         plot(t_BIG(pos_sf)', 0*Segnale_BIG(pos_sf), 'ko')
%         hold off
%         title(['Signal obtained by the union of the ',num2str(nr),' sweeps'])
%         ylabel('Voltage [mV]')
        
    case 2
        %------------------------------------------------------------------
        % Filtro MACHED
        % using as template the averaged fit signal.
        
        TMP_fit = y_pred_avg_long';

        TMP_fit = fliplr(TMP_fit);
        N_TMP = length(TMP_fit);
        
        sgn_tmp = Segnale_BIG';
        
        y_matched = zeros(1,length(sgn_tmp));
        for a = N_TMP:length(sgn_tmp)    
            x_tmp = sgn_tmp((a-N_TMP+1):a);
            x_tmp = flipud(x_tmp);
            y_matched(a) = TMP_fit*x_tmp;
        end
        
        %------------------------------------------------------------------                
        % positions of the end of each sweep
        pos_sf = (nc:nc:(nc*nr))';
        t_BIG = (1:1:(nc*nr))';
        
        figure(1)
        subplot(211)
        hold on
        plot(t_BIG, sgn_tmp, t_BIG, zeros(length(t_BIG),1),'k-.')
        plot(t_BIG(pos_sf), 0*sgn_tmp(pos_sf), 'ro')
        hold off
        title(['Signal obtained by the union of the ',num2str(nr),' sweeps'])
        ylabel('Voltage [mV]')
        subplot(212)
        hold on
        plot(y_matched)
        plot(t_BIG(pos_sf), y_matched(pos_sf), 'ro', t_BIG, zeros(length(t_BIG),1),'k-.')
        hold off
        title('Matched filter output')
        
        %------------------------------------------------------------------
        % research of the maximum points inside the matched filter output 
        % (y_matched). A point is a maximum if it's preceded and followed 
        % by a number f of values smaller than it.
        f = 100;
        N_big = length(y_matched);
        vett_pos_massimi = zeros(1,20000);
        k = 1;
        
        for a = (f+1):(N_big-f)
            if ( y_matched(a) > y_matched((a-f):(a-1)) & y_matched(a) > y_matched((a+1):(a+f)))
                vett_pos_massimi(k) = a;
                k = k+1;
            end   
        end
        
        pos_10_max = find(vett_pos_massimi == 0,1);
        vett_pos_massimi = vett_pos_massimi(1:(pos_10_max-1));     
        %------------------------------------------------------------------
        % research between the all maximum points those which are closer to the
        % ending poinds of each sweep.
        
        point_closer_to_end = [];
        k = 1;
        for a = 1:length(pos_sf)
            pos_end_tmp = pos_sf(a);
            closer_point_tmp = closer_point(vett_pos_massimi, pos_end_tmp);
            point_closer_to_end(k) = vett_pos_massimi(closer_point_tmp);
            k = k+1;
        end
        
        %------------------------------------------------------------------
        % calcoulus of the best threshold to reach the highest correct assignament
        % probability.
        best_threshold = 0;
        k = 1;
        Prob_correct_assignment_old = 0;
        VP_num_best = 0;
        for b = -500:1:1500
            VP_num = 0;
            FP_num = 0;
            FN_num = 0;
            VN_num = 0;
            threshold = b;
            for a = 1:length(vett_pos_massimi)
                pos_max_tmp = vett_pos_massimi(a);
                val_corrisp = y_matched(pos_max_tmp);
                if val_corrisp >= threshold;
                    if (length(find(point_closer_to_end == pos_max_tmp)) == 1)
                        VP_num = VP_num + 1;
                    else
                        FP_num = FP_num +1;
                    end
                else
                    if (length(find(point_closer_to_end == pos_max_tmp)) == 1)
                        FN_num = FN_num + 1;
                    else
                        VN_num = VN_num +1;
                    end
                end
            end
            Prob_correct_assignment = (VP_num + VN_num)/length(vett_pos_massimi);
            k = k+1;
            if Prob_correct_assignment > Prob_correct_assignment_old
                VP_num_best = VP_num;
                best_threshold = threshold;
                Prob_correct_assignment_old = Prob_correct_assignment;        
            end
        end
        
        %--------------------------------------------------------------------------
        % instant recognized
        pos_ist_rec = [];
        k = 1;
        for a = 1:length(point_closer_to_end)
            val_corrisp = y_matched(point_closer_to_end(a));
            if val_corrisp >= best_threshold
                pos_ist_rec(k) = point_closer_to_end(a);
                k = k+1;
            end
        end
        pos_ist_rec = round(pos_ist_rec/nc);
        single_sweep_recognized = pos_ist_rec;
        
        %--------------------------------------------------------------------------
        figure(2)
        hold on
        plot(t_BIG, y_matched, t_BIG, zeros(length(t_BIG),1),'k-.')
        plot(t_BIG, best_threshold*ones(length(t_BIG),1), 'r--','LineWidth',2)
        plot(t_BIG(vett_pos_massimi), y_matched(vett_pos_massimi), 'go')
        plot(t_BIG(point_closer_to_end), y_matched(point_closer_to_end), 'r*')
        % plot(t_BIG(pos_sf), y_matched(pos_sf), 'ro', t_BIG, zeros(length(t_BIG),1),'k-.', t_BIG(pos_sf), y_matched(pos_sf), 'r*')
        % plot(t_BIG(vett_pos_massimi), y_matched(vett_pos_massimi), 'go', t_BIG(point_closer_to_end), y_matched(point_closer_to_end), 'm*')
        hold off
        title('Matched filter output')
        
        %------------------------------------------------------------------
end

%--------------------------------------------------------------------------
%--------------------------------------------------------------------------
% CLUSTERING.
% display('Start with the clustering analysis')
% display(' ')

t = (1:1:nc)'*Ts;

num_sgn_sel = length(single_sweep_recognized);

TF_Matrix_sgn_selected = TF_Matrix(single_sweep_recognized, :);

% ending_points_selected = ending_points(single_sweep_recognized);
% starting_points_selected = starting_points(single_sweep_recognized); 
% num_MinMax_point_selected = num_MinMax_point(single_sweep_recognized);

% case 1
% minimum_pos_matrix_selected = minimum_pos_matrix(single_sweep_recognized);
% Pmin_minimum_pos_matrix_selected = min(minimum_pos_matrix_selected);
% time_grid = linspace(Pmin_minimum_pos_matrix_selected, nc, 400);
% time_grid = round(time_grid);

% case 2
first_max_points_selected = first_max_points(single_sweep_recognized);
Pmin_first_max_points_selected = min(first_max_points_selected);
gap=ceil((nc-Pmin_first_max_points_selected)/200);
time_grid = (Pmin_first_max_points_selected:gap:nc);


Parameters_matrix = TF_Matrix_sgn_selected(:, time_grid);

% display('Clustering k-mean --> 1')
% display('Clustering som --> 2')
% display('Clustering agglomerative --> 3')
% display(' ')
% clustering_type = input('What type of clustering do you want to use? Insert 1, 2 or 3: ');

switch clustering_type
    
    % K-means
    case 1
        [mat_coordinate_clu_best, mat_coordinate_clu_old_best, mat_appartenenze_best, K] = kMeansClustering(Parameters_matrix, clusNo, criteria, measure);
        
        res1 = mat_coordinate_clu_best;
%         res2 = mat_coordinate_clu_old_best;
        res3 = length(single_sweep_recognized');
%         res3 = mat_appartenenze_best;
%         res4 = K;
        
        mat_appartenenze_best(:,1) = single_sweep_recognized';
        [clu pos_cl] = sort(mat_appartenenze_best(:,2));
        f1 = mat_appartenenze_best(:,1);
        f2 = f1(pos_cl);
        mat_appartenenze_best_ord(:,1) = f2;
        mat_appartenenze_best_ord(:,2) = clu;
        
        res2 = mat_appartenenze_best_ord;        
        
        clu_num = 1;
        i = 1;
        summation = 0;
        p = 0;
        
        clusteredAverages=zeros(length(t),K+1);
        clusteredAverages(:,1)=t;
        
        figure('NumberTitle','Off','Name','Clustering of Single Sweeps using K-Means')
        
        avgIndx=2;
        
        if rem(clusNo, 2)
            spNo = floor(clusNo/2)+1;
        else
            spNo = floor(clusNo/2);
        end
        
        while i <= num_sgn_sel
            if mat_appartenenze_best_ord(i,2) == clu_num
                pos_min_tmp = minimum_pos_matrix(mat_appartenenze_best_ord(i,1));
                pos_max_tmp = first_max_points(mat_appartenenze_best_ord(i,1));
                pos_end_tmp = ending_points(mat_appartenenze_best_ord(i,1));
                pos_start_tmp = starting_points(mat_appartenenze_best_ord(i,1));
                sgn_tmp = TF_Matrix(mat_appartenenze_best_ord(i,1),:);
                summation = summation + sgn_tmp;
                p = p+1;
                            
                subplot(spNo,2,clu_num)
                hold on
                plot(t, sgn_tmp)
                i = i+1;
            else
                summation = summation/p;
                
                clusteredAverages(:,avgIndx)=summation;
                avgIndx=avgIndx+1;
                
                subplot(spNo,2,clu_num)
                
                plot(t, summation, 'r', 'LineWidth',1.5)
                
                hold off
                title(['cluster ', num2str(clu_num)])
                summation = 0;
                p = 0;
                clu_num = clu_num + 1;
            end
        end
        if clu_num == K 
                summation = summation/p;
                
                clusteredAverages(:,avgIndx)=summation;
                avgIndx=avgIndx+1;
                
                subplot(spNo,2,clu_num)
                
                plot(t, summation, 'r','LineWidth',1.5)
                
                hold off
                title(['cluster ', num2str(clu_num)])
        end
        
        res4=clusteredAverages;        

    % Agglomerative Clustering          
    case 2
        [cluster_mat, cluster_vet_stop, vect_distance, K, mat_dendrogram] = agglomerativeClustering(Parameters_matrix, measure, criteria, clusNo);
        
        res1 = cluster_mat;
        res2 = cluster_vet_stop;
        res3 = vect_distance;
        res4 = K;
        
        mat_appartenenze_best = zeros(num_sgn_sel,2);
        mat_appartenenze_best(:,1) = 1:1:num_sgn_sel;
        for i = 1:K
            clu_tmp = cluster_vet_stop{i};
            pos_tmp = idstrip(clu_tmp)';
            mat_appartenenze_best(pos_tmp,2) = i;
        end
        
        mat_appartenenze_best(:,1) = single_sweep_recognized';
        [clu pos_cl] = sort(mat_appartenenze_best(:,2));
        f1 = mat_appartenenze_best(:,1);
        f2 = f1(pos_cl);
        mat_appartenenze_best_ord(:,1) = f2;
        mat_appartenenze_best_ord(:,2) = clu;
        
        clu_num = 1;
        i = 1;
        summation = 0;
        p = 0;
        
        figure('NumberTitle','Off','Name','Clustering of Single Sweeps using Agglomerative Clustering')        
        
        while i <= num_sgn_sel
            if mat_appartenenze_best_ord(i,2) == clu_num
                pos_min_tmp = minimum_pos_matrix(mat_appartenenze_best_ord(i,1));
                pos_max_tmp = first_max_points(mat_appartenenze_best_ord(i,1));
                pos_end_tmp = ending_points(mat_appartenenze_best_ord(i,1));
                pos_start_tmp = starting_points(mat_appartenenze_best_ord(i,1));
                sgn_tmp = TF_Matrix(mat_appartenenze_best_ord(i,1),:);
                
                summation = summation + sgn_tmp;
                p = p+1;
                            
                subplot(5,2,clu_num)
                hold on
                plot(t, sgn_tmp)
                i = i+1;
            else
                summation = summation/p;
                subplot(5,2,clu_num)
                
                plot(t, summation, 'r', 'LineWidth',1.5)
                
                hold off
                title(['cluster ', num2str(clu_num)])
                summation = 0;
                p = 0;
                clu_num = clu_num + 1;
            end
        end
        if clu_num == K 
                summation = summation/p;
                subplot(5,2,clu_num)
                
                plot(t, summation, 'r','LineWidth',1.5)
                
                hold off
                title(['cluster ', num2str(clu_num)])
        end                
%                 figure(clu_num+2)
%                 hold on
%                 plot(t, sgn_tmp)
%                 plot(t(pos_min_tmp), sgn_tmp(pos_min_tmp), 'r*')
%                 plot(t(pos_max_tmp), sgn_tmp(pos_max_tmp), 'm*')
%                 plot(t(pos_end_tmp), sgn_tmp(pos_end_tmp), 'g*')
%                 plot(t(pos_start_tmp), sgn_tmp(pos_start_tmp), 'y*')
%                 hold off
%                 title(['Sweeps part of the cluster ', num2str(clu_num)])
%                 i = i+1;
%             else
%                 clu_num = clu_num + 1;
%             end
%         end
        figure('NumberTitle','Off','Name','Dendogram after Agglomerative Clustering')
        dendrogram(mat_dendrogram)
        title('dendrogram')
        xlabel('elements')
        ylabel('distance values') 
        
    % SOM Clustering  
    case 3
        
        [mat_coordinate_clu_new, mat_coordinate_clu_old, mat_assegnamenti_finali, K] = somClustering(Parameters_matrix, clusNo, measure);
        
        res1 = mat_coordinate_clu_new;
        res2 = mat_coordinate_clu_old;
        res3 = mat_assegnamenti_finali;
        res4 = K;
        
        mat_appartenenze_best = mat_assegnamenti_finali;
        
        mat_appartenenze_best(:,1) = single_sweep_recognized';
        [clu pos_cl] = sort(mat_appartenenze_best(:,2));
        f1 = mat_appartenenze_best(:,1);
        f2 = f1(pos_cl);
        mat_appartenenze_best_ord(:,1) = f2;
        mat_appartenenze_best_ord(:,2) = clu;
        
        clu_num = 1;
        i = 1;
        summation = 0;
        p = 0;
        
        figure('NumberTitle','Off','Name','Clustering of Single Sweeps using Self-Organizing Maps')
        
        while i <= num_sgn_sel
            if mat_appartenenze_best_ord(i,2) == clu_num
                pos_min_tmp = minimum_pos_matrix(mat_appartenenze_best_ord(i,1));
                pos_max_tmp = first_max_points(mat_appartenenze_best_ord(i,1));
                pos_end_tmp = ending_points(mat_appartenenze_best_ord(i,1));
                pos_start_tmp = starting_points(mat_appartenenze_best_ord(i,1));
                sgn_tmp = TF_Matrix(mat_appartenenze_best_ord(i,1),:);

                summation = summation + sgn_tmp;
                p = p+1;
                            
                subplot(5,2,clu_num)
                hold on
                plot(t, sgn_tmp)
                i = i+1;
            else
                summation = summation/p;
                subplot(5,2,clu_num)
                
                plot(t, summation, 'r', 'LineWidth',1.5)
                
                hold off
                title(['cluster ', num2str(clu_num)])
                summation = 0;
                p = 0;
                clu_num = clu_num + 1;
            end
        end
        if clu_num == K 
                summation = summation/p;
                subplot(5,2,clu_num)
                
                plot(t, summation, 'r','LineWidth',1.5)
                
                hold off
                title(['cluster ', num2str(clu_num)])
        end                  
%                 figure(clu_num+2)
%                 hold on
%                 plot(t, sgn_tmp)
%                 plot(t(pos_min_tmp), sgn_tmp(pos_min_tmp), 'r*')
%                 plot(t(pos_max_tmp), sgn_tmp(pos_max_tmp), 'm*')
%                 plot(t(pos_end_tmp), sgn_tmp(pos_end_tmp), 'g*')
%                 plot(t(pos_start_tmp), sgn_tmp(pos_start_tmp), 'y*')
%                 hold off
%                 title(['Sweeps part of the cluster ', num2str(clu_num)])
%                 i = i+1;
%             else
%                 clu_num = clu_num + 1;
%             end
%         end        
end