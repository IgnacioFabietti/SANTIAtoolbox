function varargout = depthProfile(varargin)
% DEPTHPROFILE M-file for depthProfile.fig
%      DEPTHPROFILE, by itself, creates a new DEPTHPROFILE or raises the existing
%      singleton*.
%
%      H = DEPTHPROFILE returns the handle to a new DEPTHPROFILE or the handle to
%      the existing singleton*.
%
%      DEPTHPROFILE('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in DEPTHPROFILE.M with the given input arguments.
%
%      DEPTHPROFILE('Property','Value',...) creates a new DEPTHPROFILE or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before FirstGUI_OpeningFunction gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to depthProfile_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help depthProfile

% Last Modified by GUIDE v2.5 15-May-2012 16:07:07

% Begin initialization code - DO NOT EDIT


gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @depthProfile_OpeningFcn, ...
                   'gui_OutputFcn',  @depthProfile_OutputFcn, ...
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

% --- Executes just before depthProfile is made visible.
function depthProfile_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to depthProfile (see VARARGIN)

% Choose default command line output for depthProfile
handles.output = hObject;

set(handles.figDepthProfile, 'CloseRequestFcn', 'closeGUI');

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes depthProfile wait for user response (see UIRESUME)
% uiwait(handles.figDepthProfile);

%%

% --- Outputs from this function are returned to the command line.
function varargout = depthProfile_OutputFcn(hObject, eventdata, handles) 
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

% --- Executes on button press in btndpBrowse.
function btndpBrowse_Callback(hObject, eventdata, handles)
% hObject    handle to btndpBrowse (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
    
%     global filelist, filenames
    
    %clear if any application data exists
    
    fh = findobj('Tag', 'figDepthProfile');    
    if(isappdata(fh,'averaged_time'))
        rmappdata(fh,'averaged_time');
    end
    if(isappdata(fh,'averaged_data'))
        rmappdata(fh,'averaged_data');
    end  
    
%     path = uigetdir('D:\MatlabWorks','Select a Directory'); %Select the directory and store the path at folder 

    if (isappdata(fh, 'directoryPath'))
        browseDir = getappdata(fh, 'directoryPath');
        path = uigetdir(browseDir,'Select a Directory'); %Select the directory and store the path at folder 
    else
        path = uigetdir([pwd '\'],'Select a Directory'); %Select the directory and store the path at folder        
    end
    
    if(path) % if a directory is selected        
        setappdata(fh, 'directoryPath', strcat(path,'\'));
        handle_lblPath = findobj('Tag', 'lbldpPath'); % find the object with the Tag lbldpPath and store the reference handle

        if (handle_lblPath ~= 0) % if the above searched object found
            text = get(handle_lblPath,'String');  % get the text of the object
            if(~(strcmp(text,'Selected Directory Path')))
                text = 'Selected Directory Path';
            end
            newtext = strcat(text, ': ', path); % append the folder path to the content
            set(handle_lblPath,'String',newtext); % set the new text to the control
        end

        newpath = strcat(regexprep(path,'\','/'),'/*.txt'); %replace the path with a forward slash '/'instead of a backward slash and add the file type

        dir_struct = dir(newpath);
        [file_names,file_index] = sortrows({dir_struct.name}');
        handles.file_names = file_names;
        handles.is_dir = [dir_struct.isdir];
        handles.file_index = file_index;
        guidata(hObject,handles);
        setappdata(fh,'fileNames',file_names);
        set(findobj('Tag','lstboxdpContent'),'String',handles.file_names,...
            'Value',1);
        set(findobj('Tag','btndpLoad'),'Enable', 'On');
        set(findobj('Tag','btndpLoad'),'String', 'Load Data Files');        
        set(findobj('Tag','btndpRemoveFile'),'Enable', 'On');
       
        if (strcmpi(get(findobj('Tag','btnDepthProfile'),'Enable'),'On'))
            set(findobj('Tag','btnDepthProfile'),'Enable', 'Off');
        end
        
        set(findobj('Tag','chkboxdpCh1'),'Enable', 'On');
        set(findobj('Tag','chkboxdpCh2'),'Enable', 'On');
        set(findobj('Tag','chkboxdpCh3'),'Enable', 'On');
        set(findobj('Tag','chkboxdpCh4'),'Enable', 'On');
        set(findobj('Tag','chkboxdpCh5'),'Enable', 'On');
        
        set(findobj('Tag','btndpMoveUp'),'Enable', 'On');
        set(findobj('Tag','btndpMoveDown'),'Enable', 'On');
        
    else %if the directory selection dialog is cancelled
        
        msgbox('Please Select a Directory for Analysis', 'Directory Not Selected','Error');
    end

    listbox_contents = get(findobj('Tag', 'lstboxdpContent'), 'String');
    selected_index = get(findobj('Tag', 'lstboxdpContent'), 'Value');    
    if(selected_index == 1)
        set(findobj('Tag','btndpMoveUp'),'Enable', 'Off');
    elseif(selected_index == length(listbox_contents))
        set(findobj('Tag','btndpMoveDown'),'Enable', 'Off');        
    end


%%

% --- Executes on selection change in lstboxdpContent.
function lstboxdpContent_Callback(hObject, eventdata, handles)
% hObject    handle to lstboxdpContent (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = get(hObject,'String') returns lstboxdpContent contents as cell array
%        contents{get(hObject,'Value')} returns selected item from lstboxdpContent

    listbox_contents = get(findobj('Tag', 'lstboxdpContent'), 'String');
    selected_index = get(findobj('Tag', 'lstboxdpContent'), 'Value');
    fh = findobj('Tag','figDepthProfile');
    
    if(selected_index == 1)
        set(findobj('Tag','btndpMoveUp'),'Enable', 'Off');
        set(findobj('Tag','btndpMoveDown'),'Enable', 'On');        
    else
        set(findobj('Tag','btndpMoveUp'),'Enable', 'On');        
    end    

    if(selected_index == length(listbox_contents))
        set(findobj('Tag','btndpMoveDown'),'Enable', 'Off');
        set(findobj('Tag','btndpMoveUp'),'Enable', 'On');
    else
        set(findobj('Tag','btndpMoveDown'),'Enable', 'On');        
    end
    
    [checkedColumns, flag] = selectedColumns();
%     checkedColumns = getappdata(fh, 'checkedColumns');
    
    if(flag)       
        filePath = getappdata(fh, 'directoryPath');
        [fet_time, fet_data] = readData(filePath, listbox_contents{selected_index}, checkedColumns);
        color = {'r','g','b','c','m','y','k'};        
        cla(findobj('Tag','axdpMain'));
%         axes(findobj('Tag','axdpMain'));
        columns = length(checkedColumns);
        hold on
        for i=1:1:columns-1
%             subplot(columns-1,1,i);
            plot(fet_time, fet_data(:,i),color{i});
            title(['Plot of Selected Column: ',num2str(i)]);
        end
        axis('tight');
        hold off
    end
    

%%

% --- Executes during object creation, after setting all properties.
function lstboxdpContent_CreateFcn(hObject, eventdata, handles)
% hObject    handle to lstboxdpContent (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



%%

% --- Executes on button press in btnDepthProfile.
function btnDepthProfile_Callback(hObject, eventdata, handles)
% hObject    handle to btnDepthProfile (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

    fh = findobj('Tag', 'figDepthProfile');

    time = getappdata(fh, 'fet_time');    
    data = getappdata(fh, 'fet_data');
      
    createDepthProfile(time, data);
    
    msgbox(['The depth profile file named DepthProfile.txt has been saved at: ' getappdata(fh,'directoryPath')],'Depth Profile Creation Confirmation')
        
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
                    title('Plot for Ch1');
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
    elseif(strcmp(plotTitle,'+/- Average of FET Recordings'))
        time = getappdata(handles, 'averaged_time');
        data = getappdata(handles, 'averaged_data');      
        averagedOdd = getappdata(handles, 'averaged_odd_data');
        averagedEven = getappdata(handles, 'averaged_even_data');        
        figure('Name','SigMate: +/- Average of FET Recordings','NumberTitle','off');
        for i=1:1:length(checkedColumns)-1
            subplot((length(checkedColumns)-1)*2,1,(i*2)-1);
            plot(time,data(:,i),color{i});          
            title(['Plot of Averaged Signal for FET Recordings for Channel', num2str(i)]);
            xlabel('Time (S)');
            ylabel('V (mV)');
            subplot((length(checkedColumns)-1)*2,1,(i*2));
            hold on
            plot(time(1:2:length(time)),averagedOdd(:,i),'b');
            plot(time(2:2:length(time)),averagedEven(:,i),'g');
            title(['+/- Average of FET Recordings for the Channel ', num2str(i)]);
            xlabel('Time (S)');
            ylabel('V (mV)');
            hold off
        end
        axis('tight');
        grid on;
    elseif(strcmp(plotTitle,'Mean Square Average of FET Recordings'))
        time = getappdata(handles, 'averaged_time');
        data = getappdata(handles, 'averaged_data');      
        meanSquaredData = getappdata(handles, 'ms_averaged_data');
        figure('Name','SigMate: Mean Square Average of FET Recordings','NumberTitle','off');
        for i=1:1:length(checkedColumns)-1
            subplot((length(checkedColumns)-1)*2,1,(i*2)-1);
            plot(time,data(:,i),color{i});          
            title(['Plot of Averaged Signal for FET Recordings for Channel', num2str(i)]);
            xlabel('Time (S)');
            ylabel('V (mV)');
            subplot((length(checkedColumns)-1)*2,1,(i*2));
            plot(time,meanSquaredData(:,i),color{i});
            title(['Mean Square Average of FET Recordings for Channel ', num2str(i)]);
            xlabel('Time (S)');
            ylabel('V (mV)');            
        end
        axis('tight');
        grid on;
    elseif(strcmp(plotTitle,'Root Mean Square Average of FET Recordings'))
        time = getappdata(handles, 'averaged_time');
        data = getappdata(handles, 'averaged_data');      
        rootmeanSquaredData = getappdata(handles, 'rms_averaged_data');
        figure('Name','SigMate: Root Mean Square Average of FET Recording','NumberTitle','off');
        for i=1:1:length(checkedColumns)-1
            subplot((length(checkedColumns)-1)*2,1,(i*2)-1);
            plot(time,data(:,i),color{i});          
            title(['Plot of Averaged Signal for FET Recordings for Channel', num2str(i)]);
            xlabel('Time (S)');
            ylabel('V (mV)');
            subplot((length(checkedColumns)-1)*2,1,(i*2));
            plot(time,rootmeanSquaredData(:,i),color{i});
            title(['Root Mean Square Average of FET Recordings for Channel ', num2str(i)]);
            xlabel('Time (S)');
            ylabel('V (mV)');            
        end
        axis('tight');          
        grid on;
                       
    end



%%

% --- Executes on button press in btndpLoad.
function btndpLoad_Callback(hObject, eventdata, handles)
% hObject    handle to btndpLoad (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

    figure_handle = findobj('Tag', 'figDepthProfile');
    
    listbox_contents = get(findobj('Tag', 'lstboxdpContent'), 'String');    
    
    [checkedColumns, flag]=selectedColumns();
    
    channelOverlap = getappdata(figure_handle, 'ChannelOverlap');
    
    if(flag) %if proper signal source and channels are selected
        
        directoryPath = getappdata(figure_handle,'directoryPath');
        
        tempData = load([directoryPath listbox_contents{1}]);
        
        [rows, columns] = size(tempData);
        
        fet_time = tempData(:,1);
        
        T = fet_time(2)-fet_time(1);              % sampling step
        Fs=1/T;    
        % low pass filter the signal with the specified cutoff frequency
        fNorm = 500 / (Fs/2);
        [b,a] = butter(5,fNorm,'low');
        
        data=[];
        fet_data = [];
        
        if columns>5
            
            fet_data(:,1:columns-1)=tempData(:,2:end);
            
            if channelOverlap
                set(findobj('Tag','chkboxOvCh'),'Value', 0);
            end
            
        else
        
            if channelOverlap

                for i = 1:length(listbox_contents)
                    tempData = load([directoryPath listbox_contents{i}]);
                    tempData = filtfilt(b,a,tempData);
                    if i==1
                        data(:,1:length(checkedColumns)-1) = tempData(:,2:end);
                        [r,c]=size(data);
                        for j=1:c
                            fet_data(:,j)=data(:,c-(j-1));
                        end
                    else
                        data=[];
                        data(:,1:length(checkedColumns)-2)=tempData(:,2:end-1);
                        [r,c]=size(data);
                        tempData=[];
                        for j=1:c
                            tempData(:,j)=data(:,c-(j-1));
                        end                
                        [rows,columns]=size(fet_data);
                        fet_data(:,columns+1:columns+length(checkedColumns)-2)=tempData(:,:);
                    end
                end
            else
                for i = 1:length(listbox_contents)
                    tempData = load([directoryPath listbox_contents{i}]);
                    tempData = filtfilt(b,a,tempData);
                    if i==1
                        data(:,1:length(checkedColumns)-1) = tempData(:,2:end);
                        [~,c]=size(data);
                        for j=1:c
                            fet_data(:,j)=data(:,c-(j-1));
                        end
                    else
                        data=[];
                        data(:,1:length(checkedColumns)-1)=tempData(:,2:end);
                        [~,c]=size(data);
                        tempData=[];
                        for j=1:c
                            tempData(:,j)=data(:,c-(j-1));
                        end                
                        [~,columns]=size(fet_data);
                        fet_data(:,columns+1:columns+length(checkedColumns)-1)=tempData(:,:);
                    end
                end            
            end
        end

        setappdata(figure_handle, 'fet_time', fet_time);
        setappdata(figure_handle, 'fet_data', fet_data);        
        setappdata(figure_handle, 'samplingFreq', Fs);
%         setappdata(figure_handle, 'dataPoints', dataPoints);        

        set(findobj('Tag','btndpLoad'),'String', 'Data Files Loaded');
        set(findobj('Tag','btndpLoad'),'Enable', 'Off');
        set(findobj('Tag','btndpMoveUp'),'Enable', 'Off');
        set(findobj('Tag','btndpMoveDown'),'Enable', 'Off');           

        set(findobj('Tag','btndpRemoveFile'),'Enable', 'Off');
        set(findobj('Tag','chkboxdpCh1'),'Enable', 'Off');
        set(findobj('Tag','chkboxdpCh2'),'Enable', 'Off');
        set(findobj('Tag','chkboxdpCh3'),'Enable', 'Off');
        set(findobj('Tag','chkboxdpCh4'),'Enable', 'Off');
        set(findobj('Tag','chkboxdpCh5'),'Enable', 'Off');
        
        if (strcmpi(get(findobj('Tag','btnDepthProfile'),'Enable'),'Off'))
            set(findobj('Tag','btnDepthProfile'),'Enable', 'On');
        end        
        
    end
        
%%

function [checkedColumns, flag] = selectedColumns()
%%
    
    figure_handle = findobj('Tag', 'figDepthProfile');
      
    flag=0;
    
    checkedColumns=[1]; %#ok<NBRAK>
    if(isequal(getappdata(figure_handle,'signalType'),2)||(isequal(getappdata(figure_handle,'signalType'),3))) %if signal source is Micropipette/Transistor recording    
        if(isequal(getappdata(figure_handle,'Ch1'),1))%if Channel1 channel is checked
            checkedColumns = [checkedColumns,2];
        end
        if(isequal(getappdata(figure_handle,'Ch2'),1))%if Channel2 channel is checked
            checkedColumns = [checkedColumns,3];
        end
        if(isequal(getappdata(figure_handle,'Ch3'),1))%if Channel3 channel is checked
            checkedColumns = [checkedColumns,4];
        end
        if(isequal(getappdata(figure_handle,'Ch4'),1))%if Channel4 channel is checked
            checkedColumns = [checkedColumns,5];
        end
        if(isequal(getappdata(figure_handle,'Ch5'),1))%if Channel5 channel is checked
            checkedColumns = [checkedColumns,6];
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

% --- Executes on button press in btndpRemoveFile.
function btndpRemoveFile_Callback(hObject, eventdata, handles)
    %%
% hObject    handle to btndpRemoveFile (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

    fh=findobj('Tag','lstboxdpContent');
    selected = get(fh,'Value'); 
    prev_str = get(fh, 'String'); 
    if ~isempty(prev_str) 
        prev_str(get(fh,'Value')) = []; 
        set(fh, 'String', prev_str, ... 
            'Value', min(selected,length(prev_str))); 
        setappdata(findobj('Tag','figDepthProfile'),'fileNames',prev_str);
    end


function createDepthProfile(time, data)
    
    fh = findobj('Tag','figDepthProfile');
    
    fileCount=length(getappdata(findobj('Tag','figDepthProfile'),'fileNames'));    
    
    [rows,columns]=size(data);
    
    fhDistance = findobj('Tag','txtdpDistance');
    
%     stringValue = get(handles.editTextBox, 'string'); 
%     doubleValue = str2double(stringValue); 
    
    maxAmpl = str2double(get(fhDistance,'String'));
    
%     maxAmpl = min(min(data))/2;
    
%     depthProfile = zeros(rows, columns+1);
    
%     depthProfile(:,1) = time;
    
    h=waitbar(0,'Performing Operations on Data Files to Create Depth Profile... Please wait... ');
    
    for i = 1:columns
        if i>1
            tempData=data(:,i);
            data(:,i)=tempData+(maxAmpl*(i-1));
        end
        waitbar(i/columns)
    end
    
    close(h);
      
    cla(findobj('Tag','axdpMain'));
    plot(time, data)
    directoryPath=getappdata(fh,'directoryPath');
    oldPath=pwd;
    cd(directoryPath);
    datafile=[];
    dataFile = [time, data];
    save('DepthProfile.txt', 'dataFile','-ASCII','-tabs');
    cd(oldPath);   

    %%

% --- Executes on selection change in pumdpRecType.
function pumdpRecType_Callback(hObject, eventdata, handles)
    %%
% hObject    handle to pumdpRecType (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = get(hObject,'String') returns pumdpRecType contents as cell array
%        contents{get(hObject,'Value')} returns selected item from pumdpRecType

% selectedString = get(handles.pumdpRecType, 'String');
    selectedValue = get(hObject, 'Value');

    setappdata(findobj('Tag','figDepthProfile'),'signalType',selectedValue);
    switch selectedValue
        case 2 % if the micropipette recording is selected
            set(findobj('Tag', 'btndpBrowse'), 'Enable', 'On');
            set(findobj('Tag', 'chkboxdpCh1'), 'Visible', 'On');
            set(findobj('Tag', 'chkboxdpCh2'), 'Visible', 'On');
            set(findobj('Tag', 'chkboxdpCh3'), 'Visible', 'On');
            set(findobj('Tag', 'chkboxdpCh4'), 'Visible', 'On');
            set(findobj('Tag', 'chkboxdpCh5'), 'Visible', 'On');
        case 3 % if the Transistor recording is selected
            set(findobj('Tag', 'btndpBrowse'), 'Enable', 'On');
            set(findobj('Tag', 'chkboxdpCh1'), 'Visible', 'On');
            set(findobj('Tag', 'chkboxdpCh2'), 'Visible', 'On');
            set(findobj('Tag', 'chkboxdpCh3'), 'Visible', 'On');
            set(findobj('Tag', 'chkboxdpCh4'), 'Visible', 'On');
            set(findobj('Tag', 'chkboxdpCh5'), 'Visible', 'On');        
        otherwise % if nothing is selected
            msgbox('Please Select a Signal Source', 'Signal Source Not Selected','Error');
            set(findobj('Tag', 'btndpBrowse'), 'Enable', 'Off');
            set(findobj('Tag', 'chkboxdpCh1'), 'Visible', 'Off');  
            set(findobj('Tag', 'chkboxdpCh2'), 'Visible', 'Off');  
            set(findobj('Tag', 'chkboxdpCh4'), 'Visible', 'Off');  
            set(findobj('Tag', 'chkboxdpCh5'), 'Visible', 'Off'); 
            set(findobj('Tag', 'chkboxdpCh3'), 'Visible', 'Off');         
    end            

% --- Executes during object creation, after setting all properties.
function pumdpRecType_CreateFcn(hObject, eventdata, handles)
% hObject    handle to pumdpRecType (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

%%

% --- Executes on button press in chkboxdpCh1.
function chkboxdpCh1_Callback(hObject, eventdata, handles)
% hObject    handle to chkboxdpCh1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of chkboxdpCh1

    if (get(hObject,'Value') == get(hObject,'Max'))
        % Checkbox is checked
        setappdata(findobj('Tag','figDepthProfile'),'Ch1',1);
    else
        % Checkbox is not checked
        setappdata(findobj('Tag','figDepthProfile'),'Ch1',0);        
    end    



%%

% --- Executes on button press in chkboxdpCh2.
function chkboxdpCh2_Callback(hObject, eventdata, handles)
% hObject    handle to chkboxdpCh2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of chkboxdpCh2

    if (get(hObject,'Value') == get(hObject,'Max'))
        % Checkbox is checked
        setappdata(findobj('Tag','figDepthProfile'),'Ch2',1);
    else
        % Checkbox is not checked
        setappdata(findobj('Tag','figDepthProfile'),'Ch2',0);        
    end    

%%

% --- Executes on button press in chkboxdpCh4.
function chkboxdpCh4_Callback(hObject, eventdata, handles)
% hObject    handle to chkboxdpCh4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of chkboxdpCh4

    if (get(hObject,'Value') == get(hObject,'Max'))
        % Checkbox is checked
        setappdata(findobj('Tag','figDepthProfile'),'Ch4',1);
    else
        % Checkbox is not checked
        setappdata(findobj('Tag','figDepthProfile'),'Ch4',0);        
    end    

%%

% --- Executes on button press in chkboxdpCh5.
function chkboxdpCh5_Callback(hObject, eventdata, handles)
%%
% hObject    handle to chkboxdpCh5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of chkboxdpCh5

    if (get(hObject,'Value') == get(hObject,'Max'))
        % Checkbox is checked
        setappdata(findobj('Tag','figDepthProfile'),'Ch5',1);
    else
        % Checkbox is not checked
        setappdata(findobj('Tag','figDepthProfile'),'Ch5',0);        
    end    

% --- Executes on button press in chkboxdpCh3.
function chkboxdpCh3_Callback(hObject, eventdata, handles)
%%
% hObject    handle to chkboxdpCh3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of chkboxdpCh3


    if (get(hObject,'Value') == get(hObject,'Max'))
        % Checkbox is checked
        setappdata(findobj('Tag','figDepthProfile'),'Ch3',1);
    else
        % Checkbox is not checked
        setappdata(findobj('Tag','figDepthProfile'),'Ch3',0);        
    end    
   
% --- Executes on button press in btndpMoveUp.
function btndpMoveUp_Callback(hObject, eventdata, handles)
    %%
% hObject    handle to btndpMoveUp (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

    fh = findobj('Tag', 'lstboxdpContent');
    listbox_contents = get(fh, 'String');
    selected_index = get(fh, 'Value');    
    
    if (~isempty(listbox_contents) && (selected_index > 1)&&(selected_index <= length(listbox_contents)))
        index = get(fh,'Value');
        tempFile=listbox_contents{index};
        listbox_contents{index}=listbox_contents{index-1};
        listbox_contents{index-1}=tempFile;
        set(fh, 'String', listbox_contents, ... 
            'Value', min(index,length(listbox_contents))); 
        setappdata(findobj('Tag','figDepthProfile'),'fileNames',listbox_contents);
        set(fh,'Value',index-1)
    end

    if(selected_index == 1)
        set(findobj('Tag','btndpMoveUp'),'Enable', 'Off');
        set(findobj('Tag','btndpMoveDown'),'Enable', 'On');        
    else
        set(findobj('Tag','btndpMoveUp'),'Enable', 'On');        
    end    

    if(selected_index == length(listbox_contents))
        set(findobj('Tag','btndpMoveDown'),'Enable', 'Off');
        set(findobj('Tag','btndpMoveUp'),'Enable', 'On');
    else
        set(findobj('Tag','btndpMoveDown'),'Enable', 'On');        
    end  

% --- Executes on button press in btndpMoveDown.
function btndpMoveDown_Callback(hObject, eventdata, handles)
    %%
% hObject    handle to btndpMoveDown (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

    fh = findobj('Tag', 'lstboxdpContent');    
    listbox_contents = get(fh, 'String');
    selected_index = get(fh, 'Value');
    

    if (~isempty(listbox_contents) && (selected_index >= 1)&&(selected_index < length(listbox_contents)))
        index = get(fh,'Value');
        tempFile=listbox_contents{index};
        listbox_contents{index}=listbox_contents{index+1};
        listbox_contents{index+1}=tempFile;
        set(fh, 'String', listbox_contents, ... 
            'Value', min(index,length(listbox_contents))); 
        setappdata(findobj('Tag','figDepthProfile'),'fileNames',listbox_contents);
        set(fh,'Value',index+1)        
    end     

    if(selected_index == 1)
        set(findobj('Tag','btndpMoveUp'),'Enable', 'Off');
        set(findobj('Tag','btndpMoveDown'),'Enable', 'On');        
    else
        set(findobj('Tag','btndpMoveUp'),'Enable', 'On');        
    end    

    if(selected_index == length(listbox_contents))
        set(findobj('Tag','btndpMoveDown'),'Enable', 'Off');
        set(findobj('Tag','btndpMoveUp'),'Enable', 'On');
    else
        set(findobj('Tag','btndpMoveDown'),'Enable', 'On');        
    end
    
% --- Executes on button press in tbdpZoom.
function tbdpZoom_Callback(hObject, eventdata, handles)
    %%
% hObject    handle to tbdpZoom (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of tbdpZoom

    button_state = get(hObject,'Value');
    if button_state == get(hObject,'Max')
	% Toggle button is pressed, take appropriate action
        zoom on;
        fh = findobj('Tag','tbdpDataCursor');
        if (get(fh, 'Value')== get(fh,'Max'))
            set(fh,'Value',0);
        end
        
        fh = findobj('Tag','tbdpPan');
        if (get(fh, 'Value')== get(fh,'Max'))
            set(fh,'Value',0);
        end          
    elseif button_state == get(hObject,'Min')
	% Toggle button is not pressed, take appropriate action
        zoom off;
    end

% --- Executes on button press in tbdpDataCursor.
function tbdpDataCursor_Callback(hObject, eventdata, handles)
    %%
% hObject    handle to tbdpDataCursor (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of tbdpDataCursor

    button_state = get(hObject,'Value');
    if button_state == get(hObject,'Max')
	% Toggle button is pressed, take appropriate action
        datacursormode on;
        dcm_obj=datacursormode(findobj('Tag','figDepthProfile'));
        set(dcm_obj,'UpdateFcn',@myupdatefcn);
        
        fh = findobj('Tag','tbdpZoom');
        if (get(fh, 'Value')== get(fh,'Max'))
            set(fh,'Value',0);
        end
        
        fh = findobj('Tag','tbdpPan');
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

% --- Executes on button press in btndpResetGraph.
function btndpResetGraph_Callback(hObject, eventdata, handles)
    %%
% hObject    handle to btndpResetGraph (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

    fh = findobj('Tag','tbdpZoom');
    if (get(fh, 'Value')== get(fh,'Max'))
        set(fh,'Value',0);
    end
    
    fh = findobj('Tag','tbdpDataCursor');
    if (get(fh, 'Value')== get(fh,'Max'))
        set(fh,'Value',0);
    end    
    
    fh = findobj('Tag','tbdpPan');
    if (get(fh, 'Value')== get(fh,'Max'))
        set(fh,'Value',0);
    end      
    
    datacursormode off;
    
    zoom off;
    
    pan off;
    
    axis('tight');

% --- Executes on button press in tbdpPan.
function tbdpPan_Callback(hObject, eventdata, handles)
%%
% hObject    handle to tbdpPan (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of tbdpPan


    button_state = get(hObject,'Value');
    if button_state == get(hObject,'Max')
	% Toggle button is pressed, take appropriate action
        pan on;
%         dcm_obj=datacursormode(findobj('Tag','figDepthProfile'));
%         set(dcm_obj,'UpdateFcn',@myupdatefcn);
        
        fh = findobj('Tag','tbdpZoom');
        if (get(fh, 'Value')== get(fh,'Max'))
            set(fh,'Value',0);
        end
        fh = findobj('Tag','tbdpDataCursor');
        if (get(fh, 'Value')== get(fh,'Max'))
            set(fh,'Value',0);
        end        
    elseif button_state == get(hObject,'Min')
	% Toggle button is not pressed, take appropriate action
        pan off;
    end

% --- Executes on selection change in chkboxOvCh.
function chkboxOvCh_Callback(hObject, eventdata, handles)
%%
% hObject    handle to chkboxOvCh (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns chkboxOvCh contents as cell array
%        contents{get(hObject,'Value')} returns selected item from chkboxOvCh


    if (get(hObject,'Value') == get(hObject,'Max'))
        % Checkbox is checked
        setappdata(findobj('Tag','figDepthProfile'),'ChannelOverlap',1);
    else
        % Checkbox is not checked
        setappdata(findobj('Tag','figDepthProfile'),'ChannelOverlap',0);        
    end    

% --- Executes during object creation, after setting all properties.
function chkboxOvCh_CreateFcn(hObject, eventdata, handles)
% hObject    handle to chkboxOvCh (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function txtdpDistance_Callback(hObject, eventdata, handles)
% hObject    handle to txtdpDistance (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of txtdpDistance as text
%        str2double(get(hObject,'String')) returns contents of txtdpDistance as a double


% --- Executes during object creation, after setting all properties.
function txtdpDistance_CreateFcn(hObject, eventdata, handles)
% hObject    handle to txtdpDistance (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes during object creation, after setting all properties.
function axsdpSigMate_CreateFcn(hObject, eventdata, handles)
% hObject    handle to axsdpSigMate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: place code in OpeningFcn to populate axsdpSigMate
    axes(hObject)
    pathLogo = which('SigMate-Logo');
    imshow([pathLogo '\' 'SigMate-Logo.gif'])
