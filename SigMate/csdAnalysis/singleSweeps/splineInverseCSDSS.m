function [sigma, sourceDiameter, csd, lfp, t]=splineInverseCSDSS(directoryPath, fileNames, recordingDepths, sigma, sourceDiameter, checkedColumns)


    recordingPitch=recordingDepths(2)-recordingDepths(1);
    newDepth(1)=recordingDepths(1)-recordingPitch;
    newDepth(2:length(recordingDepths)+1)=recordingDepths;
    newDepth(length(newDepth)+1)=recordingDepths(length(recordingDepths))+recordingPitch;
    
    z=newDepth/(10^6); % electrode spacing in meters
    N=length(z)-2;
    if isnan(sigma)
        sigma=0.42; % S/m
    end
    if isnan(sourceDiameter)
        d=500/(10^6);
        sourceDiameter=500;
    else
        d=sourceDiameter/(10^6);
    end
    R=d/2;
    h=recordingPitch/(10^(6)); % 90 micron


    [filteredPotentialsForCSD, t]= filterSignalsForCSD(directoryPath, fileNames, checkedColumns);

    [r,c]=size(filteredPotentialsForCSD);
    r1=zeros(length(t),1);


%     for j=1:(c-2)
%          potentials(:,j)=(0.23*filteredPotentialsForCSD(:,j+2)+0.54*filteredPotentialsForCSD(:,j+1)+0.23*filteredPotentialsForCSD(:,j))/1000; % 3 point hamming filter + convertion in V
%     end
    
    newPotentials=[r1 filteredPotentialsForCSD r1]/1000; % convertion in V

    csdValues=calculateSplineICSDSS(newPotentials,sigma,h,z,R);
    
    csdValues=csdValues';
    
    lfp=filteredPotentialsForCSD(:,2);
    csd=csdValues(:,2);


%     [r,c]=size(csdValues);
%     baseLine(1:r)=0;
%     
%     % create matrices for 3D plotting
%     newDepth=recordingDepths(2:length(recordingDepths)-1);
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
%     title('CSD using Spline iCSD Method')
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
%     title('CSD using Spline iCSD Method')
%     cbHandle=colorbar;
%     ylabel(cbHandle,'[uA/mm^3]')    
    

%     for j=2:c-1
%         figure(j)
%         subplot(2,1,1)
%         plot(t,filteredPotentialsForCSD(:,j),t,baseLine)
%         title('LFP')
%         xlabel('s')
%         ylabel('mV')
%         subplot(2,1,2)
%         plot(t,csdValues(:,j-1),t,baseLine)
%         title('Current Source Density using Spline Inverse CSD Method')
%         xlabel('s')
%         ylabel('µA/mm^3')
%     end % for j