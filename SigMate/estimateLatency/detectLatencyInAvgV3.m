function[t_SS,v_SS,t_RS,v_RS,t_P1,v_P1,l_P1,t_P2,v_P2,l_P2,t_P3,v_P3,l_P3,t_P4,v_P4,l_P4,s,t,flag] =  detectLatencyInAvgV3(filePath, fileName, cutoffFreq, signalType)

    finalPath=[filePath,fileName];
    data = load (finalPath);
    
    t = data(:,1);
    
    if (signalType==2) % if the traces are of micropipette recording
        z = data(:,2);
    elseif (signalType==3) % if the traces are of transistor recording
        z = data(:,2)*1000; % convert the recording to mV from V
        z = downsample(z,5);
        t = downsample(t,5);
    end
    
    N = length(t);
    ST = 0.150000;              % starting time
    stimDur = 0.05;
    FT = ST + stimDur;          % finishing time
    T = t(2)-t(1);              % sampling step
    
    Fs=1/T;    
    
    % low pass filter the signal with the specified cutoff frequency
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
    
    % high pass filter the signal's steady state part (before stimulation start)
    % with 100 Hz as the cutoff frequency
    fNorm = 100/(Fs/2);
    [b,a] = butter(5,fNorm,'high');
    sSteady = filtfilt(b,a,s(1:posS));

    % calculate the standard deviation of the filtered steady state
    stdSteady = std(sSteady);

    % cut the portion of the signal from the end of the stimulation to next
    % 5 ms for the detection of the starting of response onset
    if (signalType==2) % if the traces are of micropipette recording
        sResponse = s(posS+round(Fs*0.005):posF+round(Fs*0.05));
        tResponse = t(posS+round(Fs*0.005):posF+round(Fs*0.05));
    elseif (signalType==3) % if the traces are of transistor recording consider 1 ms
        sResponse = s(posS+round(Fs*0.001):posF+round(Fs*0.05));
        tResponse = t(posS+round(Fs*0.001):posF+round(Fs*0.05));
    end


    % divide this part of the signal into smaller parts of 0.5 ms
    noOfDiv = floor((tResponse(length(tResponse)) - tResponse(1)) / 0.0005);
    dataPoints = floor(Fs*0.0005);
    sToCheck = [];
    tToCheck = [];
%     figure;
%     hold on;

    for i = 1:noOfDiv
        sToCheck = sResponse(dataPoints*(i-1)+1:dataPoints*i);
        tToCheck = tResponse(dataPoints*(i-1)+1:dataPoints*i);
        p = polyfit(tToCheck,sToCheck,1);
        tempLine = polyval(p,tToCheck);
        if (abs(tempLine(length(tempLine)))>stdSteady*2)
            respOnsetV = sToCheck(1);
            respOnsetT = tToCheck(1);
            break;         
        end
    end  
    
    % set the response onset as zero in the y-axis
    
    if respOnsetV < 0
        z_scaled = z_scaled + abs(respOnsetV);
    elseif respOnsetV >= 0 
        z_scaled = z_scaled - abs(respOnsetV);
    end
    
    respOnsetV=0;
        
    s = z_scaled;
  
%     plot(t,s,'b');
%     plot(t(posS),s(posS),'go')
%     plot(respOnsetT,respOnsetV,'ro');    
    
    newEnd = t(length(t))-t(length(t))*0.1; % consider the new signal ending point as 90% of the signal
    
    z_scaled=s(posS:round(Fs*newEnd));
    
    N=length(z_scaled);
    
    % check if the start point of the response is positve or negative
    
    posRespOnset = find(t == respOnsetT);
    
    flag1 = 1; % this flag will determine the detection of first peak
    
    posP1 = NaN;
    interPos = NaN;   
    falsePeak = 0;
    % check if signal is going up or down by considering 0.5 ms after the
    % response onset
    if (s(posRespOnset+2*dataPoints) > stdSteady*2) || (max(s(posRespOnset:round(posRespOnset+Fs*0.015)))>0)
        % if the signal is going up, then find the first peak as a positive
        % peak taking the maximum value of the amplitude from response
        % onset to the next 15 ms
        peakMax = max(s(posRespOnset:round(posRespOnset+Fs*0.015)));
        if peakMax > 0.005
            posP1 = find(z_scaled == peakMax);
            posP1 = posS + posP1;
        else
            falsePeak = 1;
            posP1 = NaN;           
        end
    end
    if ((s(posRespOnset+dataPoints) < stdSteady) || falsePeak) && isnan(posP1)
        % if the signal is going down, consider 0.25 ms from the response
        % onset and keep increasing that time by 0.05 ms until there is a
        % change in the derivation. When a change is found, remember the
        % last maximum negative point and continue the search for a
        % positive maximum. This will be considered as a temp maximum and
        % keep the search on for yet a negative maximum.
        indx = 1;
        cond = 1;
        dataPoints = ceil(Fs*0.0001);
        startPoint = round(posRespOnset+Fs*0.0005);
        sigChunk = s(posRespOnset:startPoint);
        sigChunkT = t(posRespOnset:startPoint);
        tempPeak = 0;

        compPoint = abs(sigChunk(length(sigChunk)));
        while (cond)
            sigChunk = s(startPoint:startPoint+dataPoints*indx);
            sigChunkT = t(startPoint:startPoint+dataPoints*indx);
            indx = indx + 1;
            if (abs(sigChunk(length(sigChunk))) > compPoint) || (abs(s(startPoint+dataPoints*indx))<=0.01)
                compPoint = abs(sigChunk(length(sigChunk)));
                continue;
            else
                tempPeak = startPoint+dataPoints*(indx-1);
                % if there is still one negative peak with higher amplitude
                % in the subsequent 5 ms, then we have found the first peak
                if abs(min(s(tempPeak:round(tempPeak+Fs*0.05))))>abs(s(tempPeak))
                    break;
                else
                    dataPoints = ceil(Fs*0.0003);
                    newChunk = s(tempPeak:tempPeak+dataPoints);
                    newChunkT = t(tempPeak:tempPeak+dataPoints);
                    
                    cond2 = 1;
                    indx2 = 1;                    
                    compPoint = abs(newChunk(length(newChunk)));
                    while (cond2 && (length(newChunk))<=length(s(tempPeak:round(tempPeak+Fs*0.025))))
                        newChunk = s(tempPeak:tempPeak+dataPoints*indx2);
                        newChunkT = t(tempPeak:tempPeak+dataPoints*indx2);
                        indx2 = indx2 + 1;            
                        if compPoint >= abs(newChunk(length(newChunk)))
                            compPoint = abs(newChunk(length(newChunk)));
                            continue;
                        else
                            interPos = tempPeak + dataPoints*(indx2-1);
                            cond2 = 0;
                            break;
                        end
                    end
                    
                    if cond2 || s(interPos)>0
                        interPos = NaN;
                    end
                    if isnan(interPos)
                        flag1=0;
                    end
                    break;
                end

            end
        end
        posP1 = tempPeak;
    end
    
%     plot(sigChunkT,sigChunk,'y');
    
    if ~flag1
        posP1 = NaN;
        posT1 = NaN;
    end

    if ~isnan(interPos)
        z_scaled=[];
        z_scaled=s(interPos:round(Fs*newEnd));
        posMin = find(z_scaled == min(z_scaled));
        posMin = interPos + min(posMin);        
    else
        posMin = find(z_scaled == min(z_scaled));
        posMin = posS + min(posMin);        
    end
    % find position of the first negative peak
    
%     posMin = find(z_scaled == min(z_scaled));
%     posMin = posS + min(posMin);
    
    flag=1;

    % the first negative peak is expected to be within 100 ms of the
    % application of the stimulus, if it is not found within that period,
    % then the signal is not considered to be fitting the considered LFPs
    
    if(t(posMin)<t(posS)+0.1)
            
        % find the position of first positive peak after the negative peak  
        % for doing so, consider the first 100 ms after the negative peak

        z_scaled_cut = s(posMin:round(posMin+Fs*0.1));
        posMax = find(z_scaled_cut == max(z_scaled_cut));
        posMax = min(posMax) + posMin;

        z_scaled_cut = s(posMax:round(Fs*newEnd));
        posMin2 = find(z_scaled_cut == min(z_scaled_cut)); 
        posMin2 = min(posMin2) + posMax;

        t_SS = t(posS);
        v_SS = s(posS);
        t_RS = respOnsetT;
        v_RS = respOnsetV;
        if ~isnan(posP1)
            t_P1 = t(posP1); 
            v_P1 = s(posP1);
        else
            t_P1 = NaN;
            v_P1 = NaN;
        end
        l_P1 = t_P1 - t_RS;
        t_P2 = t(posMin);
        v_P2 = s(posMin);
        l_P2 = t_P2 - t_RS;
        t_P3 = t(posMax);
        v_P3 = s(posMax);
        l_P3 = t_P3 - t_RS;

        t_cut = t(posMin2:length(t));
        z_scaled_new=s(posMin2:length(s));
        p = polyfit(t_cut,z_scaled_new,1);
        tempLine = polyval(p,t_cut);

        if(tempLine(1) < 0 && tempLine(length(tempLine)) > 0) || (abs(tempLine(1))<abs(tempLine(length(tempLine))))...
                ||(abs(tempLine(length(tempLine)))-abs(tempLine(1))<=0.1*abs(v_P2)) %0.1 means 100 uV
            % the first case is for a line which is running from negative to
            % positive and for the second case, its a line running from
            % negative to near zero
            t_P4 = t(posMin2);
            v_P4 = s(posMin2);
            l_P4 = t_P4 - t_RS;  
        else
            posMin2=NaN;
            t_P4=NaN;
            v_P4=NaN;
            l_P4=NaN;        
        end

%             figure
%             hold on
%             grid on
%             plot(t,s)
%             plot(t(posS),s(posS),'co')
%             plot(respOnsetT,respOnsetV,'ro')
%             if flag1
%                 plot(t(posP1),s(posP1),'ko')
%             end
%             plot(t(posMin),s(posMin),'go')
%             plot(t(posMax),s(posMax),'ko')
%     
%             if flag
%                 plot(t(posMin2),s(posMin2),'mo')
%             end
%     
%             xlabel('time [sec]')
%             ylabel('voltage [mV]')
%             hold off

    else
        flag=0;
        t_SS = t(posS);
        v_SS = s(posS);
        t_RS = respOnsetT;
        v_RS = respOnsetV;        
        t_P1 = NaN;
        v_P1 = NaN;
        l_P1 = NaN;
        t_P2 = NaN;
        v_P2 = NaN;
        l_P2 = NaN;
        t_P3 = NaN;
        v_P3 = NaN;
        l_P3 = NaN;
        t_P4 = NaN;
        v_P4 = NaN;
        l_P4 = NaN;
    end

    