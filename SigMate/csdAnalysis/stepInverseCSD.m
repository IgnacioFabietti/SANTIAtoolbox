function [sigma, sourceDiameter, newDepth, csdValues, t]=stepInverseCSD(directoryPath, fileNames, recordingDepths, sigma, sourceDiameter, checkedColumns)

% this function calculates the current source density analysis to the
% filtered(lowpass - from 0.1 to 500 Hz) potential using the step inverse
% method. Signals contained in the columns of the matrix
% "filteredPotentialsForCSD". sigma is the conductivity tensor, h is the
% electrode spacing, z is a vector that contain the recording sites, R is
% the radius the source of CSD

    [filteredPotentialsForCSD, t]= filterSignalsForCSD(directoryPath, fileNames, checkedColumns);

    [r,c]=size(filteredPotentialsForCSD);
    pot=filteredPotentialsForCSD/1000;


    for j=1:(c-2)
         potentials(:,j+1)=(0.23*filteredPotentialsForCSD(:,j+2)+0.54*filteredPotentialsForCSD(:,j+1)+0.23*filteredPotentialsForCSD(:,j))/1000; % 3 point hamming filter + convertion in V
    end

    potentials=potentials(:,2:c-1);

    z=recordingDepths(2:length(recordingDepths)-1)/(10^6); % electrode spacing in meters

    h=(recordingDepths(2)-recordingDepths(1))/(10^(6)); % 90 micron
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
    
    N=length(z);
    F=zeros(N,N);

    for j=1:N
        depth=z(j);
        for i=1:N

            a=z(i)-h/2;
            b=z(i)+h/2;
            F(j,i)=quad(@(x)stepFunction(x,R,depth,sigma),a,b);

        end % for i
    end %for j

    inv_F=inv(F);
    C=potentials*inv_F;
    csdValues=C/(10^3);
    
    [r,c]=size(csdValues);
    baseLine(1:r)=0;    

    % create matrices for 3D plotting
    newDepth=recordingDepths(2:length(recordingDepths)-1);
    for x=1:r       
        plotTime(1:c,x)=t(x);
    end
    
    for x=1:c
        plotDepth(1:r,x)=newDepth(x);
    end
    
    plotTime=plotTime';
    
    figure('Name','SigMate: Raw signals and their respective CSDs using Step Inverse CSD','NumberTitle','off');
    subplot(121)
    plot3(plotTime,plotDepth,potentials.*1000)
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
    title('CSD using Step iCSD Method')
    xlabel('time [s]')
    ylabel('depth [um]')
    zlabel('amplitude [uA/mm^3]') 
    set(gca,'YGrid','on')    
    grid on
    set(gca, 'YTick', newDepth)
    set(gca, 'YTickLabel',newDepth)
    
    figure('Name','SigMate: Raw signals and their respective CSDs using Step Inverse CSD','NumberTitle','off');
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
    title('CSD using Step iCSD Method')
    cbHandle=colorbar;
    ylabel(cbHandle,'[uA/mm^3]')      
    
%     for j=1:c-2
%         figure(j)
%         subplot(2,1,1)
%         plot(t,filteredPotentialsForCSD(:,j),t,baseLine)
%         title('LFP')
%         xlabel('s')
%         ylabel('mV')
%         subplot(2,1,2)
%         plot(t,csdValues(:,j),t,baseLine)
%         title('Current Source Density using Step Inverse CSD Method')
%         xlabel('s')
%         ylabel('µA/mm^3')
%     end % for j