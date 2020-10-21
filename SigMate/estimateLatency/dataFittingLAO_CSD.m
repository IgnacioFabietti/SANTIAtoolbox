clear all

format long

lats=[32.320150 30.001700 23.918750 25.925750 21.026850 22.167000 25.475300 27.717550 26.266100 34.284100 29.319150 22.415250 24.474300 22.565400 29.329150 41.391200 38.668500 57.557350]';
lats=lats+150;
lats=lats./1000;



data=load('C:\Users\Mufti Mahmud\Documents\My Dropbox\WhiskData\Average-Data\onlyCSDs.txt');
[~,n]=size(data);

% data(:,n-1)=data(:,n-1).*-1;

newLats=zeros(size(lats));
newCSDs=zeros(size(data));

t=data(:,1);
newCSDs(:,1)=t;


for i = 2:n
    s=data(:,i);

    % s=d(:,2);

    index=find(t>lats(i-1));
    currIndex=length(t)-length(index)+1;
    tv=t(currIndex);
    sv=s(currIndex);
    newLats(i-1)=tv;

    figure;
    subplot(211)
    plot(t,s,'b',tv, sv,'ro');

    Fs=1/(t(2)-t(1));
    if i==18
        dataPoints=ceil(0.035*Fs);
    else
        dataPoints= ceil(0.05*Fs);
    end
    % newS=s(1:dataPoints);

    maxIndex=find(s==max(s(1:dataPoints)));

    if(maxIndex-currIndex)>0

        indxDiff=maxIndex-currIndex;

        tmpS(1:length(t)-(indxDiff-1))=s(indxDiff:length(t));
        tmpS(length(t)-(indxDiff-1)+1:length(t))=s(length(t));
    elseif(maxIndex-currIndex)==0
        tmpS=s';
    else
        indxDiff=currIndex-maxIndex;

        tmpS(1:indxDiff-1)=s(1);
        tmpS(indxDiff:length(t))=s(1:length(t)-indxDiff+1);
    end

    subplot(212)
    plot(t,tmpS','b',tv,tmpS(currIndex),'ro')

    newCSDs(:,i)=tmpS';
end

d1=load('C:\Users\Mufti Mahmud\Documents\My Dropbox\WhiskData\Average-Data\csds.xls');
ncsds=[newCSDs, d1(:,20:end)];
figure, hold on, for i=2:37, plot(t,ncsds(:,i)), end, hold off

nl=(newLats*1000)-150;
depth=90*(3:1:20);
figure, plot(depth,nl,'ro-'), xlim([250 1820])

% newData=[t, tmpS'];
% save('D:\In-Vivo Recordings\WhiskData\Average-Data\D1-1530.txt','newData','-ascii','-tabs')