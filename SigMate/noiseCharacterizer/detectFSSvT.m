%This is for the Transistor Recordings

function [steadyS,steadyT]=detectFSSvT(filePath, fileName)

data=load([filePath,fileName]);

t=data(:,1);
s=data(:,2);

tNew=t(21:length(t));
sNew=s(21:length(s));

ms=9/1000; %this is the first 9 ms considered as steady state
Fs=20000; % sampling frequency

% STD of FSS

fssDP = Fs*ms; % data points of the first steady state
S_std=std(sNew(1:fssDP));

% divide signal into 2ms intervall

dt=(3/1000); % intervals for dividing the signal
data_dt=dt*Fs;
% startR=fssDP+1;

 steadyStateS=sNew(1:fssDP);
 steadyStateT=tNew(1:fssDP);
 
stoDivide=sNew(fssDP+1:length(sNew));
ttoDivide=tNew(fssDP+1:length(tNew));

sMat=[];
tMat=[];

noOfDiv = floor((length(stoDivide)/data_dt)); 

for i= 1 : noOfDiv
    sMat=[sMat,stoDivide((i-1)*data_dt+1:i*data_dt)];
    tMat=[tMat,ttoDivide((i-1)*data_dt+1:i*data_dt)];
end    

straightLine=[];
tempP=polyfit(steadyStateT,steadyStateS,1);
tempLine=polyval(tempP,steadyStateT);

straightLine=[straightLine;tempLine];

stdS = std(sNew);

flag=1;

for i=1:noOfDiv-1
    % fitting line of the current intervall
    fitC=polyfit(tMat(:,i),sMat(:,i),1);
    fitLine=polyval(fitC,tMat(:,i));
    
    sToComp=std(sMat(:,i));
    if (sToComp<=S_std && flag)
        %S_std=sToComp;
        steadyStateS=[steadyStateS;sMat(:,i)];
        steadyStateT=[steadyStateT;tMat(:,i)];
        straightLine=[straightLine;fitLine];  
        continue;
    else
        flag=0;
        steadyStateS=[steadyStateS;sMat(:,i)];
        steadyStateT=[steadyStateT;tMat(:,i)];
        straightLine=[straightLine;fitLine];
    end    
    if (fitLine(data_dt)>stdS) || (fitLine(data_dt)<-stdS)
        steadyS=steadyStateS(1:fssDP+(i-1)*data_dt);
        steadyT=steadyStateT(1:fssDP+(i-1)*data_dt);
        break;
    end
end    

% figure;
% hold on;
% plot(tNew,sNew,'b');
% plot(steadyT,steadyS,'r');
% hold off;


        