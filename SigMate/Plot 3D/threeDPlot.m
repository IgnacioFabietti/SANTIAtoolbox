function threeDPlot(directoryPath, fileList, checkedColumns)

%This function plots the 3D image of the given signal

    if(length(fileList)>1)
        try
            h=waitbar(0,'Please Wait... Performing Calculations for Plotting Data');
            t=[];
            v=[];
            y=[];
            for index = 1 : length(fileList)
                data=load([directoryPath, fileList{index}]);

                tCol = checkedColumns(1);
                dCol = checkedColumns(2);
                time=data(:,tCol);
                vtot=data(:,dCol);

    %             tint=t(2)-t(1);
    % 
                sn = length(vtot);


    %             sweep_duration = tint * sn;

    %             sweeps = length (fileList);

                t = [t,time]; 
                v = [v, vtot]; 
                y = [y,ones(sn,1)*index];

                waitbar(index/length(fileList));
            end

            close(h);
            figure('Name','SigMate: 3D Mapping Plot of Data Files','NumberTitle','Off');            
            mesh(t,y,v);

            colorbar();

            rotate3d on;

            xlabel('Time (S)');
            ylabel('Stimulating Frequency');
            set(gca,'ytick',1:1:length(fileList));
            for i=1:length(fileList)
                sweep_sequence{i}=strtok(fileList{i},'.'); %#ok<AGROW>
            end

            set(gca,'yticklabel',sweep_sequence);      
            zlabel('Amplitude (V)');
            axis('tight')        
            clear all;
        catch %#ok
            close(h);            
            errordlg(['There was Problem Reading the File: ',fileList{index}],'Data Reading Error');
        end
    else
        errordlg('With the Selected File, You cannot view the 3D Map!');
    end
        
        
            
