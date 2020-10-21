clear all

d=load('D:\In-Vivo Recordings\WhiskData\Filtered\filtered-D1-1530.txt');
t=d(:,1);
s=d(:,2);

indx=find(t==0.173022850000000);
minIndx=find(t==t(find(s==min(s))));

if(minIndx-indx)>0

    indxDiff=minIndx-indx;

    tmpS(1:length(t)-(indxDiff-1))=s(indxDiff:length(t));
    tmpS(length(t)-(indxDiff-1)+1:length(t))=s(length(t));
elseif(minIndx-indx)==0
    tmpS=s';
else
    indxDiff=indx-minIndx;

    tmpS(1:indxDiff-1)=s(1);
    tmpS(indxDiff:length(t))=s(1:length(t)-indxDiff+1);
end

newData=[t, tmpS'];
save('D:\In-Vivo Recordings\WhiskData\Average-Data\D1-1530.txt','newData','-ascii','-tabs')