function varargout = DownSampler(varargin)
% DownSampler M-file for DownSampler.fig
%      DownSampler, by itself, creates a new DownSampler or raises the existing
%      singleton*.
%
%      H = DownSampler returns the handle to a new DownSampler or the handle to
%      the existing singleton*.
%
%      DownSampler('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in DownSampler.M with the given input arguments.
%
%      DownSampler('Property','Value',...) creates a new DownSampler or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before FileConcatenator_OpeningFunction gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to DownSampler_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help DownSampler

% Last Modified by GUIDE v2.5 09-May-2012 13:06:52

% Begin initialization code - DO NOT EDIT


gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @DownSampler_OpeningFcn, ...
                   'gui_OutputFcn',  @DownSampler_OutputFcn, ...
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

% --- Executes just before DownSampler is made visible.
function DownSampler_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to DownSampler (see VARARGIN)

% Choose default command line output for DownSampler
handles.output = hObject;

set(handles.figDownSampler, 'CloseRequestFcn', 'closeGUI');

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes DownSampler wait for user response (see UIRESUME)
% uiwait(handles.figDownSampler);

%%

% --- Outputs from this function are returned to the command line.
function varargout = DownSampler_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;

%%

% --- Executes on button press in btndwsClose.
function btndwsClose_Callback(hObject, eventdata, handles)
% hObject    handle to btndwsClose (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%     delete(gcf);            %     
    closeGUI(); % Call the function from the CloseGUI.m file


%%


% --- Executes on button press in btnBrowseDS.
function btnBrowseDS_Callback(hObject, eventdata, handles)
% hObject    handle to btnBrowseDS (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
    
%     global filelist, filenames
    
    path = uigetdir(pwd,'Select a Directory'); %Select the directory and store the path at folder 
    
    if(path) % if a directory is selected
        
%         fh = findobj('Tag', 'figDownSampler');
        path=strcat(path,'\');
%         setappdata(fh, 'directoryPath', path);
        setappdata(findobj('Tag', 'figDownSampler'),'directoryPath',path);
        handle_lblPathConcatenate = findobj('Tag', 'lblPathDS'); % find the object with the Tag lblPathConcatenate and store the reference handle

        if (handle_lblPathConcatenate ~= 0) % if the above searched object found
            text = get(handle_lblPathConcatenate,'String');  % get the text of the object
            if(~(strcmp(text,'Selected Directory Path')))
                text = 'Selected Directory Path ';
            end
            newtext = strcat(text, ': ', path); % append the folder path to the content
            set(handle_lblPathConcatenate,'String',newtext); % set the new text to the control
        end

        newpath = strcat(regexprep(path,'\','/'),'/*.txt'); %replace the path with a forward slash '/'instead of a backward slash and add the file type

        dir_struct = dir(newpath);
        
        [file_names,file_index] = sortrows({dir_struct.name}');
        
        handles.file_names = file_names;
        handles.is_dir = [dir_struct.isdir];
        handles.file_index = file_index;
       
        set(findobj('Tag','lstboxContentDS'),'String',handles.file_names,...
            'Value',1);
        
        set(findobj('Tag','btnRemoveFilesDS'),'Enable','On');

        guidata(hObject,handles);
    else %if the directory selection dialog is cancelled
        
        msgbox('Please Select a Directory for Analysis', 'Directory Not Selected','Error');
    end
        


%%


% --- Executes on selection change in lstboxContentDS.
function lstboxContentDS_Callback(hObject, eventdata, handles)
% hObject    handle to lstboxContentDS (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = get(hObject,'String') returns lstboxContentDS contents as cell array
%        contents{get(hObject,'Value')} returns selected item from lstboxContentDS

%     listbox_contents = get(findobj('Tag', 'lstboxContentDS'), 'String');
%     selected_index = get(findobj('Tag', 'lstboxContentDS'), 'Value');
%     [fet_time, fet_data] = readData(listbox_contents{selected_index});
    
%     handles.fet_time = fet_time;
%     handles.fet_data = fet_data;
    
%     plotData(handles.fet_time, handles.fet_data,handles.axMainDS, 'Selected FET Recording', handles);
    
%     guidata(hObject, handles);

%%

% --- Executes during object creation, after setting all properties.
function lstboxContentDS_CreateFcn(hObject, eventdata, handles)
% hObject    handle to lstboxContentDS (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



%%

% --- Executes on button press in btnDownsample.
function btnDownsample_Callback(hObject, eventdata, handles)
% hObject    handle to btnDownsample (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


    fh = findobj('Tag', 'figDownSampler');

    listbox_contents = get(findobj('Tag', 'lstboxContentDS'), 'String');

%     concatenateFiles(listbox_contents, getappdata(fh,'directoryPath'),lower(outputFileType));

    dirPath = getappdata(fh,'directoryPath');
    
    samplingFreq = getappdata(fh,'SamplingFrequency');
    
    waitbarMsg ={'Please Wait...', 'Downsampling and Saving Data Files...',' '};
    h=waitbar(0,waitbarMsg,'Name','Downsampling Data Files');
    
    for i = 1:length(listbox_contents)
        fileName = listbox_contents{i};
        filePath = strcat(dirPath,fileName);
        data = load(filePath);
        FS = round(1 / (data(2,1)-data(1,1)));
        dsRate = floor(FS/samplingFreq);
        [rows,cols] = size(data);
        newData = [];
        for j=1:cols
            newData = [newData, downsample(data(:,j),dsRate)];
        end
        currDir = pwd;
        cd(dirPath);
        newFileName=['Fs=',int2str(samplingFreq),'Hz-',fileName];
        save(newFileName,'newData','-ascii','-tabs');
        cd(currDir);
        updatedWaitBarMsg={'Please Wait... Downsampling and Saving Data Files...', 'Now Saving File: ', fileName};
        waitbar(i/length(listbox_contents),h,updatedWaitBarMsg);
    end
    
    close(h)    
%%


function plotData(time, data, axesName, plotTitle, handles)
    cla(axesName);
    axes(axesName);
    
    hold on
    grid on
       
    [rows, columns]=size(data);
    
    graphColors =['y','m','c','r','g','b','k','y','m','c','r','g','b','k'];
    
    for i=1:columns
        plot(time, data(:,i), graphColors(i));
    end
    title(plotTitle);

    xlabel('Time (s)');
    ylabel('Vj (mV)');
        
    hold off
    
    legend(findobj('Tag','axMainDS'),'show');
    
%     set(legendObject,'Interpreter','none'); 

%%
% --- Executes on button press in btnRemoveFilesDS.
function btnRemoveFilesDS_Callback(hObject, eventdata, handles)
% hObject    handle to btnRemoveFilesDS (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
%%

    fh=findobj('Tag','lstboxContentDS');
    selected = get(fh,'Value'); 
    prev_str = get(fh, 'String'); 
    if ~isempty(prev_str) 
        prev_str(get(fh,'Value')) = []; 
        set(fh, 'String', prev_str, ... 
            'Value', min(selected,length(prev_str))); 
    end



% --- Executes during object creation, after setting all properties.
function figDownSampler_CreateFcn(hObject, eventdata, handles)
    %%
% hObject    handle to figDownSampler (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called


% --- Executes on button press in tblelfpZoom.
function tbZoomDS_Callback(hObject, eventdata, handles)
%%
% hObject    handle to tblelfpZoom (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of tblelfpZoom

    button_state = get(hObject,'Value');
    if button_state == get(hObject,'Max')
	% Toggle button is pressed, take appropriate action
        zoom on;
        fh = findobj('Tag','tbDataCursorDS');
        if (get(fh, 'Value')== get(fh,'Max'))
            set(fh,'Value',0);
        end
        fh = findobj('Tag','tbPanDS');
        if (get(fh, 'Value')== get(fh,'Max'))
            set(fh,'Value',0);
        end           
    elseif button_state == get(hObject,'Min')
	% Toggle button is not pressed, take appropriate action
        zoom off;
    end

% --- Executes on button press in tblelfpDataCursor.
function tbDataCursorDS_Callback(hObject, eventdata, handles)
%%
% hObject    handle to tblelfpDataCursor (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of tblelfpDataCursor

    button_state = get(hObject,'Value');
    if button_state == get(hObject,'Max')
	% Toggle button is pressed, take appropriate action
        datacursormode on;
        dcm_obj=datacursormode(findobj('Tag','figDownSampler'));
        set(dcm_obj,'UpdateFcn',@mylelfpupdatefcnDS);
        
        fh = findobj('Tag','tbZoomDS');
        if (get(fh, 'Value')== get(fh,'Max'))
            set(fh,'Value',0);
        end
        
        fh = findobj('Tag','tbPanDS');
        if (get(fh, 'Value')== get(fh,'Max'))
            set(fh,'Value',0);
        end           
    elseif button_state == get(hObject,'Min')
	% Toggle button is not pressed, take appropriate action
        datacursormode off;
    end
    
    
function txt = mylelfpupdatefcnDS(empt,event_obj)
%%
%This function is for updating the data cursor text
    pos = get(event_obj,'Position');
    txt = {['Time: ',num2str(pos(1)),' ms'],...
        ['Amplitude: ',num2str(pos(2))],' mV'};  

% --- Executes on button press in btnlelfpResetGraph.
function tbResetDS_Callback(hObject, eventdata, handles)
%%
% hObject    handle to btnlelfpResetGraph (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

    fh = findobj('Tag','tbZoomDS');
    if (get(fh, 'Value')== get(fh,'Max'))
        set(fh,'Value',0);
    end
    
    fh = findobj('Tag','tbDataCursorDS');
    if (get(fh, 'Value')== get(fh,'Max'))
        set(fh,'Value',0);
    end    
    
    fh = findobj('Tag','tbPanDS');
    if (get(fh, 'Value')== get(fh,'Max'))
        set(fh,'Value',0);
    end       
    
    datacursormode off;
    
    zoom off;
    
    pan off;
    
    axis('tight');


% --- Executes on button press in tblelfpPan.
function tbPanDS_Callback(hObject, eventdata, handles)
% hObject    handle to tblelfpPan (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of tblelfpPan

    button_state = get(hObject,'Value');
    if button_state == get(hObject,'Max')
	% Toggle button is pressed, take appropriate action
        pan on;

        
        fh = findobj('Tag','tbZoomDS');
        if (get(fh, 'Value')== get(fh,'Max'))
            set(fh,'Value',0);
        end
        fh = findobj('Tag','tbDataCursorDS');
        if (get(fh, 'Value')== get(fh,'Max'))
            set(fh,'Value',0);
        end        
    elseif button_state == get(hObject,'Min')
	% Toggle button is not pressed, take appropriate action
        pan off;
    end

%%
% --- Executes on button press in btnPlotDS.
function btnPlotDS_Callback(hObject, eventdata, handles)
%%
% hObject    handle to btnPlotDS (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

    fh=findobj('Tag','lstboxContentDS');
    content = get(fh,'String');
    selected = get(fh,'Value');
    
    dirPath = getappdata(findobj('Tag','figDownSampler'),'directoryPath');
    
    if(~isempty(dirPath))
       
        filePath = strcat(dirPath,content{selected});
        data = load(filePath);

        [rows,columns]=size(data);

        time=data(:,1);
        data=data(:,2:columns);

        plotData(time, data, findobj('Tag','axMainDS'), ['Plot of Differnt Channels of File: ',content{selected}],handles);
    else
        errordlg('Please select valid data files using the Browse button','Invalid Plot Operation');
    end

% --- Executes on selection change in pupDS.
function pupDS_Callback(hObject, eventdata, handles)
%%
% hObject    handle to pupDS (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns pupDS contents as cell array
%        contents{get(hObject,'Value')} returns selected item from pupDS

    fh = findobj('Tag','figDownSampler');
    fh_pupDS = findobj('Tag','pupDS');
    
%     contents = cellstr(get(fh_pupDS,'String'));
    selectedSF = get(fh_pupDS,'Value');
    
    if (selectedSF ~= 1)
        set(findobj('Tag','btnDownsample'),'Enable','On');
        switch selectedSF
            case 2 % 5kHz
                samplingFreq = 5000;
            case 3 % 10kHz
                samplingFreq = 10000;
            case 4 % 20kHz
                samplingFreq = 20000;
            case 5 % 50kHz
                samplingFreq = 50000;
        end
        setappdata(findobj('Tag','figDownSampler'),'SamplingFrequency',samplingFreq);
    else
        set(findobj('Tag','btnDownsample'),'Enable','Off');
        if isappdata(findobj('Tag','figDownSampler'),'SamplingFrequency')
            rmappdata(findobj('Tag','figDownSampler'),'SamplingFrequency'); 
        end
    end
    
% --- Executes during object creation, after setting all properties.
function pupDS_CreateFcn(hObject, eventdata, handles)
%%
% hObject    handle to pupDS (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes during object creation, after setting all properties.
function axsdwsSigMate_CreateFcn(hObject, eventdata, handles)
% hObject    handle to axsdwsSigMate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: place code in OpeningFcn to populate axsdwsSigMate
    axes(hObject)
    pathLogo = which('SigMate-Logo');
    imshow([pathLogo '\' 'SigMate-Logo.gif'])


