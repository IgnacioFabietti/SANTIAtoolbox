function [aicIndex,meanFSS,meanMEFSS,mean_SndSS,mean_mesurError]=processNoiseProfile(filePath, fileName, recordingType)

data=load([filePath,fileName]);
T=data(:,1);
S=data(:,2);


%% fit line of the FstSS
switch lower(recordingType)
    case 'pippette'
        [firstSSS,firstSST]=detectFSSvP(filePath,fileName);
        maxDeg=5;
    case 'transistor'
        [firstSSS,firstSST]=detectFSSvT(filePath,fileName);
        maxDeg=6;
%         firstSS=findFirstSteadyState(filePath,fileName);
%         firstSSS=firstSS(:,2);
%         firstSST=firstSS(:,1);

end
temp_P=polyfit(firstSST,firstSSS,1);
temp_Line=polyval(temp_P,firstSST);

meanFSS = mean(firstSSS);
meFSS = firstSSS - temp_Line;
meanMEFSS = mean(meFSS);

flag=1;

%% fit line of the SndSS
[sndSSS,sndSST]=findSSS(filePath,fileName, firstSSS, firstSST);

if length(sndSSS)>=length(firstSSS)
%     temp_PP=polyfit(sndSST,sndSSS,7);
%     t_Line=polyval(temp_PP,sndSST);
% 
%     difference=sndSSS-t_Line;

    x=sndSST;y=sndSSS;n=length(sndSSS);
%     long wrss;
    for i=1:maxDeg
        p=polyfit(x,y,i); 
        newy=polyval(p,x);

        residue=y-newy;
        relVar=0.1^2*y.^2;%this is of the form: sigmaSqr=alpha+beta*fitted^gamma;
        for j=1:length(relVar)
            if relVar(j)==0
                relVar(j)=1;
            end
        end
        w=1./relVar;
%         if w(1)>10e5
%             w=w.*0.000001;
%         end
        diffSqr=residue.^2;
        wrss(i)=sum(w.*diffSqr,'native');   
        aicV(i)=n*log(wrss(i))+2*i;

    %     figure;
    %     hold on;
    %     hist(residue,40);
    %     [f,xi] = ksdensity(residue); 
    %     plot(xi,f,'r');
    %     title(['measurement error distribution and estimation for:',fileName]);
    %     hold off;

    end

    aicIndex=aicV;

    %% visualization of the distribution

    % figure;
    % hold on;
    % hist(residue,40);
    % [f,xi] = ksdensity(residue); 
    % plot(xi,f,'r');
    % title(['measurement error distribution and estimation for:',fileName]);
    % hold off;

    %% mean of the SndSS
    % fileName
    mean_SndSS=mean(sndSSS);

    %% compare STD of the error with the STD of the SndSS

    std_mesurError=std(residue); % std of the difference between the SndSS e the Fit Line of the SndSS
    mean_mesurError=mean(residue);
    std_SndSS=std(sndSSS);
else
    flag=0;
    aicIndex(1:maxDeg)=Inf;
    t_Line(1:length(sndSST))=NaN;
    residue(1:length(sndSST))=NaN;
    newy(1:length(sndSST))=NaN;
end

[minAIC,minIndex]=min(aicIndex);

if flag    
    p=polyfit(sndSST,sndSSS,minIndex); 
    newy=polyval(p,sndSST);
    residue=sndSSS-newy;
end

figure('Name','SigMate: Noise Characterization','NumberTitle','off');

subplot(2,2,1:2)
hold on;
plot(T,S,'b');
xlabel('time  [s]')
ylabel('amplitude  [mV]')
plot(firstSST,firstSSS,'g',firstSST,temp_Line,'b');
plot(sndSST,sndSSS,'c',sndSST,newy, 'r')
plot(sndSST,residue,'y')
title(['signal with different calculated components for:',fileName,' fitted with model of order: ', num2str(minIndex)]);
if flag
    h = legend('real signal','first steady state','fitted line','second steady state','fitted model','residual');
    set(h,'Interpreter','none')
end
hold off;

subplot(223)
hist(residue,40);
title(['measurement error distribution for:',fileName]);
subplot(224)
if flag
    [f,xi] = ksdensity(residue); 
    plot(xi,f,'r');
end
title(['estimation of measurement error distribution for:',fileName]);

