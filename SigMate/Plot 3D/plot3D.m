function plot3D(fileName)

%This function plots the 3D image of the given signal

data=load(fileName);

tCol=str2double(inputdlg('Enter the Column Containing the Time'));
if (isempty(tCol))
    msgbox('No Time Input Provided, The Program Couldn''t Plot', 'Time Input Missing', 'Error');
    return;
end
dCol=str2double(inputdlg('Enter the Column Containing the Data'));
if (isempty(dCol))
    msgbox('No Data Input Provided, The Program Couldn''t Plot', 'Data Input Missing', 'Error');
    return;
end

t=data(:,tCol);
vtot=data(:,dCol);

tint=t(2)-t(1);

sn = length(vtot);

% time = linspace(0,tint*sn-tint,sn);

if((1/tint)/1000 > 1.0)
    sr=fix((1/tint)/1000)*1000; %number of samples per second descarding the data points after thousands
else
    sr=1/tint;
end

sweep_duration=str2double(inputdlg('Enter the Duration of a Sweep in S'));
if (isempty(sweep_duration))
    msgbox('Sweep Duration Not Provided, The Program Couldn''t Plot', 'Sweep Duration Input Missing', 'Error');
    return;
end

sweep_datapoints=sr*sweep_duration;

% sweeps=sn/(sr*2);

sweeps = sn/sweep_datapoints;

temp_sweep_sequence = inputdlg(['Enter the FET sequence: ', num2str(sweeps), ' FETs']);

if (isempty(temp_sweep_sequence))
    msgbox('Sweep/FET Sequence Not Provided, The Program Will Assume Ascending Sweep Orders', 'Sweep Sequence Input Missing', 'Warning');
    sweep_sequence=1:1:sweeps;
else
    sweep_sequence =str2num(temp_sweep_sequence{1});     %#ok<ST2NM>
end

h=waitbar(0,'Please Wait... Performing Calculations for Plotting Data');

newData=[];
if(sweeps>1)
    dataIndex=sortrows(sweep_sequence')'; %sort the sequence to map to the stored data index
    for i = 1 : 1 : sweeps % reallocate the sweep data points based on the entered fet sequence
            for j=1:1:sweeps 
                if dataIndex(i)==sweep_sequence(j) 
                    newData=[newData;data((sweep_datapoints*(i-1))+1:sweep_datapoints*i,:)]; %#ok
                end
            end
        waitbar(i/sweeps);
    end
    for i = 1 : 1 : sweeps    %sub divide the data matrix based on the sequence for 3D plotting
        if (i==1)
            t=newData(1:sweep_datapoints,tCol);
            v=newData(1:sweep_datapoints,dCol);
            y=ones(sweep_datapoints, i);
        else
            t=[t,newData(((i-1)*sweep_datapoints+1):i*sweep_datapoints,tCol)];%#ok
            v=[v,newData(((i-1)*sweep_datapoints+1):i*sweep_datapoints,dCol)];%#ok
            y=[y,ones(sweep_datapoints,1).*sweep_sequence(i)];%#ok
        end
    end
    close(h);
    mesh(t,y,v);

    colorbar();

    rotate3d on;

    xlabel('X - Time (S)');
    ylabel('Y - Number of Sweeps/FETS');
    set(gca,'ytick',1:1:sweeps);
    set(gca,'yticklabel',sweep_sequence);    
    zlabel('Z - Amplitude (mV)');
    axis('tight')
    

else
    errordlg('You cannot view the 3D of a single sweep data')    
end
clear all;

