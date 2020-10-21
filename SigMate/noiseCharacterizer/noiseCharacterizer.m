function varargout = noiseCharacterizer(varargin)
% NOISECHARACTERIZER M-file for noiseCharacterizer.fig
%      NOISECHARACTERIZER, by itself, creates a new NOISECHARACTERIZER or raises the existing
%      singleton*.
%
%      H = NOISECHARACTERIZER returns the handle to a new NOISECHARACTERIZER or the handle to
%      the existing singleton*.
%
%      NOISECHARACTERIZER('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in NOISECHARACTERIZER.M with the given input arguments.
%
%      NOISECHARACTERIZER('Property','Value',...) creates a new NOISECHARACTERIZER or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before FirstGUI_OpeningFunction gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to noiseCharacterizer_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help noiseCharacterizer

% Last Modified by GUIDE v2.5 04-May-2012 18:22:23

% Begin initialization code - DO NOT EDIT


gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @noiseCharacterizer_OpeningFcn, ...
                   'gui_OutputFcn',  @noiseCharacterizer_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT

%%

% --- Executes just before noiseCharacterizer is made visible.
function noiseCharacterizer_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to noiseCharacterizer (see VARARGIN)

% Choose default command line output for noiseCharacterizer
handles.output = hObject;

set(handles.figncMain, 'CloseRequestFcn', 'closeGUI');

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes noiseCharacterizer wait for user response (see UIRESUME)
% uiwait(handles.figncMain);

%%

% --- Outputs from this function are returned to the command line.
function varargout = noiseCharacterizer_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;

%%

% --- Executes on button press in btnClose.
function btnClose_Callback(hObject, eventdata, handles)
% hObject    handle to btnClose (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

    closeGUI(); % Call the function from the CloseGUI.m file


%%


% --- Executes on button press in btnncBrowse.
function btnncBrowse_Callback(hObject, eventdata, handles)
% hObject    handle to btnncBrowse (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
    
%     global filelist, filenames
    
    %clear if any application data exists
    
    fh = findobj('Tag', 'figncMain');    
    if(isappdata(fh,'averaged_time'))
        rmappdata(fh,'averaged_time');
    end
    if(isappdata(fh,'averaged_data'))
        rmappdata(fh,'averaged_data');
    end  
    
    if (isappdata(fh, 'directoryPath'))
        browseDir = getappdata(fh, 'directoryPath');
        path = uigetdir(browseDir,'Select a Directory'); %Select the directory and store the path at folder 
    else
        path = uigetdir([pwd '\'],'Select a Directory'); %Select the directory and store the path at folder        
    end
    
%     path = uigetdir('D:\MatlabWorks','Select a Directory'); %Select the directory and store the path at folder 
    
    if(path) % if a directory is selected
        
        setappdata(fh, 'directoryPath', strcat(path,'\'));
        handle_lblncPath = findobj('Tag', 'lblncPath'); % find the object with the Tag lblncPath and store the reference handle

        if (handle_lblncPath ~= 0) % if the above searched object found
            text = get(handle_lblncPath,'String');  % get the text of the object
            if(~(strcmp(text,'Selected Directory Path')))
                text = 'Selected Directory Path';
            end
            newtext = strcat(text, ': ', path); % append the folder path to the content
            set(handle_lblncPath,'String',newtext); % set the new text to the control
        end

        newpath = strcat(regexprep(path,'\','/'),'/*.txt'); %replace the path with a forward slash '/'instead of a backward slash and add the file type

        dir_struct = dir(newpath);
        [file_names,file_index] = sortrows({dir_struct.name}');
        handles.file_names = file_names;
        handles.is_dir = [dir_struct.isdir];
        handles.file_index = file_index;
        guidata(hObject,handles);
        setappdata(fh,'fileNames',file_names);
        set(findobj('Tag','lstboxncContent'),'String',handles.file_names,...
            'Value',1);
        set(findobj('Tag','btnncLoad'),'Enable', 'On');
        set(findobj('Tag','btnncLoad'),'String', 'Load Data Files');        
        set(findobj('Tag','btnncRemoveFile'),'Enable', 'On');
        set(findobj('Tag','btnncMoveUp'),'Enable', 'On');
        set(findobj('Tag','btnncMoveDown'),'Enable', 'On');        
        set(findobj('Tag','chkboxncIm'),'Enable', 'On');
        set(findobj('Tag','chkboxncVm'),'Enable', 'On');
        set(findobj('Tag','chkboxncStimulus'),'Enable', 'On');
        set(findobj('Tag','chkboxncVj'),'Enable', 'On');
        set(findobj('Tag','chkboxncVavg'),'Enable', 'On');

    else %if the directory selection dialog is cancelled
        
        msgbox('Please Select a Directory for Analysis', 'Directory Not Selected','Error');
    end

    listbox_contents = get(findobj('Tag', 'lstboxncContent'), 'String');
    selected_index = get(findobj('Tag', 'lstboxncContent'), 'Value');    
    if(selected_index == 1)
        set(findobj('Tag','btnncMoveUp'),'Enable', 'Off');
    elseif(selected_index == length(listbox_contents))
        set(findobj('Tag','btnncMoveDown'),'Enable', 'Off');        
    end


%%


% --- Executes on selection change in lstboxncContent.
function lstboxncContent_Callback(hObject, eventdata, handles)
% hObject    handle to lstboxncContent (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = get(hObject,'String') returns lstboxncContent contents as cell array
%        contents{get(hObject,'Value')} returns selected item from lstboxncContent

    listbox_contents = get(findobj('Tag', 'lstboxncContent'), 'String');
    selected_index = get(findobj('Tag', 'lstboxncContent'), 'Value');
    fh = findobj('Tag','figncMain');
    
    if(selected_index == 1)
        set(findobj('Tag','btnncMoveUp'),'Enable', 'Off');
        set(findobj('Tag','btnncMoveDown'),'Enable', 'On');        
    else
        set(findobj('Tag','btnncMoveUp'),'Enable', 'On');        
    end    

    if(selected_index == length(listbox_contents))
        set(findobj('Tag','btnncMoveDown'),'Enable', 'Off');
        set(findobj('Tag','btnncMoveUp'),'Enable', 'On');
    else
        set(findobj('Tag','btnncMoveDown'),'Enable', 'On');        
    end
    
    [checkedColumns, flag] = selectedColumns();
%     checkedColumns = getappdata(fh, 'checkedColumns');
    
    if(flag)       
        filePath = getappdata(fh, 'directoryPath');
        [fet_time, fet_data] = readData(filePath, listbox_contents{selected_index}, checkedColumns);
        color = {'r','g','b','c','m','y','k'};        
        cla(findobj('Tag','axncMain'));
%         axes(findobj('Tag','axncMain'));
        columns = length(checkedColumns);
        hold on
        for i=1:1:columns-1
%             subplot(columns-1,1,i);
            plot(fet_time, fet_data(:,i),color{i});
            title(['Plot of Selected Column: ',num2str(i)]);
        end
        axis('tight');
        hold off
        
        if (isequal(getappdata(fh,'signalType'),2))
            recType='pippette';
        elseif (isequal(getappdata(fh,'signalType'),3))
            recType='transistor';
        end
        aicIndex=processNoise(filePath,listbox_contents{selected_index},recType);
%         findSteadyState(filePath,listbox_contents);
    end
    
    
    
    
%     plotData(handles.fet_time, handles.fet_data,handles.axncMain, ['Selected FET Recording of ',listbox_contents{selected_index}], handles);
    


%%

% --- Executes during object creation, after setting all properties.
function lstboxncContent_CreateFcn(hObject, eventdata, handles)
% hObject    handle to lstboxncContent (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



%%

%%

function plotData(axesName, plotTitle, handles)
%     cla(axesName);
% 
%     axes(axesName);
    

    grid on
    color = {'r','g','b','c','m','y','k'};     
    checkedColumns = getappdata(handles, 'checkedColumns'); % get the columns which are checked
    if(strcmp(plotTitle,'Average of FET Recordings'))

        figure('Name','SigMate: Average of FET Recordings','NumberTitle','off');        
        title(plotTitle);
        time = getappdata(handles, 'averaged_time');
        data = getappdata(handles, 'averaged_data');
        if (getappdata(handles, 'signalType')==2)        
            for i = 1:1:length(checkedColumns)-1
                if(checkedColumns(i+1)==2)
                    subplot(length(checkedColumns)-1,1,i);
                    plot(time,data(:,i),color{i});
                    title('Plot for VmAC');
                    xlabel('Time (S)');
                    ylabel('V (mV)');
                elseif(checkedColumns(i+1)==3)
                    subplot(length(checkedColumns)-1,1,i);
                    plot(time,data(:,i),color{i});
                    title('Plot for VmDC');
                    xlabel('Time (S)');
                    ylabel('V (mV)');                    
                elseif(checkedColumns(i+1)==4)
                    subplot(length(checkedColumns)-1,1,i);
                    plot(time,data(:,i),color{i});            
                    title('Plot for Stimulus');
                    xlabel('Time (S)');
                    ylabel('V (mV)');                    
                end
            end
        elseif (getappdata(handles, 'signalType')==3)
           for i = 1:1:length(checkedColumns)-1
                if(checkedColumns(i+1)==2)
                    subplot(length(checkedColumns)-1,1,i);
                    plot(time,data(:,i),color{i});
                    title('Plot for Im');
                    xlabel('Time (S)');
                    ylabel('I (mA)');                    
                elseif(checkedColumns(i+1)==3)
                    subplot(length(checkedColumns)-1,1,i);
                    plot(time,data(:,i),color{i});
                    title('Plot for Vm');
                    xlabel('Time (S)');
                    ylabel('V (mV)');                    
                elseif(checkedColumns(i+1)==4)
                    subplot(length(checkedColumns)-1,1,i);
                    plot(time,data(:,i),color{i});          
                    title('Plot for FET');
                    xlabel('Time (S)');
                    ylabel('V (mV)');                    
                elseif(checkedColumns(i+1)==5)
                    subplot(length(checkedColumns)-1,1,i);
                    plot(time,data(:,i),color{i});            
                    title('Plot for Vavg');
                    xlabel('Time (S)');
                    ylabel('V (mV)');                    
                end
            end            
        end
        axis('tight');
        grid on;
        
    elseif(strcmp(plotTitle,'Estimated Noise in the Recordings'))
        time = getappdata(handles, 'averaged_time');
        data = getappdata(handles, 'averaged_data');      
        estimatedNoise = getappdata(handles, 'noiseEstimation');
        noiselessAveragedData = getappdata(handles,'noiselessAveragedData');
        figure('Name','SigMate: Estimated Noise in the Recordings','NumberTitle','off');
        for i=1:1:length(checkedColumns)-1
            subplot((length(checkedColumns)-1)*3,1,(i*3)-2);
            plot(time,data(:,i),color{i});          
            title(['Plot of Averaged Signal for FET Recordings for Channel', num2str(i)]);
            xlabel('Time (S)');
            ylabel('V (mV)');
            subplot((length(checkedColumns)-1)*3,1,(i*3)-1);
            plot(time(1:2:length(time)),estimatedNoise(:,i),color{i});
            title(['Noise Estimation for the Channel ', num2str(i)]);
            xlabel('Time (S)');
            ylabel('V (mV)');
            subplot((length(checkedColumns)-1)*3,1,(i*3));
            plot(time,noiselessAveragedData(:,i),color{i});
            title(['Averaged Signal after Noise Subtraction for the Channel ', num2str(i)]);
            xlabel('Time (S)');
            ylabel('V (mV)');              
        end
        axis('tight');
        grid on;
                       
    end



%%

% --- Executes on button press in btnncCharacterizeNoise.
function btnncCharacterizeNoise_Callback(hObject, eventdata, handles)
% hObject    handle to btnncCharacterizeNoise (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

    figure_handle = findobj('Tag', 'figncMain');
    
    listbox_contents = get(findobj('Tag', 'lstboxncContent'), 'String');
    
%     directoryPath = getappdata(figure_handle, 'directoryPath');
%     
%     for i = 1:length(listbox_contents)
%         fullPath = [directoryPath, listbox_contents];
%         
%         
%     end
%     
    
%     fh = findobj('Tag', 'figncMain');
%         
%     if((~isappdata(fh,'averaged_odd_data'))&&(~isappdata(fh,'averaged_even_data')))
% 
%         time = getappdata(fh, 'fet_time');    
%         data = getappdata(fh, 'fet_data');
%         processData(time, data, 'Average');
%     end
% 
% %     averaged_time = getappdata(fh, 'averaged_time');
%     evenData = getappdata(fh, 'averaged_even_data');
%     oddData = getappdata(fh, 'averaged_odd_data');
%     averagedData = getappdata(fh,'averaged_data');
%     averagedTime = getappdata(fh,'averaged_time');    
%     
%     noiseEstimation = evenData-oddData;
%     
%     setappdata(fh,'noiseEstimation',noiseEstimation);
% 
% 
%     j=1;
%     for i = 1:2:length(averagedData)
%         averagedData(i)= averagedData(i)-noiseEstimation(j); 
%         j=j+1; 
%     end
%     j=1;    
%     for i = 2:2:length(averagedData)
%         averagedData(i)= averagedData(i)-noiseEstimation(j); 
%         j=j+1; 
%     end    
%     
%     setappdata(fh,'noiselessAveragedData',averagedData);
%     
%     directoryPath=getappdata(fh,'directoryPath');
%     oldPath=pwd;
%     cd(directoryPath);
%     datafile=[];
%     dataFile = [averagedTime, averagedData];
%     save('NoiselessAveragedData.txt', 'dataFile','-ASCII','-tabs');
%     cd(oldPath);
%     
%     plotData(findobj('Tag','axncMain'),'Estimated Noise in the Recordings', fh);

%%

% --- Executes on button press in btnncLoad.
function btnncLoad_Callback(hObject, eventdata, handles)
% hObject    handle to btnncLoad (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

    figure_handle = findobj('Tag', 'figncMain');
    
    listbox_contents = get(findobj('Tag', 'lstboxncContent'), 'String');    
    
    [checkedColumns, flag]=selectedColumns();
    
    if(flag) %if proper signal source and channels are selected

        [fet_time, fet_data, samplingFreq, dataPoints] = loadData(listbox_contents, getappdata(figure_handle,'directoryPath'),checkedColumns);

        setappdata(figure_handle, 'fet_time', fet_time);
        setappdata(figure_handle, 'fet_data', fet_data);        
        setappdata(figure_handle, 'samplingFreq', samplingFreq);
        setappdata(figure_handle, 'dataPoints', dataPoints);        

        set(findobj('Tag','btnncLoad'),'String', 'Data Files Loaded');
        set(findobj('Tag','btnncLoad'),'Enable', 'Off');
        set(findobj('Tag','btnncCharacterizeNoise'),'Enable', 'On');
        set(findobj('Tag','btnncMoveUp'),'Enable', 'Off');
        set(findobj('Tag','btnncMoveDown'),'Enable', 'Off');           
        set(findobj('Tag','btnncRemoveFile'),'Enable', 'Off');
        set(findobj('Tag','chkboxncIm'),'Enable', 'Off');
        set(findobj('Tag','chkboxncVm'),'Enable', 'Off');
        set(findobj('Tag','chkboxncStimulus'),'Enable', 'Off');
        set(findobj('Tag','chkboxncVj'),'Enable', 'Off');
        set(findobj('Tag','chkboxncVavg'),'Enable', 'Off');
        
    end
    
    if (isappdata(figure_handle,'averaged_data'))
        rmappdata(figure_handle,'averaged_data');
    end
    
%%

function [checkedColumns, flag] = selectedColumns()
%%
    
    figure_handle = findobj('Tag', 'figncMain');
      
    flag=0;
    
    checkedColumns=[1]; %#ok<NBRAK>
    if(isequal(getappdata(figure_handle,'signalType'),2)) %if signal source is In-vivo recording    
        if(isequal(getappdata(figure_handle,'Im'),1))%if VmAC channel is checked
            checkedColumns = [checkedColumns,2];
        end
        if(isequal(getappdata(figure_handle,'Vm'),1))%if VmDC channel is checked
            checkedColumns = [checkedColumns,3];
        end
        if(isequal(getappdata(figure_handle,'Stim'),1))%if Stimulus channel is checked
            checkedColumns = [checkedColumns,4];
        end
        flag=1;
        setappdata(figure_handle,'checkedColumns',checkedColumns);
    elseif(isequal(getappdata(figure_handle,'signalType'),3)) %if signal source is Transistor recording
        if(isequal(getappdata(figure_handle,'Im'),1))%if Im channel is checked
            checkedColumns = [checkedColumns,2];
        end
        if(isequal(getappdata(figure_handle,'Vm'),1))%if Vm channel is checked
            checkedColumns = [checkedColumns,3];
        end
        if(isequal(getappdata(figure_handle,'Vj'),1))%if Vj channel is checked
            checkedColumns = [checkedColumns,4];
        end
        if(isequal(getappdata(figure_handle,'Vavg'),1))%if Vavg channel is checked
            checkedColumns = [checkedColumns,5];           
        end
        flag=1;
        setappdata(figure_handle,'checkedColumns',checkedColumns);        
    elseif(isequal(getappdata(figure_handle,'signalType'),1)) % if nothing is selected
        msgbox('Please select the Channels','Channels not Selected','Error');
    else % if something else happens 
        msgbox('Please select the Recording Type and Channels','Signal Type & Channels not Selected','Error');        
    end
    
    if (length(checkedColumns)==1 && flag)
        msgbox('Please Select the Channel of Data','Channel Not Selected', 'Error');
        flag = 0;
    end


% --- Executes on button press in btnncRemoveFile.
function btnncRemoveFile_Callback(hObject, eventdata, handles)
    %%
% hObject    handle to btnncRemoveFile (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

    fh=findobj('Tag','lstboxncContent');
    selected = get(fh,'Value'); 
    prev_str = get(fh, 'String'); 
    if ~isempty(prev_str) 
        prev_str(get(fh,'Value')) = []; 
        set(fh, 'String', prev_str, ... 
            'Value', min(selected,length(prev_str))); 
        setappdata(findobj('Tag','figncMain'),'fileNames',prev_str);
    end



function processData(time, data, flagString)
    
    fh = findobj('Tag','figncMain');
    
    fileCount=length(getappdata(findobj('Tag','figncMain'),'fileNames'));    
    
    dataPoints = getappdata(fh,'dataPoints'); 
    columns = getappdata(fh, 'checkedColumns');
    
    signalType = getappdata(fh,'signalType');
    
    processed_data=[];
    
    
    switch lower(flagString)
        case 'average'
            if (signalType == 3)
                reshapedData = reshape(data,dataPoints,fileCount,length(columns)-1); % reshape and transpose the data matrix for averaging
            elseif (signalType == 2)
                reshapedData = reshape(data,dataPoints,fileCount); % reshape and transpose the data matrix for averaging
            end
            processed_time = time(1:dataPoints,1);

            h=waitbar(0,'Calculating Averages of the Data Files... Please wait... ');
            for k=1:1:length(columns)-1
                for j=1:1:dataPoints                   
                    processed_data(j,k)= sum(reshapedData(j,:,k))/fileCount; %#ok<AGROW>
                    waitbar(j/dataPoints);
                end
                j=1;
                for i = 1:2:dataPoints
                    averaged_odd_data(j,k) = sum(reshapedData(i,:,k))/fileCount;    %#ok<AGROW>
                    j=j+1;
                end
                j=1;
                for i = 2:2:dataPoints
                    averaged_even_data(j,k) = sum(reshapedData(i,:,k))/fileCount; %#ok<AGROW>
                    j=j+1;                    
                end
            end
            close(h);
 
            fh = findobj('Tag', 'figncMain');

            setappdata(fh, 'averaged_time', processed_time);
            setappdata(fh, 'averaged_data', processed_data);                     

            setappdata(fh, 'averaged_odd_data', averaged_odd_data);
            setappdata(fh, 'averaged_even_data', averaged_even_data);
            
            directoryPath=getappdata(fh,'directoryPath');
            oldPath=pwd;
            cd(directoryPath);
            datafile=[];
            dataFile = [processed_time, processed_data];
            save('AveragedData.txt', 'dataFile','-ASCII','-tabs');
            datafile=[];
            dataFile = [processed_time(1:2:length(processed_time)), averaged_odd_data];
            save('OddAveragedData.txt', 'dataFile','-ASCII','-tabs');
            datafile=[];            
            dataFile = [processed_time(2:2:length(processed_time)), averaged_even_data];            
            save('EvenAveragedData.txt', 'dataFile','-ASCII','-tabs')            
            cd(oldPath);
            
        case 'meansquare'            
            if (signalType == 3)
                reshapedData = reshape(data,dataPoints,fileCount,length(columns)-1); % reshape and transpose the data matrix for averaging
            elseif (signalType == 2)
                reshapedData = reshape(data,dataPoints,fileCount); % reshape and transpose the data matrix for averaging
            end

            processed_time = time(1:dataPoints,1);

            h=waitbar(0,'Calculating Mean Square Averages of the Data Files... Please wait... ');
            for k=1:1:length(columns)-1
                for j=1:1:dataPoints                   
                    processed_data(j,k)= sum(reshapedData(j,:,k))/fileCount; %#ok<AGROW>                    
                    ms_processed_data(j,k)= sum(reshapedData(j,:,k).^2)/fileCount; %#ok<AGROW>
                    waitbar(j/dataPoints);
                end
            end
            close(h);
            
            rms_processed_data = sqrt(ms_processed_data);
 
            fh = findobj('Tag', 'figncMain');

            setappdata(fh, 'averaged_time', processed_time);
            setappdata(fh, 'averaged_data', processed_data);            
            setappdata(fh, 'ms_averaged_data', ms_processed_data);
            setappdata(fh, 'rms_averaged_data', rms_processed_data);

            directoryPath=getappdata(fh,'directoryPath');
            oldPath=pwd;
            cd(directoryPath);
            if(~isappdata(fh,'averaged_data'))
                datafile=[];
                dataFile = [processed_time, processed_data];
                save('AveragedData.txt', 'dataFile','-ASCII','-tabs');
            end
            datafile=[];
            dataFile = [processed_time, ms_processed_data];
            save('MeanSquareAveragedData.txt', 'dataFile','-ASCII','-tabs');            
            datafile=[];
            dataFile = [processed_time, rms_processed_data];
            save('RootMeanSquareAveragedData.txt', 'dataFile','-ASCII','-tabs');
            cd(oldPath);            
          
    end
    

    %%

% --- Executes on selection change in pumncRecType.
function pumncRecType_Callback(hObject, eventdata, handles)
    %%
% hObject    handle to pumncRecType (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = get(hObject,'String') returns pumncRecType contents as cell array
%        contents{get(hObject,'Value')} returns selected item from pumncRecType

% selectedString = get(handles.pumncRecType, 'String');
    selectedValue = get(hObject, 'Value');

    setappdata(findobj('Tag','figncMain'),'signalType',selectedValue);

    switch selectedValue
        case 2 % if the In-Vivo recording is selected
            set(findobj('Tag', 'btnncBrowse'), 'Enable', 'On');

            set(findobj('Tag', 'chkboxncVm'), 'Visible', 'On');
            set(findobj('Tag', 'chkboxncVm'), 'String', 'VmDC');        
            set(findobj('Tag', 'chkboxncIm'), 'Visible', 'On');    
            set(findobj('Tag', 'chkboxncStimulus'), 'Visible', 'On');        
            set(findobj('Tag', 'chkboxncIm'), 'String', 'VmAC');        
            set(findobj('Tag', 'chkboxncVj'), 'Visible', 'Off');  
            set(findobj('Tag', 'chkboxncVavg'), 'Visible', 'Off');          

        case 3 % if the Transistor recording is selected
            set(findobj('Tag', 'chkboxncIm'), 'Visible', 'On');  
            set(findobj('Tag', 'chkboxncIm'), 'String', 'Im');                
            set(findobj('Tag', 'chkboxncVm'), 'Visible', 'On');  
            set(findobj('Tag', 'chkboxncVm'), 'String', 'Vm');                
            set(findobj('Tag', 'chkboxncVj'), 'Visible', 'On');  
            set(findobj('Tag', 'chkboxncVavg'), 'Visible', 'On');  
            set(findobj('Tag', 'chkboxncStimulus'), 'Visible', 'Off');         

            set(findobj('Tag', 'btnncBrowse'), 'Enable', 'On');        
        otherwise % if nothing is selected
            msgbox('Please Select a Signal Source', 'Signal Source Not Selected','Error');
            set(findobj('Tag', 'btnncBrowse'), 'Enable', 'Off');
            set(findobj('Tag', 'chkboxncIm'), 'Visible', 'Off');  
            set(findobj('Tag', 'chkboxncVm'), 'Visible', 'Off');  
            set(findobj('Tag', 'chkboxncVj'), 'Visible', 'Off');  
            set(findobj('Tag', 'chkboxncVavg'), 'Visible', 'Off'); 
            set(findobj('Tag', 'chkboxncStimulus'), 'Visible', 'Off');         
    end


% --- Executes during object creation, after setting all properties.
function pumncRecType_CreateFcn(hObject, eventdata, handles)
% hObject    handle to pumncRecType (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

%%



% --- Executes on button press in chkboxncIm.
function chkboxncIm_Callback(hObject, eventdata, handles)
% hObject    handle to chkboxncIm (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of chkboxncIm

    if (get(hObject,'Value') == get(hObject,'Max'))
        % Checkbox is checked
        setappdata(findobj('Tag','figncMain'),'Im',1);
    else
        % Checkbox is not checked
        setappdata(findobj('Tag','figncMain'),'Im',0);        
    end    



%%

% --- Executes on button press in chkboxncVm.
function chkboxncVm_Callback(hObject, eventdata, handles)
% hObject    handle to chkboxncVm (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of chkboxncVm

    if (get(hObject,'Value') == get(hObject,'Max'))
        % Checkbox is checked
        setappdata(findobj('Tag','figncMain'),'Vm',1);
    else
        % Checkbox is not checked
        setappdata(findobj('Tag','figncMain'),'Vm',0);        
    end    

%%


% --- Executes on button press in chkboxncVj.
function chkboxncVj_Callback(hObject, eventdata, handles)
% hObject    handle to chkboxncVj (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of chkboxncVj

    if (get(hObject,'Value') == get(hObject,'Max'))
        % Checkbox is checked
        setappdata(findobj('Tag','figncMain'),'Vj',1);
    else
        % Checkbox is not checked
        setappdata(findobj('Tag','figncMain'),'Vj',0);        
    end    

%%

% --- Executes on button press in chkboxncVavg.
function chkboxncVavg_Callback(hObject, eventdata, handles)
%%
% hObject    handle to chkboxncVavg (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of chkboxncVavg

    if (get(hObject,'Value') == get(hObject,'Max'))
        % Checkbox is checked
        setappdata(findobj('Tag','figncMain'),'Vavg',1);
    else
        % Checkbox is not checked
        setappdata(findobj('Tag','figncMain'),'Vavg',0);        
    end    



% --- Executes on button press in chkboxncStimulus.
function chkboxncStimulus_Callback(hObject, eventdata, handles)
%%
% hObject    handle to chkboxncStimulus (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of chkboxncStimulus


    if (get(hObject,'Value') == get(hObject,'Max'))
        % Checkbox is checked
        setappdata(findobj('Tag','figncMain'),'Stim',1);
    else
        % Checkbox is not checked
        setappdata(findobj('Tag','figncMain'),'Stim',0);        
    end    


% --- Executes on button press in btnncMoveUp.
function btnncMoveUp_Callback(hObject, eventdata, handles)
    %%
% hObject    handle to btnncMoveUp (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

    fh = findobj('Tag', 'lstboxncContent');
    listbox_contents = get(fh, 'String');
    selected_index = get(fh, 'Value');    
    
    if (~isempty(listbox_contents) && (selected_index > 1)&&(selected_index <= length(listbox_contents)))
        index = get(fh,'Value');
        tempFile=listbox_contents{index};
        listbox_contents{index}=listbox_contents{index-1};
        listbox_contents{index-1}=tempFile;
        set(fh, 'String', listbox_contents, ... 
            'Value', min(index,length(listbox_contents))); 
        setappdata(findobj('Tag','figncMain'),'fileNames',listbox_contents);
        set(fh,'Value',index-1)
    end

    if(selected_index == 1)
        set(findobj('Tag','btnncMoveUp'),'Enable', 'Off');
        set(findobj('Tag','btnncMoveDown'),'Enable', 'On');        
    else
        set(findobj('Tag','btnncMoveUp'),'Enable', 'On');        
    end    

    if(selected_index == length(listbox_contents))
        set(findobj('Tag','btnncMoveDown'),'Enable', 'Off');
        set(findobj('Tag','btnncMoveUp'),'Enable', 'On');
    else
        set(findobj('Tag','btnncMoveDown'),'Enable', 'On');        
    end  

% --- Executes on button press in btnncMoveDown.
function btnncMoveDown_Callback(hObject, eventdata, handles)
    %%
% hObject    handle to btnncMoveDown (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

    fh = findobj('Tag', 'lstboxncContent');    
    listbox_contents = get(fh, 'String');
    selected_index = get(fh, 'Value');
    

    if (~isempty(listbox_contents) && (selected_index >= 1)&&(selected_index < length(listbox_contents)))
        index = get(fh,'Value');
        tempFile=listbox_contents{index};
        listbox_contents{index}=listbox_contents{index+1};
        listbox_contents{index+1}=tempFile;
        set(fh, 'String', listbox_contents, ... 
            'Value', min(index,length(listbox_contents))); 
        setappdata(findobj('Tag','figncMain'),'fileNames',listbox_contents);
        set(fh,'Value',index+1)        
    end     

    if(selected_index == 1)
        set(findobj('Tag','btnncMoveUp'),'Enable', 'Off');
        set(findobj('Tag','btnncMoveDown'),'Enable', 'On');        
    else
        set(findobj('Tag','btnncMoveUp'),'Enable', 'On');        
    end    

    if(selected_index == length(listbox_contents))
        set(findobj('Tag','btnncMoveDown'),'Enable', 'Off');
        set(findobj('Tag','btnncMoveUp'),'Enable', 'On');
    else
        set(findobj('Tag','btnncMoveDown'),'Enable', 'On');        
    end


% --- Executes on button press in tbncZoom.
function tbncZoom_Callback(hObject, eventdata, handles)
    %%
% hObject    handle to tbncZoom (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of tbncZoom

    button_state = get(hObject,'Value');
    if button_state == get(hObject,'Max')
	% Toggle button is pressed, take appropriate action
        zoom on;
        fh = findobj('Tag','tbDataCursor');
        if (get(fh, 'Value')== get(fh,'Max'))
            set(fh,'Value',0);
        end
        
        fh = findobj('Tag','tbPan');
        if (get(fh, 'Value')== get(fh,'Max'))
            set(fh,'Value',0);
        end          
    elseif button_state == get(hObject,'Min')
	% Toggle button is not pressed, take appropriate action
        zoom off;
    end

% --- Executes on button press in tbncDataCursor.
function tbncDataCursor_Callback(hObject, eventdata, handles)
    %%
% hObject    handle to tbncDataCursor (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of tbncDataCursor

    button_state = get(hObject,'Value');
    if button_state == get(hObject,'Max')
	% Toggle button is pressed, take appropriate action
        datacursormode on;
        dcm_obj=datacursormode(findobj('Tag','figncMain'));
        set(dcm_obj,'UpdateFcn',@myupdatefcn);
        
        fh = findobj('Tag','tbZoom');
        if (get(fh, 'Value')== get(fh,'Max'))
            set(fh,'Value',0);
        end
        
        fh = findobj('Tag','tbPan');
        if (get(fh, 'Value')== get(fh,'Max'))
            set(fh,'Value',0);
        end          
    elseif button_state == get(hObject,'Min')
	% Toggle button is not pressed, take appropriate action
        datacursormode off;
    end
    
    
function txt = myupdatefcn(empt,event_obj)
%%
%This function is for updating the data cursor text
    pos = get(event_obj,'Position');
    txt = {['Time: ',num2str(pos(1)),' ms'],...
        ['Amplitude: ',num2str(pos(2))],' mV'};    


% --- Executes on button press in btnncResetGraph.
function btnncResetGraph_Callback(hObject, eventdata, handles)
    %%
% hObject    handle to btnncResetGraph (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

    fh = findobj('Tag','tbZoom');
    if (get(fh, 'Value')== get(fh,'Max'))
        set(fh,'Value',0);
    end
    
    fh = findobj('Tag','tbDataCursor');
    if (get(fh, 'Value')== get(fh,'Max'))
        set(fh,'Value',0);
    end    
    
    fh = findobj('Tag','tbPan');
    if (get(fh, 'Value')== get(fh,'Max'))
        set(fh,'Value',0);
    end      
    
    datacursormode off;
    
    zoom off;
    
    pan off;
    
    axis('tight');


% --- Executes on button press in tbncPan.
function tbncPan_Callback(hObject, eventdata, handles)
%%
% hObject    handle to tbncPan (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of tbncPan


    button_state = get(hObject,'Value');
    if button_state == get(hObject,'Max')
	% Toggle button is pressed, take appropriate action
        pan on;
%         dcm_obj=datacursormode(findobj('Tag','figncMain'));
%         set(dcm_obj,'UpdateFcn',@myupdatefcn);
        
        fh = findobj('Tag','tbZoom');
        if (get(fh, 'Value')== get(fh,'Max'))
            set(fh,'Value',0);
        end
        fh = findobj('Tag','tbDataCursor');
        if (get(fh, 'Value')== get(fh,'Max'))
            set(fh,'Value',0);
        end        
    elseif button_state == get(hObject,'Min')
	% Toggle button is not pressed, take appropriate action
        pan off;
    end


%% --------------------------------------------------------------------


% --- Executes during object creation, after setting all properties.
function axsncSigMate_CreateFcn(hObject, eventdata, handles)
% hObject    handle to axsncSigMate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: place code in OpeningFcn to populate axsncSigMate
    axes(hObject)
    pathLogo = which('SigMate-Logo');
    imshow([pathLogo '\' 'SigMate-Logo.gif'])