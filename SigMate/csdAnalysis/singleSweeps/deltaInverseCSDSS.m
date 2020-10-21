function [sigma, sourceDiameter, csd, lfp, t]=deltaInverseCSDSS(directoryPath, fileNames, recordingDepths, sigma, sourceDiameter, checkedColumns, stimOnset)

% this function calculates the current source density analysis to the
% filtered(lowpass - from 0.1 to 500 Hz) potential using the delta inverse
% method. Signals contained in the columns of the matrix
% "filteredPotentialsForCSD". sigma is the conductivity tensor, h is the
% electrode spacing, z1 is the first recording site, R is the radius of the
% disc of the source of CSD

    [filteredPotentialsForCSD, t]= filterSignalsForCSD(directoryPath, fileNames, checkedColumns, stimOnset);

    [r,c]=size(filteredPotentialsForCSD);
    Fs=1/(t(2)-t(1)); 

    if isnan(sigma)
        sigma=0.42; % S/m
    end
    h=(recordingDepths(2)-recordingDepths(1))/(10^6); % micrometers
    if isnan(sourceDiameter)
        d=500/(10^6);
        sourceDiameter=500;
    else
        d=sourceDiameter/(10^6);
    end
    R=d/2;
    z1=recordingDepths(1)/(10^6);

%     for j=2:(c-1)
%         potentials(:,j-1)=(0.23*filteredPotentialsForCSD(:,j+1)+0.54*filteredPotentialsForCSD(:,j)+0.23*filteredPotentialsForCSD(:,j-1))/1000; % 3 point hamming filter
%     end

    [r,c]=size(filteredPotentialsForCSD);
    z=zeros(c,1);
    z(1)=z1;
    k=(h^2)/(2*sigma);

    for j=1:c
        z(j)=z1+(j-1)*h;
        for i=1:c
            F(j,i)=k*(sqrt((j-i)^2+(R/h)^2)-abs(j-i));
        end
    end

    inv_F=inv(F);
    C=inv_F*filteredPotentialsForCSD'./1000;

    csdValues=C'/(10^3);
    
    lfp=filteredPotentialsForCSD(:,2);
    csd=csdValues(:,2);
    
%     [r,c]=size(csdValues);
%     baseLine(1:r)=0;

%     % create matrices for 3D plotting
%     newDepth=recordingDepths;%(2:length(recordingDepths)-1);
%     for x=1:r       
%         plotTime(1:c,x)=t(x);
%     end
%     
%     for x=1:c
%         plotDepth(1:r,x)=newDepth(x);
%     end
%     
%     plotTime=plotTime';
%     
%     figure;
%     subplot(121)
%     plot3(plotTime,plotDepth,potentials.*1000)
%     rotate3d on;
%     title('LFPs')
%     xlabel('time [s]')
%     ylabel('depth [um]')
%     zlabel('amplitude [mv]')    
%     set(gca,'YGrid','on')
%     grid on
%     set(gca, 'YTick', newDepth)
%     set(gca, 'YTickLabel',newDepth)
%     
%     
%     subplot(122)
%     plot3(plotTime,plotDepth,csdValues)
%     rotate3d on;
%     title('CSD using Delta iCSD Method')
%     xlabel('time [s]')
%     ylabel('depth [um]')
%     zlabel('amplitude [uA/mm^3]') 
%     set(gca,'YGrid','on')    
%     grid on
%     set(gca, 'YTick', newDepth)
%     set(gca, 'YTickLabel',newDepth)
%     
%     figure;
%     subplot(121)
%     imagesc(t,newDepth,potentials'.*1000);
%     xlabel('time [s]')
%     ylabel('depth [um]')
%     title('Local Field Potentials')
%     cbHandle=colorbar;
%     ylabel(cbHandle,'[mv]')
%     
%     subplot(122)
%     imagesc(t, newDepth, csdValues')
%     xlabel('time [s]')
%     ylabel('depth [um]')
%     title('CSD using Delta iCSD Method')
%     cbHandle=colorbar;
%     ylabel(cbHandle,'[uA/mm^3]')      
    
%     for j=1:c-2
%         figure(j)
%         subplot(2,1,1)
%         plot(t,filteredPotentialsForCSD(:,j),t,baseLine)
%         title('LFP')
%         xlabel('s')
%         ylabel('mV')
%         subplot(2,1,2)
%         plot(t,csdValues(:,j),t,baseLine)
%         title('Current Source Density using Delta Inverse CSD Method')
%         xlabel('s')
%         ylabel('µA/mm^3')
%     end % for j