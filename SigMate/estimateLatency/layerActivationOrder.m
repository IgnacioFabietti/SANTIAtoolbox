function layerActivationOrder(latencies, depth)
% This function calculates the avg latencies of each layer and then sorts
% them in ascending order and views the order


    avgLat=zeros(7,1);
    ind=zeros(7,1);
    for i = 1:length(depth)
        if isnan(latencies(i))
            currLat=0;
        else
            currLat=latencies(i);
        end
        if (depth(i)<=250)
            avgLat(1)=avgLat(1)+currLat;
            ind(1)=ind(1)+1;
        elseif((depth(i)>250)&& (depth(i)<=350))
            avgLat(2)=avgLat(2)+currLat;
            ind(2)=ind(2)+1;
        elseif((depth(i)>350)&& (depth(i)<=500))
            avgLat(3)=avgLat(3)+currLat;
            ind(3)=ind(3)+1;
        elseif((depth(i)>500)&& (depth(i)<=750))
            avgLat(4)=avgLat(4)+currLat;
            ind(4)=ind(4)+1;
        elseif((depth(i)>750)&& (depth(i)<=1200))
            avgLat(5)=avgLat(5)+currLat;
            ind(5)=ind(5)+1;
        elseif((depth(i)>1200)&& (depth(i)<=1475))
            avgLat(6)=avgLat(6)+currLat;
            ind(6)=ind(6)+1;
        elseif(depth(i)>1475)
            avgLat(7)=avgLat(7)+currLat;        
            ind(7)=ind(7)+1;
        end
    end

    avgLayeredLat=[];

    layers={'I','II','III','IV','Va','Vb','VI'};
    
    for i=1:7
        avgLayeredLat=[avgLayeredLat; i, avgLat(i)/ind(i)];
    end
 
    layAct=sortrows(avgLayeredLat,2);

    for i=1:7
        actLayers{i}=layers{layAct(i)};
    end
    
    figure, plot(layAct(:,2),'rO-')
    set(gca,'XTickLabel',actLayers)
    xlabel('Cortical Layers')
    ylabel('signal propagation latency [ms]')
    title('Layer Activation Order in Barrel Cortex')