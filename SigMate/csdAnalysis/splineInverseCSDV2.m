function [sigma, sourceDiameter, recordingDepths, csdValues, t]=splineInverseCSDV2(directoryPath, fileNames, recordingDepths, sigma, sourceDiameter, checkedColumns, stimOnset)


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


    [filteredPotentialsForCSD, t]= filterSignalsForCSD(directoryPath, fileNames, checkedColumns, stimOnset);
    
    [r,c] = size(filteredPotentialsForCSD);
    vr1 = filteredPotentialsForCSD(:,1);
    vr2 = filteredPotentialsForCSD(:,c);
    
    newFilteredPotentials = [vr1 filteredPotentialsForCSD vr2];
    
%     newTime = t(ceil((0.001/(t(2)-t(1)))*stimOnset)+1:length(t));    

%     [r,c]=size(filteredPotentialsForCSD);
    [r,c]=size(newFilteredPotentials);
    r1=zeros(length(t),1);


    for j=1:(c-2)
%          potentials(:,j)=(0.23*filteredPotentialsForCSD(:,j+2)+0.54*filte
%          redPotentialsForCSD(:,j+1)+0.23*filteredPotentialsForCSD(:,j))/1000; % 3 point hamming filter + convertion in V
         potentials(:,j)=(0.23*newFilteredPotentials(:,j+2)+0.54*newFilteredPotentials(:,j+1)+0.23*newFilteredPotentials(:,j))/1000; % 3 point hamming filter + convertion in V         
    end
    
    newPotentials=[r1 potentials r1];%/1000; % convertion in V

    csdValues=calculateSplineICSD(newPotentials,sigma,h,z,R);
    
    csdValues=csdValues';
    
    
    [r,c]=size(csdValues); 
    baseLine(1:r)=0;
    
    % create matrices for 3D plotting
%     newDepth=recordingDepths(2:length(recordingDepths)-1);

    for x=1:r       
        plotTime(1:c,x)=t(x);
    end
    
    for x=1:c
        plotDepth(1:r,x)=recordingDepths(x);%newDepth(x);
    end
    
    plotTime=plotTime';
    
%     figure('Name','SigMate: Raw signals and their respective CSDs using Spline Inverse CSD','NumberTitle','off');
%     subplot(121)
%     plot3(plotTime,plotDepth,filteredPotentialsForCSD);%.*1000)
%     rotate3d on;
%     title('LFPs')
%     xlabel('time [s]')
%     ylabel('depth [um]')
%     zlabel('amplitude [mv]')    
%     set(gca,'YGrid','on')
%     grid on
%     set(gca, 'YTick', recordingDepths)
%     set(gca, 'YTickLabel',recordingDepths)
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
%     set(gca, 'YTick', recordingDepths)
%     set(gca, 'YTickLabel',recordingDepths)

    plotDepthProfile(filteredPotentialsForCSD,t,'Filtered LFPs', 'amplitude[mv]');
    plotDepthProfile(csdValues,t,'Calculated CSD using Spline iCSD','amplitude[uA/mm^3]');
    
    figure('Name','SigMate: Raw signals and their respective CSDs using Spline Inverse CSD','NumberTitle','off');
    subplot(121)
    imagesc(t,newDepth,filteredPotentialsForCSD);%potentials'.*1000);
    xlabel('time [s]')
    ylabel('depth [um]')
    title('Local Field Potentials')
    cbHandle=colorbar;
    ylabel(cbHandle,'[mv]')
    
    subplot(122)
    imagesc(t, newDepth, csdValues')
    xlabel('time [s]')
    ylabel('depth [um]')
    title('CSD using Spline iCSD Method')
    cbHandle=colorbar;
    ylabel(cbHandle,'[uA/mm^3]')    
    