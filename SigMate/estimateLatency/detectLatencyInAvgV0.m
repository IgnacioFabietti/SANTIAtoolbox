function detectLatencyInAvgV0(filePath, fileName)

    % clear all
    % close all
    % clc

    finalPath=[filePath,fileName];
    data1 = load (finalPath);
    
    t = data1(:,1);
    z = data1(:,2);
    N = length(t);
    ST = 0.150000;              % starting time
    durata_stimolo = 0.05;
    FT = ST + durata_stimolo;   % finishing time
    T = t(2)-t(1);              % sampling step

    Fs=1/T;                     % sampling frequency
    steadyState=z(1:round(Fs*ST));
    z=z-mean(steadyState);
    
    diffS = zeros(N,1);
    diffF = zeros(N,1);
    for a = 1:N
        diffS(a) = abs(t(a)-ST);
        diffF(a) = abs(t(a)-FT);
    end
    posS = find(diffS == min(diffS));
    posF = find(diffF == min(diffF));
    posMin = find(z == min(z));
    posMin = min(posMin);
    
    
    
    t_first_part = t(1:posS);
    z_first_part = z(1:posS);
    AverageF1 = mean(z_first_part);

    Sigma = std(z);
    line1 = AverageF1*ones(N,1) + Sigma;
    line2 = AverageF1*ones(N,1) - Sigma;

    % points between posS and posMin
    pos_posSposMin = find( (t>=t(posS)) & (t <= t(posMin)));
    pos_first_point = 0;
    for a = 1:length(pos_posSposMin)
        if z(pos_posSposMin(a)) <= (AverageF1-Sigma)
            pos_first_point = pos_posSposMin(a);
            break
        end
    end

    % calculation of the response onset
    a = posS;
    c = pos_first_point;
    b = round((pos_first_point - posS)/2) + posS;
    z_first = z(a:b);
    z_second = z((b+1):c);
    cond=1; % exit condition
    iter = 0;
    while(cond)
        rest = rem(iter,2);
        if rest == 0
            c = b;
            b = round((c-a)/2)+a;
            z_first = z(a:b);
            z_second = z((b+1):c);
            if((c-a)<=1)
                cond = 0;
            end
        elseif rest == 1
            a = b+1;
            b = round((c-a)/2) + a;
            z_first = z(a:b);
            z_second = z((b+1):c);
            if((c-a)<=1)
                cond = 0;
            end
        end
        iter = iter+1;
    end

    z_ResponseOnset = z(a);
    t_ResponseOnset = t(a);

    figure
    hold on
    plot(t,z)
    plot(t,AverageF1*ones(N,1),'g')
    % plot(t,z_ResponseOnset*ones(N,1),'y-')
    % plot(t_rect, y_rect,'c')
    plot(t,line1,'r')
    plot(t,line2,'r')
    % plot(t(pos_nearest),z(pos_nearest),'r*')
    % plot(t(pos_nearest),z(pos_nearest),'ko')
    plot(t_ResponseOnset,z_ResponseOnset,'y*')
    plot(t_ResponseOnset,z_ResponseOnset,'ko')
    plot(t(posS),z(posS),'ro')
    plot(t(posMin),z(posMin),'c*')
    plot(t(posMin),z(posMin),'ko')
    % plot(t(posMax),z(posMax),'r*')
    % plot(t(posMax),z(posMax),'ko')
    % plot(t(pos_nearest2point),z(pos_nearest2point),'m*')
    % plot(t(pos_nearest2point),z(pos_nearest2point),'ko')
    % plot(t(pos_nearest3point),z(pos_nearest3point),'k*')
    % plot(t(pos_nearest3point),z(pos_nearest3point),'ko')
    legend('Average signal','mean of the 1° part [0,posS]')
    xlabel('time [sec]')
    ylabel('voltage [mV]')
    axis square
    hold off
    
%     display(['response onset time = ', num2str(t_ResponseOnset), ' sec'])
%     display(['time delay = ', num2str(t_ResponseOnset-t(posS)), ' sec'])

    