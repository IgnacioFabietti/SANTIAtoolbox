function [fileList]=readnsplitFile(fileName, path)

    h=waitbar(0,'Loading File... Please Wait...');
    waitbar(1);    
    data=load([path,fileName]);
    close(h)
    
    [m,n]=size(data);
    time=data(:,1);
    
    sweepSamples=0;
    
    h=waitbar(0,'Calculating the Sweep Data Points... Please Wait...');    
    
    for i=2:length(time)
        sweepSamples=sweepSamples+1;
        if(time(i)==0)
            break;
        end
        waitbar(i);
    end
    
    close(h);
    
    sweeps=m/sweepSamples;
    
%     sweepData=reshape(data,[sweepSamples n sweeps]);

    tempData=[];
    preFileName = strtok(fileName, '.');
    compFileName = strcat(preFileName, '-part','%03d','.txt');
    oldPath=pwd;
    cd(path);  
    
    fileList=[];
    
    waitbarMsg ={'Please Wait...', 'Splitting and Saving Files...',' '};
    updateFormat='Now Saving %s';
    h=waitbar(0,waitbarMsg,'Name','File Splitting in Progress');     
    for i=0:sweeps-1
        sweepData=[data(sweepSamples*i+1:sweepSamples*(i+1),1),...
                   data(sweepSamples*i+1:sweepSamples*(i+1),2),];%...
%                    data(sweepSamples*i+1:sweepSamples*(i+1),3),...
%                    data(sweepSamples*i+1:sweepSamples*(i+1),4)];
%         tempData=sweepData(:,:,i);%#ok
%         fileList{i+1}=strcat(newFileName,'-Part',int2str(i+1),'.txt');
        newFileName=sprintf(compFileName,i+1);
        fileList{i+1}=newFileName;
        save(fileList{i+1},'sweepData','-ascii','-tabs');
        newMsg=sprintf(updateFormat, newFileName);
        updatedMssg={'Please Wait...', 'Splitting and Saving Files...', newMsg};
        waitbar(i+1/sweeps, h, updatedMssg);        
    end
    
    close(h);
    
    cd(oldPath);
    
%     fid=0;
%     while fid < 1 
%         oldPath = pwd;
%         cd(path);
% %         fileNameWithPath = strcat(path, fileName);
% %        filename='brainactivity.dat';%input('Open file: ', 's');
%        [fid,message] = fopen(fileName, 'r');
%        if fid == -1
%          disp(message)
%        else
%            disp('File Opened!')
%        end
% %        fclose(fid);
%     end
%     
%     i=0;
%     
%     fileContent = [];
%     fileIndex = 0;
%     newFileName = strtok(fileName, '.');
%     
%     while (feof(fid) == 0)
% %         tempLine = strsplit(fgetl(fid)); % split the line read as strings based on white spaces
% %         whos tempLine
%         tempLine = strsplit(fgetl(fid));
%         tempLine = regexprep(tempLine, ',', '.');
%         tempData = str2double(tempLine);
%         if(tempData(1)==0)
%             if(fileIndex ~= 0)
%               save(strcat(newFileName,int2str(fileIndex),'.dat'),'fileContent','-ASCII');
%               fileContent = [];
%             end
%             fileIndex = fileIndex + 1;
%         end
%         fileContent = [fileContent; tempData];
% %         i = i + 1;
%     end
% %     tempContent = fread(fid, [10,10], 'double')
% %     fileContentData = str2num(fileContent);
%     fclose(fid);
%     cd(oldPath);
    
    