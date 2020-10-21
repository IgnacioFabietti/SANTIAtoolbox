function [fileName] = concatenateColumns(fileList, path)
    
concatenatedFile = [];

h=waitbar(0,'Please Wait... Concatenating Files...');

t=0;

for i = 1 : length(fileList)
    filePath = strcat(path,fileList{i});
    
%     [fid, message] = fopen(filePath, 'r');

%     fileContent = [];
    
    fileContent = load(filePath);
    
    if i==1
        [m,n]=size(fileContent);
        data=[];
        if(m>2 && n>2)
            time=fileContent(:,1);
%             for xx=2:n
%                 data=[data, fileContent(:,xx)];
%             end
            data=fileContent(:,2:n);
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
        
        fileContent = [time,data];
        
    else
        data=[];
        if n>2
%             for xx=2:n
%                 data=[data,fileContent(:,xx)]; 
%             end
            data=fileContent(:,2:n);
        else
            data=fileContent(:,2);              
        end
        fileContent=data;
    end

    concatenatedFile = [concatenatedFile, fileContent]; %#ok<AGROW>

    waitbar(i/length(fileList));
end
   
oldPath = pwd;
cd(path);
firstPart=regexprep(datestr(clock),':','');
fileName = strcat(firstPart,'-',strtok(fileList{i},'['),'-Horizontal.txt');
% fileName = regexprep(fileName,':','-');
save(fileName,'concatenatedFile', '-ASCII', '-tabs');
cd(oldPath);

close(h);

end
