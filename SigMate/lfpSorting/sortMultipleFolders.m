function result = sortMultipleFolders(selectedMatchingMethod, selectedClusteringMethod, selectedDistanceCriteria, selectedDistanceMethod, clusNo)

    try
  
%         path='I:\In-Vivo Recordings\Pipette Recordings Whisker Stim\20091021_P31_80g_female-analyzed\';
        path='I:\In-Vivo Recordings\Pipette Recordings Whisker Stim\20091022_P32_85g_male-analyzed\';
        oldPath=cd(path);
        
        fileFormat='\n%35s\t%03d';
        headerFormat='%35s\t%35s';
        
        headerContent=sprintf(headerFormat,'File Name','Recognized Sweeps');
        
        clustDetailsFormat='\n%35s\t%03d\t%03d\t%03d\t%03d\t%03d\t%03d\t%03d\t%03d\t%03d\t%03d\t%03d';
        clustHeadFormat='\n%35s\t%35s\t%10s\t%10s\t%10s\t%10s\t%10s\t%10s\t%10s\t%10s\t%10s\t%10s';
        
        clustHeadContent=sprintf(clustHeadFormat,'File Name','Recognized Sweeps','Cluster#1','Cluster#2','Cluster#3','Cluster#4','Cluster#5','Cluster#6','Cluster#7','Cluster#8','Cluster#9','Cluster#10');
                
        tmpStr=strrep(datestr(clock),':','');
        tmpStr=strrep(tmpStr,'-','');
        tmpStr=strrep(tmpStr,' ','-');
        saveFileName=[tmpStr,'-','WFRecognition','.xls'];
        
        saveClustFileName=[tmpStr,'-','ClusteringDetails.xls'];
        
        fid=fopen(saveFileName,'w');
        
        fidClust=fopen(saveClustFileName,'w');

        if(fid==-1 || fidClust==-1)
            msgbox(['Sorry, the file ', saveFileName,' or ',saveClustFileName, ' cannot be opened!'],'File Opening Error','Error');
        else

            fprintf(fid,headerContent);
            
            fprintf(fidClust, clustHeadContent);
            
            folderNames={
%                 'D1_Z90um_10V1ms150msdly[1-100]'
%                 'D1_Z180um_10V1ms150msdly[1-100]'
%                 'D1_Z270um_10V1ms150msdly[1-100]'
%                 'D1_Z360um_10V1ms150msdly[1-100]'
%                 'D1_Z450um_10V1ms150msdly[1-100]'
%                 'D1_Z540um_10V1ms150msdly[1-100]'
%                 'D1_Z630um_10V1ms150msdly[1-100]'
%                 'D1_Z720um_10V1ms150msdly[1-100]'
                'D1_720um_10V1ms150msdly[1-100]'
%                 'D1_Z900um_10V1ms150msdly[1-100]'
%                 'D1_Z990um_10V1ms150msdly[1-100]'
%                 'D1_Z1080um_10V1ms150msdly[1-100]'
%                 'D1_Z1170um_10V1ms150msdly[1-100]'
%                 'D1_Z1260um_10V1ms150msdly[1-100]'
%                 'D1_Z1350um_10V1ms150msdly[1-100]'
%                 'D1_Z1440um_10V1ms150msdly[1-100]'
%                 'D1_Z1530um_10V1ms150msdly[1-100]'
%                 'D1_Z1620um_10V1ms150msdly[1-100]'
%                 'D1_Z1710um_10V1ms150msdly[1-100]'
%                 'D1_Z1800um_10V1ms150msdly[1-100]'
                };    

            for folderIndex=1:length(folderNames)
                
                if folderIndex>1
                    clusNo = randi([6 10], 1, 1); 
                else
                    clusNo = 7;
                end
                
                fileLineContent=[];

                directoryPath=[path folderNames{folderIndex} '\'];

                fileNames = getDirContents(directoryPath, '*.txt');

                preData=load([directoryPath fileNames{1}]);

                fileLength=length(preData);

                signalMatrix = zeros(length(fileNames), length(preData));

                clear preData;

                waitbarMsg ={'Please Wait...', 'Loading Data Files...',' '};
                h=waitbar(0,waitbarMsg,'Name','Loading Data Files');        

                for i=1:length(fileNames)   
                    signalMatrix(i, :) = createMatrix(directoryPath, fileNames{i});

                    updatedWaitBarMsg={'Please Wait... Loading Data Files...', 'Now Loading File: ', fileNames{i}};
                    waitbar(i/length(fileNames),h,updatedWaitBarMsg);            
                end

                close(h);
                   
                [~, res2, res3, res4] = sortSweepsVSubplot(signalMatrix, selectedMatchingMethod, selectedClusteringMethod, clusNo, selectedDistanceCriteria, selectedDistanceMethod, fileLength);

                % save the average of each cluster in seperate files in the folder
                % 'ClusteredAverages'
                
                clustFileName='Clustering_details.txt';
                
                temp=fileNames{1};
                [token, remain]=strtok(temp, 'part');
                fileNameFormat=[token 'cluster%02d.txt'];

                currPath=cd(directoryPath);

                [status,message,messageid] = mkdir('ClusteredAverages');

                cd('ClusteredAverages');

                [~, nc]=size(res4);

                for i=1:nc-1
                    toSave=[];
                    saveFileName=sprintf(fileNameFormat,i);
                    if (any(isnan(res4(:,i+1)))) || ~(any(res4(:,i+1)))
                        continue;
                    else
                        toSave=[res4(:,1), res4(:,i+1)];
                        save(saveFileName,'toSave','-ascii','-tabs');
                    end
                end
                
                save(clustFileName, 'res2','-ascii','-tabs');
                
                cd(currPath)
                
                fileLineContent=sprintf(fileFormat, folderNames{folderIndex},res3);
                fprintf(fid,fileLineContent);
                
                [row, col]=size(res2);
                dummy=zeros(1, clusNo);
%                 dummy(1)=res3;
                for xx=1:row
                    if res2(xx,2)==1
                        dummy(1)=dummy(1)+1;
                    elseif res2(xx,2)==2
                        dummy(2)=dummy(2)+1;
                    elseif res2(xx,2)==3
                        dummy(3)=dummy(3)+1;
                    elseif res2(xx,2)==4
                        dummy(4)=dummy(4)+1;
                    elseif res2(xx,2)==5
                        dummy(5)=dummy(5)+1;
                    elseif res2(xx,2)==6
                        dummy(6)=dummy(6)+1;
                    elseif res2(xx,2)==7
                        dummy(7)=dummy(7)+1;
                    elseif res2(xx,2)==8
                        dummy(8)=dummy(8)+1;
                    elseif res2(xx,2)==9
                        dummy(9)=dummy(9)+1;
                    elseif res2(xx,2)==10
                        dummy(10)=dummy(10)+1;
                    end
                end
                
                clustFileLineContent=sprintf(clustDetailsFormat,folderNames{folderIndex}, res3,dummy);
                fprintf(fidClust, clustFileLineContent);
                
            end
            result = 'Congrats!! Program Executed Successfully...';
            fclose('all');            
            cd(oldPath);
        end
        
    catch ME
        fclose('all');
        result = {ME.identifier, ME.message, ME.stack(1,1).file,ME.stack(1,1).line};%, ME.stack.name, ME.stack.line};
    end    