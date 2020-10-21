function calculateResponse(filePath, fileName)
    %This function calculates the latency of the response, with the peak
    %value and the duration of the response
    
    fileContent = load([filePath,fileName]);
    
    s = fileContent(:,2);
    t = fileContent(:,1);
    
    T = t(2)-t(1); %time interval of samples
    Fs = 1/T; %sampling rate
    
    preStimDur = 0.03; %the prestimulus period
    preStimElem = preStimDur * Fs; %no. of elements of the prestimulus signal
    
    preStimS = s(1:preStimElem);
    
    matchPoint=0;
    for i=1:round(length(mainData(:,2))/50)-2
        stdPart1=std(mainData(((i-1)*50)+1:i*50,2))
        stdPart2=std(mainData((i*50)+1:(i+1)*50,2))
        if(stdPart2>stdPart1)
            break; 
        else
            matchPoint=matchPoint+1; 
        end
    end
        matchPoint    
    
    