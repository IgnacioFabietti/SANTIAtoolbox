function result = estimateLatencyInMultiple(cutoffFreq, signalType)

    try
  
        path='D:\In-Vivo Recordings\lfpSorting-Data\ClusteredLFPs-Raw-20091021\';
        oldPath=cd(path);
        
        fileFormat='\n%13s\t%16.8f\t%16.8f\t%16.8f\t%16.8f\t%16.8f\t%16.8f\t%16.8f\t%16.8f\t%16.8f\t%16.8f\t%16.8f\t';
        headerFormat='%13s\t%16s\t%16s\t%16s\t%16s\t%16s\t%16s\t%16s\t%16s\t%16s\t%16s\t%16s\t';
        headerContent=sprintf(headerFormat,'Cluster Name','t_stimulus (ms)','t_response (ms)','latency_response (ms)','v_Peak1 (uV)','latency_Peak1 (ms)','v_Peak2 (uV)','latency_Peak2 (ms)','v_Peak3 (uV)','latency_Peak3 (ms)','v_Peak4 (uV)','latency_Peak4 (ms)'); 
        
        folderNames={
            '0090ClusteredAverages'
            '0180ClusteredAverages'
            '0270ClusteredAverages'
            '0360ClusteredAverages'
            '0450ClusteredAverages'
            '0540ClusteredAverages'
            '0630ClusteredAverages'
            '0720ClusteredAverages'
            '0810ClusteredAverages'
            '0900ClusteredAverages'
            '0990ClusteredAverages'
            '1080ClusteredAverages'
            '1170ClusteredAverages'
            '1260ClusteredAverages'
            '1350ClusteredAverages'
            '1440ClusteredAverages'
            '1530ClusteredAverages'
            '1620ClusteredAverages'
            '1710ClusteredAverages'
            };    

        for folderIndex=1:length(folderNames)

            directoryPath=[path folderNames{folderIndex} '\'];
            currPath=cd(directoryPath);
            fileNames = getDirContents(directoryPath, '*.txt');
            
            tmpStr=strrep(datestr(clock),':','');
            tmpStr=strrep(tmpStr,'-','');
            tmpStr=strrep(tmpStr,' ','-');
            saveFileName=[tmpStr,'-',folderNames{folderIndex},'.xls'];

            fid=fopen(saveFileName,'w');
            
            latContent=[];
            ampContent=[];
            
            fprintf(fid,headerContent);

            for i=1:length(fileNames)

                fileName=fileNames{i};
                [t_SS,v_SS,t_RS,v_RS,t_P1,v_P1,l_P1,t_P2,v_P2,l_P2,t_P3,v_P3,l_P3,t_P4,v_P4,l_P4,s,t,flag] =  detectLatencyInAvgV3(directoryPath, fileName, cutoffFreq, signalType);
                fprintf(fid,fileFormat,fileNames{i},t_SS*1000,t_RS*1000,(t_RS-t_SS)*1000, v_P1*1000, l_P1*1000, v_P2*1000, l_P2*1000, v_P3*1000, l_P3*1000, v_P4*1000, l_P4*1000);
                tempLat=[l_P1*1000, l_P2*1000, l_P3*1000, l_P4*1000];
                tempAmp=[v_P1*1000, v_P2*1000, v_P3*1000, v_P4*1000];
                latContent=[latContent; tempLat];
                ampContent=[ampContent; tempAmp];              
            end
             fclose(fid);
             cd(currPath);
             save([folderNames{folderIndex} '-Latencies.txt'],'latContent','-ascii','-tabs');
             save([folderNames{folderIndex} '-Amplitudes.txt'],'ampContent','-ascii','-tabs');
        end
        result = 'Congrats!! Program Executed Successfully...';
        cd(oldPath);
        
    catch ME
        fclose('all');
        result = {ME.identifier, ME.message, ME.stack(1,1).file,ME.stack(1,1).line};%, ME.stack.name, ME.stack.line};
    end    