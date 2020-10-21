
filePath='E:\In-Vivo Recordings\20091021_P31_80g_female\Texts\';
fileNames={
%     'D1-0um.txt'
%     'D1-90um.txt'
%     'D1-180um.txt'
    'D1-270um.txt'
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
    };
numberOfParameters = 11;
Results = zeros(length(fileNames), numberOfParameters);

fileFormat='\n%13s\t%16.8f\t%16.8f\t%16.8f\t%16.8f\t%16.8f\t%16.8f\t%16.8f\t%16.8f\t%16.8f\t%16.8f\t%16.8f\t';
headerFormat='%13s\t%16s\t%16s\t%16s\t%16s\t%16s\t%16s\t%16s\t%16s\t%16s\t%16s\t%16s';
headerContent=sprintf(headerFormat,'File Name','t_stimulus','v_stimulus','t_negPeak1','v_negPeak1','latency_negPeak1','t_posPeak1','v_posPeak1','latency_posPeak1','t_negPeak2','v_negPeak2','latency_negPeak2');

cd(filePath);

fid=fopen('signalCharacteristics.xls','w');

if(fid==-1)
    msgbox('Sorry, the file signalCharacteristics.txt cannot be opened!','File Opening Error','Error');
else
    
    fprintf(fid,headerContent);
    for i=1:length(fileNames)
        [par1, par2, par3, par4, par5, par6, par7, par8, par9, par10, par11] = detectLatencyInAvg(filePath, fileNames{i});
        [token,remain]=strtok(fileNames{i},'u');
        [secTok,secRem]=strtok(token,'-');
        if (length(secRem(2:length(secRem)))==1)
            newSecRem=strcat('-000',secRem(2:length(secRem)));
        elseif (length(secRem(2:length(secRem)))==2)
            newSecRem=strcat('-00',secRem(2:length(secRem)));
        elseif (length(secRem(2:length(secRem)))==3)
            newSecRem=strcat('-0',secRem(2:length(secRem)));
        end
        newFileName=[secTok,newSecRem,remain];

        fprintf(fid,fileFormat,newFileName,par1, par2, par3, par4, par5, par6, par7, par8, par9, par10,par11);
    end
end

fclose(fid);

msgString={datestr(clock),'Data File Containing the Parameters Detected is Saved at ', filePath};
msgbox(msgString,'Program Execution Success','help');