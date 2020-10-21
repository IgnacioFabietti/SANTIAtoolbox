function findSteadyState(filePath,fileNames)
    
    N=length(fileNames);
    
     allFirstParts=[];
     fpMaxLength=0;
     fpMaxLengthErr=0;
     meanFP=[];
   %  stdMEFP=[];
     
%      medianFP=[];
%      varianceFP=[];
     
     meanMEFP=[];
     
     meanME=[];
     medianME=[];
     stdME=[];
     
     allMEFirstParts=[];
     
    for z=1:N

        data=load([filePath,fileNames{z}]);
        s=data(:,2);
        t=data(:,1);
        firstSteadyState=findFirstSteadyState(t,s);
        
        firstPart=firstSteadyState(:,2);
        firstPartT=firstSteadyState(:,1);
        
        %adjust and save the first parts for averaging
        
         tempFirstPart=firstPart;
         
         fpLength = length(tempFirstPart);
         
         if(fpLength>fpMaxLength)
             fpMaxLength=fpLength;
             if(~isempty(allFirstParts))
                 tempArray=[];
                 for x=1: length(allFirstParts(1,:))                 
                     tempArrayPart=allFirstParts(:,x);
                     tempLength = length(tempArrayPart);
                     tempArrayPart(tempLength+1:fpMaxLength)=0;
                     tempArray=[tempArray, tempArrayPart];
                 end
                 allFirstParts=tempArray;
                 % add current firstPart to allFirstParts                 
                 allFirstParts=[allFirstParts,tempFirstPart];
             else
                 %add current firstPart to allFirstParts
                 allFirstParts=[allFirstParts,tempFirstPart]; 
             end
         else
             tempFirstPart(fpLength+1:fpMaxLength)=0;
             allFirstParts=[allFirstParts,tempFirstPart];              
         end   
                
        
        interval=length(firstPart);
        
        stdFirst= std(firstPart);
        stdF2=std(firstPart)*2;
        
        stdFirstUp=[];
        stdFirstDown=[];
        
%         stdFirstUp(1:length(firstPart))= std(firstPart);
%         stdFirstDown(1:length(firstPart))= -std(firstPart);

        ll= length(firstPart);

%          ampl1=max(firstPart)-min(firstPart);
%          avg1=ampl1/2;
%          fC1=min(firstPart);
         fittCurve1=[];
%   
%   
%          for k= 1:ll
%   
%              fittCurve1(k)=fC1+avg1;
%   
%          end

%          p=polyfit(firstPartT,firstPart,1);
%          fittCurve1=polyval(p,firstPartT);        
        
        fittCurve1(1:length(firstPart))=mean(firstPart);
        stdFirstUp(1:length(firstPart))=fittCurve1+stdF2;
        stdFirstDown(1:length(firstPart))=fittCurve1-stdF2;
        newFirstPart=[];
        
        for o=1:length(firstPart)
            if(firstPart(o)>stdFirstUp(o))
                newFirstPart(o)=stdFirstUp(o);
            elseif(firstPart(o)<stdFirstDown(o))
                newFirstPart(o)=stdFirstDown(o);
            else 
                newFirstPart(o)=firstPart(o);
             end
        end


        %  FITT THE FIRST PART WITH A STRAIGHT LINE




        %fittCurve1=[];
        

        % MEASUREMENT ERROR OF THE FIRSTPART
        
        
        err1=[];

        for j=1:ll
            err1(j)=newFirstPart(j)-fittCurve1(j);
        end
          
%         newFirstPart=newFirstPart';
        meanMEFP(z)=mean(err1);
      %  stdMEFP(z)= std(err1)
        
        
         tempErr=err1';
         
         fpLengthErr = length(tempErr);
         
         if(fpLengthErr>fpMaxLengthErr)
             fpMaxLengthErr=fpLengthErr;
             if(~isempty(allMEFirstParts))
                
                 tempArray=[];
                 for x=1: length(allMEFirstParts(1,:))                 
                     tempArrayPart=allMEFirstParts(:,x);
                     tempLength = length(tempArrayPart);
                     tempArrayPart(tempLength+1:fpMaxLength)=0;
                     tempArray=[tempArray, tempArrayPart];
                 end
                 allMEFirstParts=tempArray;
                 % add current firstPart to allFirstParts                 
                 allMEFirstParts=[allMEFirstParts,tempErr];
             else
                 %add current firstPart to allFirstParts
                 allMEFirstParts=[allMEFirstParts,tempErr]; 
             end
         else
             tempErr(fpLengthErr+1:fpMaxLengthErr)=0;
             allMEFirstParts=[allMEFirstParts,tempErr];              
         end           


         
        % The signal Matching starts from here!
        flag=1;

        newPart=[];
        newPartT=[];

        tempS=s;
        tempST=t;
        
        while(flag)
            lengthS=length(tempS);
            loops=round(lengthS/interval);
            parts=[];
            partsT=[];
            tempParts=[];
            tempPartsT=[];
            if loops == 1
                mssg = ['The input file: ', fileNames{z},' is a baseline file'];
                msgbox(mssg,'Baseline File Detected','Help');
                newPart=tempS;
                newPartT=tempST;
                break;
            end
            for i=1:loops-1    
               parts=[parts, tempS(lengthS-(interval*i)+1:lengthS-(interval*(i-1)))];
               partsT = [partsT, tempST(lengthS-(interval*i)+1:lengthS-(interval*(i-1)))];
               tempParts=[tempParts;parts(:,i)];
               tempPartsT=[tempPartsT;partsT(:,i)];
            end


            tempP=[tempPartsT,tempParts];
            
            sortedParts=sortrows(tempP,1);
            
            tempParts=sortedParts(:,2);
            tempPartsT=sortedParts(:,1);
            
            parts=reshape(tempParts,interval,loops-1);
            partsT=reshape(tempPartsT,interval,loops-1);

            newPart=[newPart;parts(:,loops-1)];
            newPartT=[newPartT;partsT(:,loops-1)];
            
            for m=loops-2:-1:1
               if std(parts(:,m)) < stdFirst
                   newPart = [newPart; parts(:,m)];
                   newPartT = [newPartT; partsT(:,m)];
               else
                   break;
               end
            end

            n=length(tempS);
            m=length(newPart);
            l=n-m;
            tempS = tempS(1:l);
            tempST = tempST(1:l);

            if(stdFirst < std(newPart))
                flag=0;
                tempPart=[newPartT,newPart];
                sortedNewPart=sortrows(tempPart,1);
                newPart=sortedNewPart(:,2);
                newPartT=sortedNewPart(:,1);
            end
        end


        %<><>
        % MEAN,MEDIAM,VARIANCE FOR EACH FIRST PART AND PLOT THEM
        
        meanFP(z)= mean(firstPart);
       % stdFP(z)= std(firstPart)
%         mediandFP(z)= median(firstPart);
%         varianceFP(z)= var(firstPart);

        %FITTING THE DATA WITH A STRAIGHT LINE

        p= length(newPart);

        dataToFitt=newPart;
        dataToFittT=newPartT;

        ampl=max(dataToFitt)-min(dataToFitt);
        avg=ampl/2;
        fC=min(dataToFitt);
        fittCurve=[];


        for k= 1:p %length(s)-start

            fittCurve(k)=fC+avg; %#ok<AGROW>

        end

        % BREAKPOINT

        interval3=50;
        lengthS3=length(dataToFitt);

        loops=round(lengthS3/interval3);

        parts3=[];
        partsT3=[];

        for i=0:loops-2
            parts3=[parts3, dataToFitt((interval3*i)+1:(interval3*(i+1)))];
            partsT3 = [partsT3, dataToFittT((interval3*i)+1:(interval3*(i+1)))];                

        end

        matchPoint=0;

        fittedMean=fittCurve(1);

        for m=0:loops-3   % comparison
            meanNewPart=mean(parts3(:,m+1));
               if abs((abs(meanNewPart)-fittedMean)) < 0.0005
                    matchPoint=m+1;
                    break;
               end
        end

        if matchPoint==0
            for m=0:loops-3   % comparison
                meanNewPart=mean(parts3(:,m+1));
                   if abs((abs(meanNewPart)-fittedMean)) < 0.009
                        matchPoint=m+1;
                        break;
                   end
            end            
        end
        if (matchPoint==0)
            dlgString = ['the matching criteria, did not find a match for the file: ',fileNames{z}];
            errordlg(dlgString,'Matching Error');
            continue;
        end

        % MEASUREMENT ERROR

         err=[];

        for i=1:p
             err(i)=dataToFitt(i)-fittCurve(i);
        end
         
         
%          [f,xi]=ksdensity(err);
         
         meanME(z)=mean(err);
         medianME(z)=median(err);
         stdME(z)=std(err);

         %Plot the signal, it's first part, matched part and their
         %respective fitted lines
         
        figure;
        hold on;
        plot(t,s,'r')
        plot(firstPartT,firstPart,'g')
        %plot(newPartT,newPart,'b');
        plot(firstPartT,fittCurve1','y');
      %  plot(dataToFittT,fittCurve','y');
        plot(firstPartT, stdFirstUp,'m');
        plot(firstPartT, stdFirstDown,'m');
        hold off;
        title({'Red=Real Signal,  Green= Recognized First Part of the Signal';
            ['yellow= fittcurves: ',fileNames{z}]});
        xlabel('time: ms');
        ylabel('amplitude: mV');
        
        [f,xi]=ksdensity(firstPart);
        
        figure;
        hold on;
        hist(firstPart,40)
        plot(xi,f,'g');
        hold off;
        title(['histogram of the first part with its distribution(green) for: ',fileNames{z}]);
        xlabel('time: ms');
        ylabel('amplitude: mV');         
         
    end

%%    
    
    %Averaging the first part of the signals
    timeLimit=0.037*20000;
    for k=1:length(allFirstParts(:,1))
        firstPartAvg(k) = sum(allFirstParts(k,:))/length(allFirstParts(k,:)); 
    end

    firstPartAvg=firstPartAvg(1:timeLimit)';
    
    %MEAN,MEDIAN,VARIANCE OF THE AVERAGED FIRST PART
    
    meanAvgFP= mean(firstPartAvg);
   % stdAvgFP= std(firstPartAvg)
%     mdnAvg= median(firstPartAvg);
%     varAvg= var(firstPartAvg);
    
    %  FITT THE AVERAGE WITH A STRAIGHT LINE


% % % % % % % % %     ampl2=max(firstPartAvg)-min(firstPartAvg);
% % % % % % % % %     avg2=ampl2/2;
% % % % % % % % %     fC2=min(firstPartAvg);
    fittCurve2=[];


    for k= 1:timeLimit%fpMaxLength

        fittCurve2(k)=mean(firstPartAvg);

    end

% MEASUREMENT ERROR OF THE AVERAGE

    err2=[];

    for j=1:timeLimit%fpMaxLength
        err2(j)=firstPartAvg(j)-fittCurve2(j);
    end

   %averaging the measurement errors of the first part of the signals
    
    for k=1:timeLimit%length(allMEFirstParts(:,1))
        firstPartAvgME(k) = sum(allMEFirstParts(k,:))/length(allMEFirstParts(k,:)); 
    end
     
    meanAvgFPME=mean(firstPartAvgME);
%     medianAvgME=median(firstPartAvgME);
%      stdAvgME=std(firstPartAvgME);
    
    figure;
    hold on;
    plot(t(1:timeLimit),firstPartAvg,'g');
    plot(t(1:timeLimit),firstPartAvgME,'b');
    hold off;
    title('the averaged first parts and the averaged measurement error and their means');
    xlabel('time(ms)');
    ylabel('amplitude(mv)');
    h=legend('Averaged First Steady-State','Averaged Measurement Error',2);
    set(h,'Interpreter','none');    
    
    [f,xi]=ksdensity(firstPartAvgME);
    
    figure;
    hold on;
    hist(firstPartAvgME,40)
    plot(xi,f,'g');
    hold off
    title('histogram of the averaged measurement error and its distribution');
    xlabel('time: ms');
    ylabel('amplitude: mV');
    
    %HIST AVERAGED FIRST PARTS
        
        
    [f,xi]=ksdensity(firstPartAvg);

    figure;
    hold on;
    hist(firstPartAvg,40)
    plot(xi,f,'g');
    hold off;
    title('histogram of the averaged first parts and its distribution');
    xlabel('time: ms');
    ylabel('amplitude: mV');

    
    
    meansSS=[(meanFP(:)),(meanMEFP(:))];
    xbar=(1:1:(length(meansSS(:,1))));
%     xbar=[xbar,xbar];

    figure;
    bar(xbar,meansSS);
    title('Means of the Steady State and Means of their Respective Measurement Errors');
    h=legend('Mean of Steady States','Mean of Measurement Error',2);
    set(h,'Interpreter','none');
    set(gca,'XTick',(1:1:length(fileNames)));
    set(gca,'XTickLabel',fileNames)    
    
    averagedMeans=[(meanAvgFP),(meanAvgFPME)];
    xbar=(1:1:(length(averagedMeans(1,:))));
    
    figure;
    bar(xbar,averagedMeans);
    title('Mean of Averaged Steady State and Mean of Its Measurement Errors');
    set(gca,'XTickLabel',{'Steady State','Measurement Error'})    
    
    %mean of means of the first steady state and their measurement errors 

    meanMeans = [(mean(meanFP)),(mean(meanMEFP))];
    xbar=(1:1:(length(averagedMeans(1,:))));
    
    figure;
    bar(xbar,meanMeans);
    title('Mean of means of Averaged Steady State and their Measurement Errors');
    set(gca,'XTickLabel',{'Steady State','Measurement Error'})    
    
   