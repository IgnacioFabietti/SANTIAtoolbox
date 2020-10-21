function [latencies]=calculateLatenciesInCSD(depth, csdValues, stimOnset, t)
% This function valculates the depthwise latencies from the stimulus onset
% in the csd values in order to find out the layer activation order in the
% cortex.
% Inputs:
%           depth    : recording depths (should be equispaced recordings)
%           csdValues: calculated csd values for each depth
%           stimOnset: the stimulus onset
%           t        : the time instance of the recordings
% Output:
%           latencies: a two column matrix containing the depth in the
%           first column and the respected latencies from the stimulus
%           onset in the other column.

    format long;
    
    if t(end)>1 % if the time is in millisecond
    
        Fs = 0.001/(t(2)-t(1)); % sampling frequency per ms
        preStimDP = round((stimOnset+2)*Fs); % points in each ms
        pointsToConsider = round(50*Fs); % the source/sink usually occurs 
                                   % within 200 ms from the stimulus onset
    else % if the time is in second
        stimOnset = stimOnset/1000;
        Fs = 1/(t(2)-t(1)); % sampling frequency per ms
        preStimDP = round((stimOnset+0.002)*Fs); % points in each ms
        pointsToConsider = round(0.050*Fs); % the source/sink usually occurs 
                                   % within 200 ms from the stimulus onset
    end
    
    latencies = [];
    
    for i = 1:length(depth)
        csd = csdValues(:,i);
        respPart = csd(preStimDP+1:preStimDP+pointsToConsider);
        
        respMax = max(respPart);
        posMax = find(respPart==respMax);
        latMax = t(preStimDP+1+posMax);
        
        respMin = min(respPart);
        posMin = find(respPart==respMin);
        latMin = t(preStimDP+1+posMin);        

        % disable for pipette data
        latencies = [latencies; depth(i) (latMax-stimOnset)*1000];        
        
        % enable for pipette data
%         if respMax >= abs(respMin) * 2
%             latMin=NaN;
%             latencies = [latencies; depth(i) (latMin-stimOnset*0.001)*1000];
%         else
%             latencies = [latencies; depth(i) (latMin-stimOnset*0.001)*1000];
% %             latencies = [latencies; depth(i) (latMax-stimOnset*0.001)*1000];
%         end
    end