function [firstSteadyState]=findFirstSteadyState(filePath, fileName)%(t,s)

data=load([filePath,fileName]);
t=data(:,1);
s=data(:,2);

% figure;
% plot(t,s);
% title('Real signal');
% xlabel('time: ms');
% ylabel('amplitude: mV');

firstSteadyState=[]; 

T=(t(2)-t(1));
Fs=1/T;

interval=0.01*Fs; %first 10 ms in which there is NO SIGNAL

firstPart=s(1:interval);
firstPartT= t(1:interval);
stdFirst= std(firstPart);

% figure;       
% plot(firstPartT,firstPart);

parts=[];
partsT=[];

intervalInt=0.003*Fs;

newS=s(interval+1:length(s));
newT=t(interval+1:length(s));

newLoops=round(length(newS)/intervalInt);

for i=0:newLoops-2
   parts=[parts, newS((intervalInt*i)+1:(intervalInt*(i+1)))];
   partsT = [partsT, newT((intervalInt*i)+1:(intervalInt*(i+1)))];
end

fittedLine=[];

newPart=[];
newPartT=[];

newPart=[newPart;firstPart];
newPartT=[newPartT;firstPartT];

p=polyfit(partsT(:,1),parts(:,1),1);
prevLine=polyval(p,partsT(:,1));
fittedLine=[fittedLine; prevLine];

sdS=std(s);

stdCheck=stdFirst;

flag=1;

for i = 1:newLoops-1
    tempP=polyfit(partsT(:,i),parts(:,i),1);
    tempLine=polyval(tempP,partsT(:,i));
    
    sdNew=std(parts(:,i));
    
    if (sdNew<=stdCheck && flag)
        stdCheck=sdNew;
        newPart=[newPart;parts(:,i)];
        newPartT=[newPartT;partsT(:,i)];
        fittedLine=[fittedLine;tempLine];
        continue;
    else
        flag=0;
        
        newPart=[newPart;parts(:,i)];
        newPartT=[newPartT;partsT(:,i)];
        fittedLine=[fittedLine;tempLine];           
    end

    if (tempLine(intervalInt)>sdS)
        newPart=newPart(1:interval+intervalInt*(i-1));
        newPartT=newPartT(1:interval+intervalInt*(i-1));        
        break;
    end
end

firstSteadyState=[newPartT,newPart];

% figure;
% plot(t,s,'r',newPartT,newPart,'g');
% title('signal with recognized parts');
% xlabel('time(ms)');
% ylabel('amplitude(mV)');
