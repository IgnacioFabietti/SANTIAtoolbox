function [sigma, csdValues, lfp, t]=standardCSDSS (directoryPath, fileNames, recordingDepths, sigma, checkedColumns, stimOnset)
% this function applies the current source density analysis to the filtered
% (lowpass - from 0.1 to 500 Hz) potential signals contained in the columns
% of the matrix "filteredPotentialsForCSD". Sigma is the conductivity and h
% [micron] is the interspace between two recording positions

    [filteredPotentialsForCSD, t] = filterSignalsForCSD(directoryPath, fileNames, checkedColumns, stimOnset);

    if isnan(sigma)
        sigma=0.42; % S/m
    end
    
    h=recordingDepths(2)-recordingDepths(1); %micrometers

    den=((h*(10^(-6)))^2); % convertion in meters
    [r,c]=size(filteredPotentialsForCSD);
    M=zeros(r,c-2);
%     pot=zeros(r,c-2);

%     for j=2:(c-1)
%         pot(:,j-1)=0.23*filteredPotentialsForCSD(:,j+1)+0.54*filteredPotentialsForCSD(:,j)+0.23*filteredPotentialsForCSD(:,j-1); % 3 point hamming filter
%     end

%     for j=2:(c-3)
    der2=((filteredPotentialsForCSD(:,3) - 2*filteredPotentialsForCSD(:,2) + filteredPotentialsForCSD(:,1))/1000)/den; % I divide for 1000 because I convert in V
    csd1=-1*der2*sigma;
    csd=csd1/(10^3); % expressed as microA/mm3
    csdValues(:,1)=csd;
    
    lfp=filteredPotentialsForCSD(:,2);
%     end
    
%     [r,c]=size(csdValues);
%     baseLine(1:r)=0;
    
    % create matrices for 3D plotting
    

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
