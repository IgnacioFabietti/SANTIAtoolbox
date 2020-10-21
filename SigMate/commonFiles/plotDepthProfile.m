function [figHand, modPot, zeroLine]=plotDepthProfile(signalMatrix, time, plotTitle, yTick)
    
    addValue=abs(min(min(signalMatrix))); 
    [r,c]=size(signalMatrix); 
    modPot=[];%zeros(r,c);
    zeroLine=zeros(r,c);
    yTickGaps=[];
    figHand=figure('Name',['SigMate: ' plotTitle],'NumberTitle','off');    
    hold on; 
    for i = 1:c
        modPot(:,i)=signalMatrix(:,i)-(addValue*i);
        zeroLine(:,i)=zeroLine(:,i)-(addValue*i);
        plot(time, zeroLine(:,i), 'k', time, modPot(:,i), 'b');
        yTickGaps(i)=modPot(1,i);
    end
    hold off
    axis tight
    title(plotTitle)    
    xlabel('time [s]')
    yTickGaps=sort(yTickGaps);
    yLabel=sort(yTick,'descend');
    set(gca,'YTick',yTickGaps)
    set(gca, 'YTickLabel',yLabel)      
    ylabel('Recording Depth [um]')