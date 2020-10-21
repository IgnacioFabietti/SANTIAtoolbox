    selectedMatchingMethod=getappdata(fh,'selectedMatchingMethod');

    selectedClusteringMethod=getappdata(fh,'selectedClusteringMethod');
    
    if ~isequal(get(findobj('Tag','rblfpsSOM'),'Value'),1)    
        selectedDistanceCriteria=getappdata(fh,'selectedDistanceCriteria');        
    else
        selectedDistanceCriteria=0;
    end
    
    selectedDistanceMethod=getappdata(fh,'selectedDistanceMethod');

    if isappdata(fh,'clusterNo')
        clusNo=getappdata(fh, 'clusterNo');
    else
        set(findobj('Tag','ddlClusterNo'),'Value',10);
        clusNo=10;
    end

    foldersToSelect={
       'E:\In-Vivo Recordings\Pipette Recordings Whisker Stim\20091021_P31_80g_female-analyzed\D1_Z180um_10V1ms150msdly[1-100]\'
       'E:\In-Vivo Recordings\Pipette Recordings Whisker Stim\20091021_P31_80g_female-analyzed\D1_Z270um_10V1ms150msdly[1-100]\'
       'E:\In-Vivo Recordings\Pipette Recordings Whisker Stim\20091021_P31_80g_female-analyzed\D1_Z360um_10V1ms150msdly[1-100]\'
       'E:\In-Vivo Recordings\Pipette Recordings Whisker Stim\20091021_P31_80g_female-analyzed\D1_Z450um_10V1ms150msdly[1-100]\'
       'E:\In-Vivo Recordings\Pipette Recordings Whisker Stim\20091021_P31_80g_female-analyzed\D1_Z540um_10V1ms150msdly[1-100]\'
       'E:\In-Vivo Recordings\Pipette Recordings Whisker Stim\20091021_P31_80g_female-analyzed\D1_Z630um_10V1ms150msdly[1-100]\'
       'E:\In-Vivo Recordings\Pipette Recordings Whisker Stim\20091021_P31_80g_female-analyzed\D1_Z720um_10V1ms150msdly[1-100]\'
       'E:\In-Vivo Recordings\Pipette Recordings Whisker Stim\20091021_P31_80g_female-analyzed\D1_Z810um_10V1ms150msdly[1-100]\'
       'E:\In-Vivo Recordings\Pipette Recordings Whisker Stim\20091021_P31_80g_female-analyzed\D1_Z900um_10V1ms150msdly[1-100]\'
       'E:\In-Vivo Recordings\Pipette Recordings Whisker Stim\20091021_P31_80g_female-analyzed\D1_Z990um_10V1ms150msdly[1-100]\'
       'E:\In-Vivo Recordings\Pipette Recordings Whisker Stim\20091021_P31_80g_female-analyzed\D1_Z1080um_10V1ms150msdly[1-100]\'
       'E:\In-Vivo Recordings\Pipette Recordings Whisker Stim\20091021_P31_80g_female-analyzed\D1_Z1170um_10V1ms150msdly[1-100]\'
       'E:\In-Vivo Recordings\Pipette Recordings Whisker Stim\20091021_P31_80g_female-analyzed\D1_Z1260um_10V1ms150msdly[1-100]\'
       'E:\In-Vivo Recordings\Pipette Recordings Whisker Stim\20091021_P31_80g_female-analyzed\D1_Z1350um_10V1ms150msdly[1-100]\'
       'E:\In-Vivo Recordings\Pipette Recordings Whisker Stim\20091021_P31_80g_female-analyzed\D1_Z1440um_10V1ms150msdly[1-100]\'
       'E:\In-Vivo Recordings\Pipette Recordings Whisker Stim\20091021_P31_80g_female-analyzed\D1_Z1530um_10V1ms150msdly[1-100]\'
       'E:\In-Vivo Recordings\Pipette Recordings Whisker Stim\20091021_P31_80g_female-analyzed\D1_Z1620um_10V1ms150msdly[1-100]\'
       'E:\In-Vivo Recordings\Pipette Recordings Whisker Stim\20091021_P31_80g_female-analyzed\D1_Z1710um_10V1ms150msdly[1-100]\'
       'E:\In-Vivo Recordings\Pipette Recordings Whisker Stim\20091021_P31_80g_female-analyzed\D1_Z1800um_10V1ms150msdly[1-100]\'
       }; 
    
    for folderIndex=1:length(foldersToSelect)
        
        directoryPath=foldersToSelect{folderIndex};
        fileNames=getDirContents(directoryPath, '*.txt');
        preData=load([filePath fileNames{1}]);
        signalMatrix = zeros(length(fileNames), length(preData));

        waitbarMsg ={'Please Wait...', 'Loading Data Files...',' '};
        h=waitbar(0,waitbarMsg,'Name','Loading Data Files');        

        for i=1:length(fileNames)   
            signalMatrix(i, :) = createMatrix(filePath, fileNames{i});

            updatedWaitBarMsg={'Please Wait... Loading Data Files...', 'Now Loading File: ', fileNames{i}};
            waitbar(i/length(fileNames),h,updatedWaitBarMsg);            
        end

        close(h);

        fileLength=length(preData);

        clear preData;

        [res1, res2, res3, res4] = sortSweepsVSubplot(signalMatrix, selectedMatchingMethod, selectedClusteringMethod, clusNo, selectedDistanceCriteria, selectedDistanceMethod, fileLength);

        % save the average of each cluster in seperate files in the folder
        % 'ClusteredAverages'

        temp=fileNames{1};
        [token, remain]=strtok(temp, 'part');
        fileNameFormat=[token 'cluster%02d.txt'];

        currPath=cd(getappdata(fh, 'directoryPath'));

        [status,message,messageid] = mkdir('ClusteredAverages');

        cd('ClusteredAverages');

        for i=1:clusNo
            toSave=[];
            saveFileName=sprintf(fileNameFormat,i);
            if isnan(res4(:,i+1)) || (any(res4(:,i+1))==0)
                continue;
            else
                toSave=[res4(:,1), res4(:,i+1)];
                save(saveFileName,'toSave','-ascii','-tabs');
            end
        end

        cd(currPath)
    end