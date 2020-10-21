function[t_SS,v_SS,t_P1,v_P1,l_P1,t_P2,v_P2,l_P2,t_P3,v_P3,l_P3,s,t] =  detectLatencyInAvg(filePath, fileName, cutoffFreq)

    finalPath=[filePath,fileName];
    data1 = load (finalPath);
    
    t = data1(:,1);
    z = data1(:,2);
    N = length(t);
    ST = 0.150000;              % starting time
    durata_stimolo = 0.05;
    FT = ST + durata_stimolo;   % finishing time
    T = t(2)-t(1);              % sampling step
    
    Fs=1/T;    
    
    fNorm = cutoffFreq / (Fs/2);
    [b,a] = butter(5,fNorm,'low');
    z = filtfilt(b,a,z);

    diffS = zeros(N,1);
    diffF = zeros(N,1);
    
    for a = 1:N
        diffS(a) = abs(t(a)-ST);
        diffF(a) = abs(t(a)-FT);
    end
    
    posS = find(diffS == min(diffS));
    posF = find(diffF == min(diffF));
    
    z_scaled = zeros(N,1);
    if z(posS) < 0
        z_scaled = z + abs(z(posS));
    elseif z(posS)>= 0 
        z_scaled = z - abs(z(posS));
    end
    
    s = z_scaled;
    
    z_scaled=z_scaled(1:round(Fs*0.450));
    
    N=length(z_scaled);
    
    posMin = find(z_scaled == min(z_scaled));
    posMin = min(posMin);
    
    tempPosMax = find(z_scaled == max(z_scaled));
    tempPosMax = min(tempPosMax);
    
    if (t(tempPosMax)>t(posMin)) || (abs(z_scaled(tempPosMax))<abs(z_scaled(posMin)))
    
        z_scaled_cut = z_scaled(posMin:N);
        posMax = find(z_scaled_cut == max(z_scaled_cut));
        posMax = min(posMax) + posMin - 1;

        z_scaled_cut = z_scaled(posMax:N);
        posMin2 = find(z_scaled_cut == min(z_scaled_cut)); 
        posMin2 = min(posMin2) + posMax - 1;

        t_SS = t(posS);
        v_SS = z_scaled(posS);
        t_P1 = t(posMin);
        v_P1 = z_scaled(posMin);
        l_P1 = t_P1 - t_SS;
        t_P2 = t(posMax);
        v_P2 = z_scaled(posMax);
        l_P2 = t_P2 - t_SS;

        t_cut = t(posMin2:length(t));
        z_scaled_new=s(posMin2:length(s));
        p = polyfit(t_cut,z_scaled_new,1);
        tempLine = polyval(p,t_cut);

        flag=1;
%         if (abs(z_scaled_new(length(z_scaled_new)))<abs(z_scaled_new(1))) %&& (z_scaled_new(1)-z_scaled_new(length(z_scaled_new)))
        if (abs(tempLine(1))<abs(tempLine(length(tempLine)))) && (abs(tempLine(length(tempLine))-tempLine(1))>=0.25*abs(v_P2)) %0.1 means 100 uV
            flag=0;
            posMin2=NaN;
            t_P3=NaN;
            v_P3=NaN;
            l_P3=NaN;
        else
            t_P3 = t(posMin2);
            v_P3 = z_scaled(posMin2);
            l_P3 = t_P3 - t_SS;        
        end

%         figure
%         hold on
%         plot(t,s)
%         plot(t, zeros(length(s),1),'k-.')
%         plot(t(posS),s(posS),'y*')
%         plot(t(posS),s(posS),'ko')
%         plot(t(posMin),s(posMin),'c*')
%         plot(t(posMin),s(posMin),'ko')
%         plot(t(posMax),s(posMax),'g*')
%         plot(t(posMax),s(posMax),'ko')
%         plot(t_cut,tempLine,'g')
% 
%         if flag
%             plot(t(posMin2),s(posMin2),'r*')
%             plot(t(posMin2),s(posMin2),'ko')
%         end
% 
%         xlabel('time [sec]')
%         ylabel('voltage [mV]')
%         hold off
    else
        errordlg(['File ', fileName, ' doesnot match the detection criterion'], 'File Selection Error')
        t_SS = t(posS);
        v_SS = s(posS);
        t_P1 = NaN;
        v_P1 = NaN;
        l_P1 = NaN;
        t_P2 = NaN;
        v_P2 = NaN;
        l_P2 = NaN;
        t_P3 = NaN;
        v_P3 = NaN;
        l_P3 = NaN;
    end

    