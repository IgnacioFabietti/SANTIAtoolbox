function layerActivationOrderByCSD(latMat)
% This function calculates the avg latencies of each layer and then sorts
% them in ascending order and views the order


    depth = latMat(:,1);
    latencies = latMat(:,2);

    ind=zeros(7,1);
    
    layerILat=[];
    layerIILat=[];
    layerIIILat=[];
    layerIVLat=[];
    layerVaLat=[];
    layerVbLat=[];
    layerVILat=[];
    
    layerIDepths=[];
    layerIIDepths=[];
    layerIIIDepths=[];
    layerIVDepths=[];
    layerVaDepths=[];
    layerVbDepths=[];
    layerVIDepths=[];    
    
    for i = 1:length(depth)
        if isnan(latencies(i))
            currLat=inf;
        else
            currLat=latencies(i);
        end
        if (depth(i)<=250)
            ind(1)=ind(1)+1;
            layerILat(ind(1))=currLat;
            layerIDepths(ind(1))=depth(i);
        elseif((depth(i)>250)&& (depth(i)<=350))
            ind(2)=ind(2)+1;
            layerIILat(ind(2))=currLat;
            layerIIDepths(ind(2))=depth(i);
        elseif((depth(i)>350)&& (depth(i)<=500))
            ind(3)=ind(3)+1;
            layerIIILat(ind(3))=currLat;
            layerIIIDepths(ind(3))=depth(i);
        elseif((depth(i)>500)&& (depth(i)<=750))
            ind(4)=ind(4)+1;
            layerIVLat(ind(4))=currLat;
            layerIVDepths(ind(4))=depth(i);
        elseif((depth(i)>750)&& (depth(i)<=1200))
            ind(5)=ind(5)+1;
            layerVaLat(ind(5))=currLat;
            layerVaDepths(ind(5))=depth(i);
        elseif((depth(i)>1200)&& (depth(i)<=1475))
            ind(6)=ind(6)+1;
            layerVbLat(ind(6))=currLat;
            layerVbDepths(ind(6))=depth(i);
        elseif(depth(i)>1475)
            ind(7)=ind(7)+1;
            layerVILat(ind(7))=currLat;
            layerVIDepths(ind(7))=depth(i);
        end
    end

    avgLayeredLat=[];

    layers={'I','II','III','IV','Va','Vb','VI'};
    
    minLat=zeros(7,1);
    posLatLayers=zeros(7,1);
    
    if ~isempty(layerILat)
        minLat(1)=min(layerILat);
        posLatLayers(1) = min(layerIDepths(find(layerILat==minLat(1))));
    else
        minLat(1)=NaN;
        posLatLayers(1) = NaN;
    end
    if ~isempty(layerIILat)
        minLat(2)=min(layerIILat);
        posLatLayers(2) = min(layerIIDepths(find(layerIILat==minLat(2))));
    else
        minLat(2)=NaN;
        posLatLayers(2) = NaN;
    end    
    minLat(3)=min(layerIIILat);
    posLatLayers(3) = min(layerIIIDepths(find(layerIIILat==minLat(3))));
    minLat(4)=min(layerIVLat);
    posLatLayers(4) = min(layerIVDepths(find(layerIVLat==minLat(4))));
    minLat(5)=min(layerVaLat);
    posLatLayers(5) = min(layerVaDepths(find(layerVaLat==minLat(5))));
    minLat(6)=min(layerVbLat);
    posLatLayers(6) = min(layerVbDepths(find(layerVbLat==minLat(6))));
    minLat(7)=min(layerVILat);
    posLatLayers(7) = min(layerVIDepths(find(layerVILat==minLat(7))));

%     if ~isempty(layerILat)
%         minLat(1)=mean(layerILat);
%     else
%         minLat(1)=NaN;
%     end
%     if ~isempty(layerIILat)
%         minLat(2)=mean(layerIILat);
%     else
%         minLat(2)=NaN;
%     end    
%     minLat(3)=mean(layerIIILat);
%     minLat(4)=mean(layerIVLat);
%     minLat(5)=mean(layerVaLat);
%     minLat(6)=mean(layerVbLat);
%     minLat(7)=mean(layerVILat);
    
    minLat=[(1:1:7)', minLat];
 
    layAct=sortrows(minLat,2);

    for i=1:7
        actLayers{i}=[layers{layAct(i)}, ',', num2str(posLatLayers(layAct(i)))];
    end
    
    figure('Name','SigMate: Layer Activation Order for CSDs Calculated Using Delta Inverse CSD','NumberTitle','off');
    plot(layAct(:,2),'rO-')
    set(gca,'XTickLabel',actLayers)
    xlabel('Cortical Layers')
    ylabel('signal propagation latency [ms]')
    title('Layer Activation Order in Barrel Cortex')