function [fet_time, fet_data] = readDatasigmate(filePath, fileName, checkedColumns)

    try
        loaded_file = load ([filePath, fileName]); % load the file into loaded_file from the filename provided as an array of strings
        fet_data=[];
        time = loaded_file(:,1);        
        t=time(2)-time(1);
        if(t>=0.05)
            fet_time=(0:t:t*length(time)-t)'*0.001;
        else
            fet_time=(0:t:t*length(time)-t)';
        end        
        j=2;
        try
            for i = 1:length(checkedColumns)-1
                fet_data = [fet_data, loaded_file(:,checkedColumns(j))]; %#ok<AGROW>
                j=j+1;
            end
        catch %#ok<CTCH>
            fet_data = zeros(length(fet_time),length(checkedColumns)-1);
            msgbox(['Please Check the File ',fileName, ' The System was Unable to Read that File: '],'File Read Error','Error');

        end

    catch %#ok
        errordlg('Problem Reading File','File Reading Error');
    end