function removeArtifact(dataFileName, artifactFileName, dataFilePath, artifactFilePath, checkedColumns)
   
    data=load([dataFilePath, dataFileName]);
    
    artifact = load([artifactFilePath, artifactFileName]);

    t=data(:,1);
    
    newData=t; %#ok    
        
    for j=2:length(checkedColumns)

        s=data(:,j);
        artS = artifact(:,j);

        [peak,vally]=peakdet(artS,std(artS),t);

        %Removal using Peak Detection

        extPeak=extendPeaks(peak(:,2),peak(:,1),t);
        extVally=extendPeaks(vally(:,2),vally(:,1),t);
        for i=1:length(t)
            avg(i)=(extPeak(i)+extVally(i))/2; 
        end
        avg=avg';
    %     figure;
    %     hold on; plot(t,extPeak,'b',t,avg,'g',t,extVally,'r');%,plot(t,avg,'g'),plot(t,extVally,'r'),hold off
    %     hold off;
    %     title('Signal Peak, Vally and Average')
    %     h=legend('Peak','Average','Vally',3);
    %     set(h,'Interpreter','none');
        cleanS=s-avg;

        %Removal using Smoothing

    %     smArtS=smooth(artS,0.05,'loess');
    %     cleanS2=s-smArtS;
    % %     figure;
    % %     hold on; plot(t,s,'b',t,cleanS,'g',t,cleanS2,'r');%,plot(t,cleanS,'g'), plot(t,cleanS2,'r'), hold off
    % %     hold off;
    % %     title('Clean Signal with Peak Detection and Smoothing')
    % %     h=legend('Artifaced Signal','Artifact Removal with Peak Detection','Artifact Removal with Smoothing',3);
    % %     set(h,'Interpreter','none');    
    %     
    %     %Removal using fitting spline to peak Detection
    %     
    %     for i=1:length(peak(:,2))
    %         avgt(i)=(peak(i,1)+vally(i,1))/2; 
    %     end
    %     
    %     avg=[];
    %     
    %     for i=1:length(peak(:,2))
    %         avg(i)=(peak(i,2)+vally(i,2))/2; 
    %     end
    %     
    %     avg=avg';
    %     avgt=avgt';
    %     
    %     interpolatedAvg=spline(avgt,avg,t);  
    %     cleanS3=s-interpolatedAvg;
        figure('Name','SigMate: Signal With and Withour Artifact','NumberTitle','off');
    %     hold on; plot(t,s,'b',t,cleanS,'g',t,cleanS2,'r',t,cleanS3,'y');%,plot(t,cleanS,'g'), plot(t,cleanS2,'r'), hold off
        hold on; plot(t,s,'b',t,cleanS,'g');
        hold off;
        title('Clean Signal with Peak Detection')
    %     h=legend('Artifaced Signal','Artifact Removal with Peak Detection',...
    %         'Artifact Removal with Smoothing','Artifact Removal with Peak Detected Spline',4);
        h=legend('Artifaced Signal','Artifact Removal with Peak Detection',2);
        set(h,'Interpreter','none');
        
        newData=[newData, cleanS]; %#ok        
        
    end
    
    oldPath=pwd;
    cd(dataFilePath);
    fileName=[strtok(dataFileName,'.'),'-clean.txt'];
    save(fileName,'newData','-ascii','-tabs');
    cd(oldPath);