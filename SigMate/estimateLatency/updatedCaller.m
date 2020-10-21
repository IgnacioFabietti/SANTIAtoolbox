%     filePath='E:\In-Vivo Recordings\20091021_P31_80g_female\Texts\';
    filePath='E:\In-Vivo Recordings\CHIP FLO\20091110\C1 1st FET\';
    fileNames={
    %     'D1-0um.txt'
    %     'D1-90um.txt'
    %     'D1-180um.txt'
    %     'D1-270um.txt'
    %     'D1-360um.txt'
    %     'D1-450um.txt'
    %     'D1-540um.txt'
    %     'D1-630um.txt'
    %     'D1-720um.txt'
    %     'D1-810um.txt'
    %     'D1-900um.txt'
    %     'D1-990um.txt'
    %     'D1-1080um.txt'
    %     'D1-1170um.txt'
    %     'D1-1260um.txt'
    %     'D1-1350um.txt'
    %     'D1-1440um.txt'
    %     'D1-1530um.txt'
    %     'D1-1620um.txt'
    %     'D1-1710um.txt'
    %     'D1-1800um.txt'
    
%         'Rearranged-154656 Whisker Stim 10V 10ms C1 z=-845um Avg.txt'
%         'Rearranged-155129 Whisker Stim 10V 10ms C1 z=-1115um Avg.txt'
%         'Rearranged-155544 Whisker Stim 10V 10ms C1 z=-1385um Avg.txt'
%         'Rearranged-155947 Whisker Stim 10V 10ms C1 z=-1655um Avg.txt'
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


    try    
%     fh_threshold = findobj('Tag','txtThreshold');
%     threshold=str2double(get(fh_threshold,'String')); %returns contents ...
                                %of txtThreshold as text and then to double
    oldPath=pwd;
    directoryPath=filePath;
    
    cutoffFreq=500;
           
    numberOfParameters = 16;
    
    Results = zeros(length(fileNames), numberOfParameters);

%     signalType=2; % micropipette recording
    signalType=3; % transistor recording
    
%     fileFormat='\n%13s\t%16.8f\t%16.8f\t%16.8f\t%16.8f\t%16.8f\t%16.8f\t%16.8f\t%16.8f\t%16.8f\t%16.8f\t%16.8f\t%16.8f\t%16.8f\t%16.8f\t%16.8f\t';
%     headerFormat='%13s\t%16s\t%16s\t%16s\t%16s\t%16s\t%16s\t%16s\t%16s\t%16s\t%16s\t%16s\t%16s\t%16s\t%16s\t%16s\t';
    
%     headerContent=sprintf(headerFormat,'File Name','t_stimulus (ms)','t_response (ms)','latency_response (ms)','t_Peak1 (ms)','v_Peak1 (uV)','latency_Peak1 (ms)','t_Peak2 (ms)','v_Peak2 (uV)','latency_Peak2 (ms)','t_Peak3 (ms)','v_Peak3 (uV)','latency_Peak3 (ms)','t_Peak4 (ms)','v_Peak4 (uV)','latency_Peak4 (ms)');

    cd(directoryPath);
    
    tmpStr=strrep(datestr(clock),':','');
    tmpStr=strrep(tmpStr,'-','');
    tmpStr=strrep(tmpStr,' ','-');
%     tempFileName= inputdlg('Enter the File Name for Saving, without File Extension','Save As',1);
%     saveFileName=[tmpStr,'-',tempFileName{1},'.txt'];
    tempFileName= 'eventParameters';
    saveFileName=[tmpStr,'-',tempFileName,'.txt'];
    
%     fid=fopen(saveFileName,'w');

%     if(fid==-1)
%         msgbox(['Sorry, the file ', saveFileName,' cannot be opened!'],'File Opening Error','Error');
%     else
%         fprintf(fid,headerContent);
        paramData=[];
        filtData=[];
        for i=1:length(fileNames)
            fileName = fileNames{i};
            [t_SS,v_SS,t_RS,v_RS,t_P1,v_P1,l_P1,t_P2,v_P2,l_P2,t_P3,v_P3,l_P3,t_P4,v_P4,l_P4,s,t,flag] =  detectLatencyInAvgV3(directoryPath, fileName, cutoffFreq, signalType);
            tmpT=[];
            tmpD=[];
            tmpData=[];
            tmpT=[t_RS;t_P1;t_P2;t_P3;t_P4];
            tmpD=[v_RS;v_P1;v_P2;v_P3;v_P4];
            tmpData=[tmpT,tmpD];
            paramData=[paramData;tmpData];
            if i==1
                filtData=[filtData,t,s];
            else
                filtData=[filtData,s];
            end
%             fprintf(fid,fileFormat,fileNames{i},t_SS,t_RS,(t_RS-t_SS), t_P1, v_P1, l_P1, t_P2, v_P2, l_P2, t_P3, v_P3, l_P3, t_P4, v_P4, l_P4);
        end
%     end

    currPath=pwd;
    cd(filePath);
    save([tmpStr,'-','filteredData.txt'],'filtData','-ascii','-tabs');
    save(saveFileName,'paramData','-ascii','-tabs');
    cd(currPath);
%     fclose('all');

    msgString={datestr(clock),'Data File Containing the Parameters Detected is Saved at ', directoryPath};
    msgbox(msgString,'Program Execution Success','help'); 

    cd(oldPath);
    catch exception1
        errordlg('There were errors in opening the data files','File Opening Error');
    end