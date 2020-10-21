function [fet_time, fet_data, samplingFreq, dataPoints] = loadData(fileList, path, checkedColumns)
        
    
    h=waitbar(0,'Please wait... Loading Data...');
    
    fet_time = [];

    fet_data=[];
    
    t=0;    
%     m=0;

    try
    columns = length(checkedColumns);
    
    for i = 1 : length(fileList)
        filePath = strcat(path,fileList{i});

        loaded_file = load (filePath); % load the file into loaded_file from the filename provided as an array of strings
        
        [m,n]=size(loaded_file);
        
        dataPoints=length(loaded_file);
        
        if(n>m)
            msgbox('Consider Transposing Your Data File',['Data File Format Error in ',filePath],'Error');
        else
        
            time_fet = loaded_file(:,1);
            t=time_fet(2)-time_fet(1);
            if(t>=0.05)
                time_fet=(0:t:t*length(time_fet)-t)'*0.001;
            else
                time_fet=(0:t:t*length(time_fet)-t)';
            end

            k=2;
            for j = 1:1:columns-1

                    tempData = loaded_file(:,checkedColumns(k));
                    data_fet(:,j) = tempData; %#ok<AGROW>

                    k=k+1;                 
            end


            fet_time = vertcat(fet_time, time_fet);

            fet_data=[fet_data;data_fet]; %#ok<AGROW>
                
            waitbar(i/length(fileList));
        end
    end
    
    samplingFreq = 1/t;
%     dataPoints = m;

    catch %#ok
        errordlg('There were errors reading your data files. Please check for possible data file column mismatch','Data File Reading Error');
        close(h);
    end
    close(h);
