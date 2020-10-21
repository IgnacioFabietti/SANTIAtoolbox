filePath='E:\In-Vivo Recordings\CHIP FLO\20091110\C1 1st FET\';
fileNames={   
%     'Rearranged-154656 Whisker Stim 10V 10ms C1 z=-845um Avg.txt'
%     'Rearranged-155129 Whisker Stim 10V 10ms C1 z=-1115um Avg.txt'
%     'Rearranged-155544 Whisker Stim 10V 10ms C1 z=-1385um Avg.txt'
%     'Rearranged-155947 Whisker Stim 10V 10ms C1 z=-1655um Avg.txt'
    'Rearranged-163713 Whisker Stim 10V 10ms C1 z=-125um Avg.txt'
    'Rearranged-163328 Whisker Stim 10V 10ms C1 z=-305um Avg.txt'
    'Rearranged-162859 Whisker Stim 10V 10ms C1 z=-485um Avg.txt'
    'Rearranged-162453 Whisker Stim 10V 10ms C1 z=-665um Avg.txt'   
    'Rearranged-162047 Whisker Stim 10V 10ms C1 z=-845um Avg.txt'
    'Rearranged-161633 Whisker Stim 10V 10ms C1 z=-1115um Avg.txt'
    'Rearranged-161227 Whisker Stim 10V 10ms C1 z=-1385um Avg.txt'
    'Rearranged-160844 Whisker Stim 10V 10ms C1 z=-1655um Avg.txt'
    'Rearranged-160349 Whisker Stim 10V 10ms C1 z=-1925um Avg.txt'
};

filtData=[];

fileName = [filePath,fileNames{1}];
data=load(fileName);

t = downsample(t,5);

T = t(2)-t(1);  
Fs=1/T;

filtData=[filtData,t];

for i=1:length(fileNames)
    fileName = [filePath,fileNames{i}];
    
    data=load(fileName);
    
    t= data(:,1); 
    z = data(:,2)*1000; 

    z = downsample(z,5); 
    
    fNorm = 500 / (Fs/2); 
    [b,a] = butter(5,fNorm,'low'); 
    z = filtfilt(b,a,z);
    filtData=[filtData,z];
end

currPath=pwd;
cd(filePath);
save('filteredData.txt','filtData','-ascii','-tabs');
cd(currPath);