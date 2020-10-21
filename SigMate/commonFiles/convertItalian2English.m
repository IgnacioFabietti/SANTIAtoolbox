function convertItalian2English(fileNamewithExtension)%,ext)

% fileNamewithExtension = strcat(fileName);%,ext);
try
    [fid, message] = fopen(fileNamewithExtension, 'r');

    fileContent = [];
    
    lineNo = 0;

    if (fid == -1)%if file cann't be opened
        errordlg(message, 'Couldn''t Open the Specified File');
    else
        while (~feof(fid))
            lineNo = lineNo + 1;
            dataLine = fgetl(fid);
            if lineNo == 1 && isempty(dataLine)
                continue;
            else
                tempLine = strsplit(dataLine);
                tempLine = regexprep(tempLine, ',', '.');
                tempData = str2double(tempLine);
                fileContent = [fileContent; tempData];
            end
        end
        save(strcat(fileNamewithExtension(1:end-4),'_eng',fileNamewithExtension(end-3:end)),'fileContent','-ASCII','-tabs');
    end
    fclose(fid);
catch exception
    errordlg(exception.message, 'File Error');
    fclose(fid);
end