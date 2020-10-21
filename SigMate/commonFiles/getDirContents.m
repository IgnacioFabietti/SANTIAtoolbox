function  fileNames = getDirContents(directoryPath, fileType)
  
    % get directory structure
    dirStruct = dir([directoryPath fileType]);
    
    % sort the folder content based on time stamp
    [timeStamp,timeIndex]=sortrows({dirStruct.date}');
    
    % sort the files based on the time stamp
    fileNames={};
    for indx = 1:length(timeStamp)
%         fileNames{indx}=[directoryPath dirStruct(timeIndex(indx)).name];
        fileNames{indx}=dirStruct(timeIndex(indx)).name;
    end
    fileNames=fileNames';
