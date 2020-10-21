function [filteredData] = bandpassFilter(data,time,cutPass,cutStop)
    % time=data(:,1);
    T=time(2)-time(1);        
    Fs = 1/T;
    Ws=cutStop/(Fs/2);
    Wp=cutPass/(Fs/2);
    Rp=3;
    Rs=20;
    [N,wn]=buttord(Wp,Ws,Rp,Rs);
    [b,a]=butter(N,wn);
%     freqz(b,a,1024,Fs);
    filteredData=filter(b,a,data); 