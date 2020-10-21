function [fileName] = concatenateFiles(fileList, path, outputFileType)
    
concatenatedFile = [];

h=waitbar(0,'Please Wait... Concatenating Files...');

t=0;

for i = 1 : length(fileList)
    filePath = strcat(path,fileList{i});
    
%     [fid, message] = fopen(filePath, 'r');

%     fileContent = [];
    
    fileContent = load(filePath);
    
    [m,n]=size(fileContent);

    if(m>2 && n>2)
        time=fileContent(:,1);
        data=fileContent(:,4);
    else
        time=fileContent(:,1);
        data=fileContent(:,2);        
    end
    
    t=time(2)-time(1);
    
    if(t>=0.05)

        time=(0:t:t*length(time)-t)'*0.001;
    else
        time=(0:t:t*length(time)-t)';
    end


%     if (fid == -1)%if file cann't be opened
%         errordlg(message, 'Couldn''t Open the Specified File');
%     else
%         while (~feof(fid))
%             tempLine = strsplit(fgetl(fid));
%             tempLine = regexprep(tempLine, ',', '.');
%             tempData = str2double(tempLine);
%             fileContent = [fileContent; tempData];
%         end
        %     fileContent = fileContent';
%         fileName = fileList{i};
%         token = strtok(fileName, '.');
%         newFileName = strcat(token,'_eng','.dat');
%         oldPath = pwd;
%         cd(path);
%         save(newFileName,'fileContent','-ASCII');
%     end
    fileContent = [time,data];
%     fclose(fid);
    
%     loaded_file = load (newFileName); % load the file into loaded_file from the filename provided as an array of strings

    concatenatedFile = [concatenatedFile; fileContent]; %#ok<AGROW>
%     delete(newFileName);
%     cd(oldPath);

    waitbar(i/length(fileList));
end

if(strcmp(outputFileType,'clampfit'))
      
    newtime=concatenatedFile(:,1);
    newdata=concatenatedFile(:,2);
    if(t>=0.05)
        newtime=(0:t:t*length(newtime)-t)'*0.001;
    else
        newtime=(0:t:t*length(newtime)-t)';
    end
%     concatenatedFile=[newtime,newdata];
    
    oldPath = pwd;
    cd(path);
    
    firstPart=regexprep(datestr(clock),':','');
    fileName = strcat(firstPart,'-',strtok(fileList{i},'['),'-clampfit.atf');    
    
%     fileName = strcat(regexprep(path,'\','-'),'clampfit.atf');
%     fileName = regexprep(fileName,':','-');
    fileHeader={'ATF	1.0',' 7	2','"AcquisitionMode=Gap Free"',...
        ' "Comment="','"YTop=30.0005"','"YBottom=-30.0005"',...
        '"SweepStartTimesMS=0.000"','"SignalsExported=Signal 00"',...
        '"Signals=""Signal 00"','"Time (s)"	"Trace #1 (mV)"'};    
    [fid, fmessage] = fopen(fileName,'wt');
    if (fid==0)
        msgbox(['Couldnot Write the Data into File: ',fmessage],'Data File Creation Error','Error');
    else
        for i=1:length(fileHeader)
            headerLine=fileHeader{i};
            fprintf(fid,'%s\n',headerLine);
        end
        for i = 1:1:length(newtime)
            fprintf(fid,'%12.8f\t%12.8f\n',newtime(i), newdata(i));
        end
    end
%     save(fileName,'concatenatedFile', '-ASCII', '-tabs');
    fclose(fid);
    cd(oldPath);    
    close(h);
    
elseif(strcmp(outputFileType,'winw')) 

    oldPath = pwd;
    cd(path);
%     fileName = strcat(regexprep(path,'\','-'),'winwcp-winedr.txt');
%     fileName = regexprep(fileName,':','-');

    firstPart=regexprep(datestr(clock),':','');
    fileName = strcat(firstPart,'-',strtok(fileList{i},'['),'-winwcp-winedr.txt'); 
    
    save(fileName,'concatenatedFile', '-ASCII', '-tabs');
    cd(oldPath);
    close(h);
end
