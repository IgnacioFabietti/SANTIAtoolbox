function [sndSteadyS,sndSteadyT]=findSSS(filePath, fileName, firstSSS, firstSST)

data=load([filePath,fileName]);
tt=data(:,1);
ss=data(:,2);

% from the detectFFSv2 function I need to know the length of te FSS and the
% std of that part of the signal
fss_length=length(firstSSS);
fst_length=length(firstSST);
fss_std=std(firstSSS);


% part of the signal where to look for the SndSS
sToAnalyse=ss(fss_length+1:length(ss));
tToAnalyse=tt(fst_length+1:length(tt));

sToAnalyse_sw=flipud(sToAnalyse);
tToAnalyse_sw=flipud(tToAnalyse);

numDiv=round(length(sToAnalyse_sw)/fss_length);

sssPointS_temp=[];
sssPointT_temp=[];

flag=0;

for i=1:numDiv-1
    std_prt=std(sToAnalyse_sw((i-1)*fss_length+1:i*fss_length));
    if std_prt<=fss_std
        sssPointS_temp=[sssPointS_temp;sToAnalyse_sw((i-1)*fss_length+1:i*fss_length)];
        sssPointT_temp=[sssPointT_temp;tToAnalyse_sw((i-1)*fss_length+1:i*fss_length)];
        continue;
    else
        flag=flag+1;
        if (flag<=2) && ((i+1)*fss_length < length(sToAnalyse_sw))
           std_prtSnd=std(sToAnalyse_sw(i*fss_length+1:(i+1)*fss_length));
           if std_prtSnd<=fss_std
               sssPointS_temp=[sssPointS_temp;sToAnalyse_sw((i-1)*fss_length+1:i*fss_length)];
               sssPointT_temp=[sssPointT_temp;tToAnalyse_sw((i-1)*fss_length+1:i*fss_length)];
%                sssPointS_temp=[sssPointS_temp;sToAnalyse_sw(i*fss_length+1:(i+1)*fss_length)];
%                sssPointT_temp=[sssPointT_temp;tToAnalyse_sw(i*fss_length+1:(i+1)*fss_length)]; 
%                i=i+2;%#ok
           end
        else
            break;
        end
    end
end

sndSteadyS=flipud(sssPointS_temp);
sndSteadyT=flipud(sssPointT_temp);

% hold on
% plot(sndSteadyT,sndSteadyS,'g');
% hold off


