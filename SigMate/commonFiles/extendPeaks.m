function [newData]=extendPeaks(peakData,peakTime,sweepTime)
    %This module extends the detected peak points to the number of 
    %elements in the actual signal
    ti=sweepTime(2)-sweepTime(1);
    newData=[];
    for i = 1:length(peakData)-1
        startPoint=length(newData);
%         if (i==length(peakData)-1)
%             numberPoints = round((sweepTime(length(sweepTime))-peakTime(i))/ti);
%         else
            numberPoints = round((peakTime(i+1)-peakTime(i))/ti);            
%         end
        newData(startPoint+1:startPoint+numberPoints)=linspace(peakData(i),peakData(i+1),numberPoints);
    end
    newData(length(newData)+1)=newData(length(newData));
    newData=newData';