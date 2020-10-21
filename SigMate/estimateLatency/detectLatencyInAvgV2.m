function[t_SS,v_SS,t_P1,v_P1,l_P1,t_P2,v_P2,l_P2,t_P3,v_P3,l_P3,s,t,flag] =  detectLatencyInAvgV2(filePath, fileName, cutoffFreq, signalType)

    finalPath=[filePath,fileName];
    data = load (finalPath);
    
    t = data(:,1);
    
    if (signalType==2) % if the traces are of micropipette recording
        z = data(:,2);
    elseif (signalType==3) % if the traces are of transistor recording
        z = data(:,2)*1000; % convert the recording to mV from V
    end
    
    N = length(t);
    ST = 0.150000;              % starting time
    stimDur = 0.05;
    FT = ST + stimDur;          % finishing time
    T = t(2)-t(1);              % sampling step
    
    Fs=1/T;    
    
    fNorm = cutoffFreq / (Fs/2);
    [b,a] = butter(5,fNorm,'low');
    z = filtfilt(b,a,z);
   
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
    
    newEnd = t(length(t))-t(length(t))*0.1; % consider the new signal ending point as 90% of the signal
    
    z_scaled=s(posS:round(Fs*newEnd));
    
    N=length(z_scaled);
    
    % find position of the first negative peak
    
    posMin = find(z_scaled == min(z_scaled));
    posMin = posS + min(posMin);
    
    flag=1;

    % the first negative peak is expected to be within 100 ms of the
    % application of the stimulus, if it is not found within that period,
    % then the signal is not considered to be fitting the considered LFPs
    
    if(t(posMin)<t(posS)+0.1)
    
        % find the position of first positive peak after the negative peak  
        % for doing so, consider the first 100 ms after the negative peak

        z_scaled_cut = s(posMin:round(posMin+Fs*0.1));
        posMax = find(z_scaled_cut == max(z_scaled_cut));
        posMax = min(posMax) + posMin - 1;

        z_scaled_cut = s(posMax:round(Fs*newEnd));
        posMin2 = find(z_scaled_cut == min(z_scaled_cut)); 
        posMin2 = min(posMin2) + posMax -1 ;

        t_SS = t(posS);
        v_SS = s(posS);
        t_P1 = t(posMin);
        v_P1 = s(posMin);
        l_P1 = t_P1 - t_SS;
        t_P2 = t(posMax);
        v_P2 = s(posMax);
        l_P2 = t_P2 - t_SS;

        t_cut = t(posMin2:length(t));
        z_scaled_new=s(posMin2:length(s));
        p = polyfit(t_cut,z_scaled_new,1);
        tempLine = polyval(p,t_cut);

        if(tempLine(1) < 0 && tempLine(length(tempLine)) > 0) || (abs(tempLine(1))>abs(tempLine(length(tempLine))))...
                ||(abs(tempLine(length(tempLine))-tempLine(1))<=0.1*abs(v_P2)) %0.1 means 100 uV
            % the first case is for a line which is running from negative to
            % positive and for the second case, its a line running from
            % negative to near zero
            t_P3 = t(posMin2);
            v_P3 = s(posMin2);
            l_P3 = t_P3 - t_SS;  
        else
            posMin2=NaN;
            t_P3=NaN;
            v_P3=NaN;
            l_P3=NaN;        
        end

    %         figure
    %         hold on
    %         grid on
    %         plot(t,s)
    %         plot(t(posS),s(posS),'ko')
    %         plot(t(posMin),s(posMin),'ko')
    %         plot(t(posMax),s(posMax),'ko')
    %         plot(t_cut,tempLine,'g')
    % 
    %         if flag
    %             plot(t(posMin2),s(posMin2),'ko')
    %         end
    % 
    %         xlabel('time [sec]')
    %         ylabel('voltage [mV]')
    %         hold off

    else
        flag=0;
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

    