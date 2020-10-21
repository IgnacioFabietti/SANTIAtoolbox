function [fileNames] = getFileNames(filePath)

    currDir=pwd;
    cd(filePath);
    list=dir('*.txt');
    [timeStamp,timeIndex]=sortrows({list.date}');

    fileNames={};
    for indx = 1:length(timeStamp)
        fileNames{indx}=list(timeIndex(indx)).name;
    end        
    fileNames=fileNames';
    cd(currDir)