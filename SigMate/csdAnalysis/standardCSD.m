function [sigma, newDepth, csdValues, t]=standardCSD (directoryPath, fileNames, recordingDepths, sigma, checkedColumns)
% this function applies the current source density analysis to the filtered
% (lowpass - from 0.1 to 500 Hz) potential signals contained in the columns
% of the matrix "filteredPotentialsForCSD". Sigma is the conductivity and h
% [micron] is the interspace between two recording positions

    [filteredPotentialsForCSD, t] = filterSignalsForCSD(directoryPath, fileNames, checkedColumns);

    if isnan(sigma)
        sigma=0.42; % S/m
    end
    
    h=recordingDepths(2)-recordingDepths(1); %micrometers

    den=((h*(10^(-6)))^2); % convertion in meters
    [r,c]=size(filteredPotentialsForCSD);
    M=zeros(r,c-4);
    pot=zeros(r,c-2);

    for j=2:(c-1)
        pot(:,j-1)=0.23*filteredPotentialsForCSD(:,j+1)+0.54*filteredPotentialsForCSD(:,j)+0.23*filteredPotentialsForCSD(:,j-1); % 3 point hamming filter
    end
    
    latMat=[];
    cutoffFreq=500;
    signalType=2;
    newDepth=recordingDepths(3:length(recordingDepths)-2);    
    
    for j=2:(c-3)
        der2=((pot(:,j+1) -2*pot(:,j) + pot(:,j-1))/1000)/den; % I divide for 1000 because I convert in V
        csd1=-1*der2*sigma;
        csd=csd1/(10^3); % expressed as microA/mm3
        csdValues(:,j-1)=csd;
        
        % calculate the latencies for the csd's
%         data = [t, csd];
%         [t_SS,v_SS,t_RS,v_RS,t_P1,v_P1,l_P1,t_P2,v_P2,l_P2,t_P3,v_P3,l_P3,t_P4,v_P4,l_P4,s,t,flag] =  detectLatencyInCSD(data, cutoffFreq, signalType);
%         latMat=[latMat; newDepth(j-1), (l_P2*1000)];
    end
    
    [r,c]=size(csdValues);
    baseLine(1:r)=0;
    
    % create matrices for 3D plotting

    for x=1:r       
        plotTime(1:c,x)=t(x);
    end
    
    for x=1:c
        plotDepth(1:r,x)=newDepth(x);
        potentials(1:r,x)=filteredPotentialsForCSD(:,x+1);
    end
    
    plotTime=plotTime';
    
    figure('Name','SigMate: Raw signals and their respective CSDs using Standard CSD','NumberTitle','off');
    subplot(121)
    plot3(plotTime,plotDepth,potentials)
    rotate3d on;
    title('LFPs')
    xlabel('time [s]')
    ylabel('depth [um]')
    zlabel('amplitude [mv]')    
    set(gca,'YGrid','on')
    grid on
    set(gca, 'YTick', newDepth)
    set(gca, 'YTickLabel',newDepth)
    
    
    subplot(122)
    plot3(plotTime,plotDepth,csdValues)
    rotate3d on;
    title('CSD using Standard CSD Method')
    xlabel('time [s]')
    ylabel('depth [um]')
    zlabel('amplitude [uA/mm^3]') 
    set(gca,'YGrid','on')    
    grid on
    set(gca, 'YTick', newDepth)
    set(gca, 'YTickLabel',newDepth)    
    
    figure('Name','SigMate: Raw signals and their respective CSDs using Standard CSD','NumberTitle','off');
    subplot(121)
    imagesc(t,newDepth,potentials'.*1000);
    xlabel('time [s]')
    ylabel('depth [um]')
    title('Local Field Potentials')
    cbHandle=colorbar;
    ylabel(cbHandle,'[mv]')
    
    subplot(122)
    imagesc(t, newDepth, csdValues')
    xlabel('time [s]')
    ylabel('depth [um]')
    title('CSD using Standard CSD Method')
    cbHandle=colorbar;
    ylabel(cbHandle,'[uA/mm^3]')     

%     for j=1:c
%         figure(j+1)
%         subplot(2,1,1)
%         plot(t,filteredPotentialsForCSD(:,j+2),t,baseLine)
%         title('LFP')
%         xlabel('s')
%         ylabel('mV')
%         subplot(2,1,2)
%         plot(t,csdValues(:,j),t,baseLine)
%         title('Current Source Density using Standard CSD Method')
%         xlabel('s')
%         ylabel('µA/mm^3')
%     end % for j
