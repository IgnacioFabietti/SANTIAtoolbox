function [filteredPotentialsForCSD, t]= filterSignalsForCSD(filePath, fileNames, checkedColumns, stimOnset)

    %this is a file that apply the monodimentional CSD analysis to in vivo data

    tempData = load([filePath,fileNames{1}]);
    
    signalMatrix=zeros(length(fileNames), length(tempData));
    
    clear tempData;

    for i=1:length(fileNames)
        [t_tmp, z_tmp]= readData(filePath, fileNames{i}, checkedColumns);
        signalMatrix(i, :) = z_tmp;
    end

    t=t_tmp;
    
    [c,r]=size(signalMatrix);
    
    Fs=1/(t(2)-t(1));
    
    preStimDataPoints = ceil(Fs*(stimOnset/1000));

    filteredPotentials=zeros(r,c);
    
    for i=1:c
        tempS =[];
        M=signalMatrix';

%         Wc=[0.1*2/Fs,500*2/Fs];

        fNorm = 250 / (Fs/2);

%         [B,A] = butter(3,Wc);
        [B,A] = butter(5, fNorm, 'low');
        tempFiltPot(:,i)=filtfilt(B,A,M(:,i));
        filteredPotentials(:,i)=tempFiltPot(:,i)-tempFiltPot(preStimDataPoints,i);%mean(pot_filt2(1:preStimDataPoints,i));

    end 

    filteredPotentialsForCSD = filteredPotentials;