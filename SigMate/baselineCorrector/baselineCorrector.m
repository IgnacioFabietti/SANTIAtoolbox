function varargout = baselineCorrector(varargin)
% BASELINECORRECTOR M-file for baselineCorrector.fig
%      BASELINECORRECTOR, by itself, creates a new BASELINECORRECTOR or raises the existing
%      singleton*.
%
%      H = BASELINECORRECTOR returns the handle to a new BASELINECORRECTOR or the handle to
%      the existing singleton*.
%
%      BASELINECORRECTOR('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in BASELINECORRECTOR.M with the given input arguments.
%
%      BASELINECORRECTOR('Property','Value',...) creates a new BASELINECORRECTOR or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before baselineCorrector_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to baselineCorrector_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help baselineCorrector

% Last Modified by GUIDE v2.5 04-May-2012 17:50:14

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @baselineCorrector_OpeningFcn, ...
                   'gui_OutputFcn',  @baselineCorrector_OutputFcn, ...
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


% --- Executes just before baselineCorrector is made visible.
function baselineCorrector_OpeningFcn(hObject, eventdata, handles, varargin)
    %%
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to baselineCorrector (see VARARGIN)

% Choose default command line output for baselineCorrector
handles.output = hObject;

set(handles.figBaselineCorrector, 'CloseRequestFcn', 'closeGUI');

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes baselineCorrector wait for user response (see UIRESUME)
% uiwait(handles.figBaselineCorrector);


% --- Outputs from this function are returned to the command line.
function varargout = baselineCorrector_OutputFcn(hObject, eventdata, handles) 
    %%
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;

% --- Executes when user attempts to close figBaselineCorrector.
function figBaselineCorrector_CloseRequestFcn(hObject, eventdata, handles)
    %%
% hObject    handle to figBaselineCorrector (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
    closeGUI();
% Hint: delete(hObject) closes the figure
delete(hObject);

% --- Executes on button press in btnClose.
function btnClose_Callback(hObject, eventdata, handles)
    %%
% hObject    handle to btnClose (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

    closeGUI();


% --- Executes on button press in btnbcBrowse.
function btnbcBrowse_Callback(hObject, eventdata, handles)
    %%
% hObject    handle to btnbcBrowse (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

    %clear if any application data exists
    
    fh = findobj('Tag', 'figBaselineCorrector');    
    
    path = uigetdir('D:\MatlabWorks','Select a Directory'); %Select the directory and store the path at folder 
    
    if(path) % if a directory is selected
        
        setappdata(fh, 'directoryPath', strcat(path,'\'));
        handle_lblbcPath = findobj('Tag', 'lblbcPath'); % find the object with the Tag lblPath and store the reference handle

        if (handle_lblbcPath ~= 0) % if the above searched object found
            text = get(handle_lblbcPath,'String');  % get the text of the object
            if(~(strcmp(text,'Selected Directory Path')))
                text = 'Selected Directory Path';
            end
            newtext = strcat(text, ': ', path); % append the folder path to the content
            set(handle_lblbcPath,'String',newtext); % set the new text to the control
        end

        newpath = strcat(regexprep(path,'\','/'),'/*.txt'); %replace the path with a forward slash '/'instead of a backward slash and add the file type

        dir_struct = dir(newpath);
        [file_names,file_index] = sortrows({dir_struct.name}');
        handles.file_names = file_names;
        handles.is_dir = [dir_struct.isdir];
        handles.file_index = file_index;
        guidata(hObject,handles);
        setappdata(fh,'fileNames',file_names);
        set(findobj('Tag','lstboxbcContent'),'String',handles.file_names,...
            'Value',1);
        set(findobj('Tag','btnbcFix'),'Enable', 'On');
       
        set(findobj('Tag','btnbcRemoveFiles'),'Enable', 'On');

        set(findobj('Tag','chkboxbcIm'),'Enable', 'On');
        set(findobj('Tag','chkboxbcVm'),'Enable', 'On');
        set(findobj('Tag','chkboxbcStimulus'),'Enable', 'On');
        set(findobj('Tag','chkboxbcVj'),'Enable', 'On');
        set(findobj('Tag','chkboxbcVavg'),'Enable', 'On'); 
        set(findobj('Tag', 'txtThreshold'),'Enable','Off');        
        
    else %if the directory selection dialog is cancelled
        
        msgbox('Please Select a Directory for Analysis', 'Directory Not Selected','Error');
    end



% --- Executes on selection change in lstboxbcContent.
function lstboxbcContent_Callback(hObject, eventdata, handles)
    %%
% hObject    handle to lstboxbcContent (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = get(hObject,'String') returns lstboxbcContent contents as cell array
%        contents{get(hObject,'Value')} returns selected item from lstboxbcContent

    listbox_contents = get(findobj('Tag', 'lstboxbcContent'), 'String');
    selected_index = get(findobj('Tag', 'lstboxbcContent'), 'Value');
    fh = findobj('Tag','figBaselineCorrector');
    setappdata(fh,'selectedFileName',listbox_contents{selected_index});
    
    
    [checkedColumns, flag] = selectedColumns();
%     checkedColumns = getappdata(fh, 'checkedColumns');
    
    if(flag)  
        set(findobj('Tag', 'txtThreshold'),'Enable','On');
        filePath = getappdata(fh, 'directoryPath');
        [fet_time, fet_data] = readData(filePath, listbox_contents{selected_index}, checkedColumns);
        setappdata(fh,'fet_time',fet_time);
        setappdata(fh,'fet_data',fet_data);        
        color = {'r','g','b','c','m','y','k'};        
        cla(findobj('Tag','axbcMain'));
%         axes(findobj('Tag','axMain'));
        columns = length(checkedColumns);
        hold on
        for i=1:1:columns-1
%             subplot(columns-1,1,i);
            plot(fet_time, fet_data(:,i),color{i});
            title(['Plot of Selected Column: ',num2str(i)]);
        end
        axis('tight');
        hold off
        grid on
    end
    

% --- Executes during object creation, after setting all properties.
function lstboxbcContent_CreateFcn(hObject, eventdata, handles)
    %%
% hObject    handle to lstboxbcContent (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in btnbcFix.
function btnbcFix_Callback(hObject, eventdata, handles)
    %%
% hObject    handle to btnbcFix (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

    try    
%     fh_threshold = findobj('Tag','txtThreshold');
%     threshold=str2double(get(fh_threshold,'String')); %returns contents ...
                                %of txtThreshold as text and then to double
    fh = findobj('Tag','figBaselineCorrector');
    time = getappdata(fh,'fet_time');
    data = getappdata(fh,'fet_data');
% %     [mintab, maxtab]=peakdet(data,threshold,time);
%     [mintab, maxtab]=peakdet(data,std(data)*0.7,time);
% %     figure; hold on; plot(mintab(:,2),'r'); plot(maxtab(:,2),'g'); hold off;
%     minavg=sum(mintab(:,2))/length(mintab(:,2));
%     maxavg=sum(maxtab(:,2))/length(maxtab(:,2));
%     peakAvg=(minavg+maxavg)/2;
%     dataAvg=data - peakAvg;

    dataAvg = data - mean(data);
    
    figure('Name','SigMate: Baseline Corrected Signal','NumberTitle','off');        
    subplot(2,1,1);
    plot(time, data,'r');
    title('Signal Before Baseline Correction');
    xlabel('Time (S)')
    ylabel('Amplitude (mV)')
    subplot(2,1,2);
    plot(time, dataAvg,'g');    
    title('Signal After Baseline Correction');
    xlabel('Time (S)')
    ylabel('Amplitude (mV)')
    
    directoryPath=getappdata(fh,'directoryPath');
    oldPath=pwd;
    cd(directoryPath);
    datafile=[]; %#ok
    dataFile = [time, dataAvg]; %#ok
    fileName = getappdata(fh,'selectedFileName');
    save(['bc-',fileName], 'dataFile','-ASCII','-tabs');    
    cd(oldPath);
    catch %#ok
        errordlg('There were errors in evaluating your request with the specified Threshold','Threshold Error');
    end

% --- Executes on button press in btnbcRemoveFiles.
function btnbcRemoveFiles_Callback(hObject, eventdata, handles)
    %%
% hObject    handle to btnbcRemoveFiles (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

    fh=findobj('Tag','lstboxbcContent');
    selected = get(fh,'Value'); 
    prev_str = get(fh, 'String'); 
    if ~isempty(prev_str) 
        prev_str(get(fh,'Value')) = []; 
        set(fh, 'String', prev_str, ... 
            'Value', min(selected,length(prev_str))); 
        setappdata(findobj('Tag','figBaselineCorrector'),'fileNames',prev_str);
    end
% --- Executes on selection change in pumbcRecType.

function [checkedColumns, flag] = selectedColumns()
%%
    
    figure_handle = findobj('Tag', 'figBaselineCorrector');
      
    flag=0;
    
    checkedColumns=[1]; %#ok<NBRAK>
    if(isequal(getappdata(figure_handle,'signalType'),2)) %if signal source is In-vivo recording    
        if(length(checkedColumns)<2)
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
        else
            errordlg('You cannot fix baseline for more than one channel at a time','Baseline Correction Error');
            flag=0;
        end
        setappdata(figure_handle,'checkedColumns',checkedColumns);
    elseif(isequal(getappdata(figure_handle,'signalType'),3)) %if signal source is Transistor recording
        if(length(checkedColumns)<2)        
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
        else
            errordlg('You cannot fix baseline for more than one channel at a time','Baseline Correction Error');
            flag=0;
        end        
        setappdata(figure_handle,'checkedColumns',checkedColumns);        
    elseif(isequal(getappdata(figure_handle,'signalType'),1)) % if nothing is selected
        msgbox('Please select the Channels','Channels not Selected','Error');
    end
    
    if (length(checkedColumns)==1 && flag)
        msgbox('Please Select the Channel of Data','Channel Not Selected', 'Error');
        flag = 0;
    end


function pumbcRecType_Callback(hObject, eventdata, handles)
    %%
% hObject    handle to pumbcRecType (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = get(hObject,'String') returns pumbcRecType contents as cell array
%        contents{get(hObject,'Value')} returns selected item from pumbcRecType

    selectedValue = get(hObject, 'Value');

    setappdata(findobj('Tag','figBaselineCorrector'),'signalType',selectedValue);

    switch selectedValue
        case 2 % if the In-Vivo recording is selected
            set(findobj('Tag', 'btnbcBrowse'), 'Enable', 'On');

            set(findobj('Tag', 'chkboxbcVm'), 'Visible', 'On');
            set(findobj('Tag', 'chkboxbcVm'), 'String', 'VmDC');        
            set(findobj('Tag', 'chkboxbcIm'), 'Visible', 'On');    
            set(findobj('Tag', 'chkboxbcStimulus'), 'Visible', 'On');        
            set(findobj('Tag', 'chkboxbcIm'), 'String', 'VmAC');        
            set(findobj('Tag', 'chkboxbcVj'), 'Visible', 'Off');  
            set(findobj('Tag', 'chkboxbcVavg'), 'Visible', 'Off');          

        case 3 % if the Transistor recording is selected
            set(findobj('Tag', 'chkboxbcIm'), 'Visible', 'On');  
            set(findobj('Tag', 'chkboxbcIm'), 'String', 'Im');                
            set(findobj('Tag', 'chkboxbcVm'), 'Visible', 'On');  
            set(findobj('Tag', 'chkboxbcVm'), 'String', 'Vm');                
            set(findobj('Tag', 'chkboxbcVj'), 'Visible', 'On');  
            set(findobj('Tag', 'chkboxbcVavg'), 'Visible', 'On');  
            set(findobj('Tag', 'chkboxbcStimulus'), 'Visible', 'Off');         

            set(findobj('Tag', 'btnbcBrowse'), 'Enable', 'On');        
        otherwise % if nothing is selected
            msgbox('Please Select a Signal Source', 'Signal Source Not Selected','Error');
            set(findobj('Tag', 'btnbcBrowse'), 'Enable', 'Off');
            set(findobj('Tag', 'chkboxbcIm'), 'Visible', 'Off');  
            set(findobj('Tag', 'chkboxbcVm'), 'Visible', 'Off');  
            set(findobj('Tag', 'chkboxbcVj'), 'Visible', 'Off');  
            set(findobj('Tag', 'chkboxbcVavg'), 'Visible', 'Off'); 
            set(findobj('Tag', 'chkboxbcStimulus'), 'Visible', 'Off');         
    end
% --- Executes during object creation, after setting all properties.

function pumbcRecType_CreateFcn(hObject, eventdata, handles)
    %%
% hObject    handle to pumbcRecType (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function txtThreshold_Callback(hObject, eventdata, handles)
    %%
% hObject    handle to txtThreshold (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of txtThreshold as text
%        str2double(get(hObject,'String')) returns contents of txtThreshold as a double


% --- Executes during object creation, after setting all properties.
function txtThreshold_CreateFcn(hObject, eventdata, handles)
    %%
% hObject    handle to txtThreshold (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in chkboxbcIm.
function chkboxbcIm_Callback(hObject, eventdata, handles)
    %%
% hObject    handle to chkboxbcIm (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of chkboxbcIm

    if (get(hObject,'Value') == get(hObject,'Max'))
        % Checkbox is checked
        setappdata(findobj('Tag','figBaselineCorrector'),'Im',1);
    else
        % Checkbox is not checked
        setappdata(findobj('Tag','figBaselineCorrector'),'Im',0);        
    end    

% --- Executes on button press in chkboxbcVm.
function chkboxbcVm_Callback(hObject, eventdata, handles)
    %%
% hObject    handle to chkboxbcVm (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of chkboxbcVm

    if (get(hObject,'Value') == get(hObject,'Max'))
        % Checkbox is checked
        setappdata(findobj('Tag','figBaselineCorrector'),'Vm',1);
    else
        % Checkbox is not checked
        setappdata(findobj('Tag','figBaselineCorrector'),'Vm',0);        
    end    
% --- Executes on button press in chkboxbcStimulus.
function chkboxbcStimulus_Callback(hObject, eventdata, handles)
    %%
% hObject    handle to chkboxbcStimulus (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of chkboxbcStimulus

    if (get(hObject,'Value') == get(hObject,'Max'))
        % Checkbox is checked
        setappdata(findobj('Tag','figBaselineCorrector'),'Stimulus',1);
    else
        % Checkbox is not checked
        setappdata(findobj('Tag','figBaselineCorrector'),'Stimulus',0);        
    end    
% --- Executes on button press in chkboxbcVj.
function chkboxbcVj_Callback(hObject, eventdata, handles)
    %%
% hObject    handle to chkboxbcVj (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of chkboxbcVj

    if (get(hObject,'Value') == get(hObject,'Max'))
        % Checkbox is checked
        setappdata(findobj('Tag','figBaselineCorrector'),'Vj',1);
    else
        % Checkbox is not checked
        setappdata(findobj('Tag','figBaselineCorrector'),'Vj',0);        
    end    
% --- Executes on button press in chkboxbcVavg.
function chkboxbcVavg_Callback(hObject, eventdata, handles)
    %%
% hObject    handle to chkboxbcVavg (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of chkboxbcVavg
    if (get(hObject,'Value') == get(hObject,'Max'))
        % Checkbox is checked
        setappdata(findobj('Tag','figBaselineCorrector'),'Vavg',1);
    else
        % Checkbox is not checked
        setappdata(findobj('Tag','figBaselineCorrector'),'Vavg',0);        
    end    


% --- Executes on button press in tbbcZoom.
function tbbcZoom_Callback(hObject, eventdata, handles)
%%
% hObject    handle to tbbcZoom (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of tbbcZoom

    button_state = get(hObject,'Value');
    if button_state == get(hObject,'Max')
	% Toggle button is pressed, take appropriate action
        zoom on;
        fh = findobj('Tag','tbbcDataCursor');
        if (get(fh, 'Value')== get(fh,'Max'))
            set(fh,'Value',0);
        end
        fh = findobj('Tag','tbbcPan');
        if (get(fh, 'Value')== get(fh,'Max'))
            set(fh,'Value',0);
        end           
    elseif button_state == get(hObject,'Min')
	% Toggle button is not pressed, take appropriate action
        zoom off;
    end

% --- Executes on button press in tbbcDataCursor.
function tbbcDataCursor_Callback(hObject, eventdata, handles)
%%
% hObject    handle to tbbcDataCursor (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of tbbcDataCursor

    button_state = get(hObject,'Value');
    if button_state == get(hObject,'Max')
	% Toggle button is pressed, take appropriate action
        datacursormode on;
        dcm_obj=datacursormode(findobj('Tag','figBaselineCorrector'));
        set(dcm_obj,'UpdateFcn',@mybcupdatefcn);
        
        fh = findobj('Tag','tbbcZoom');
        if (get(fh, 'Value')== get(fh,'Max'))
            set(fh,'Value',0);
        end
        
        fh = findobj('Tag','tbbcPan');
        if (get(fh, 'Value')== get(fh,'Max'))
            set(fh,'Value',0);
        end           
    elseif button_state == get(hObject,'Min')
	% Toggle button is not pressed, take appropriate action
        datacursormode off;
    end
    
    
function txt = mybcupdatefcn(empt,event_obj)
%%
%This function is for updating the data cursor text
    pos = get(event_obj,'Position');
    txt = {['Time: ',num2str(pos(1)),' ms'],...
        ['Amplitude: ',num2str(pos(2))],' mV'};  

% --- Executes on button press in btnbcResetGraph.
function btnbcResetGraph_Callback(hObject, eventdata, handles)
%%
% hObject    handle to btnbcResetGraph (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

    fh = findobj('Tag','tbbcZoom');
    if (get(fh, 'Value')== get(fh,'Max'))
        set(fh,'Value',0);
    end
    
    fh = findobj('Tag','tbbcDataCursor');
    if (get(fh, 'Value')== get(fh,'Max'))
        set(fh,'Value',0);
    end    
    
    fh = findobj('Tag','tbbcPan');
    if (get(fh, 'Value')== get(fh,'Max'))
        set(fh,'Value',0);
    end       
    
    datacursormode off;
    
    zoom off;
    
    pan off;
    
    axis('tight');


% --- Executes on button press in tbbcPan.
function tbbcPan_Callback(hObject, eventdata, handles)
% hObject    handle to tbbcPan (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of tbbcPan

    button_state = get(hObject,'Value');
    if button_state == get(hObject,'Max')
	% Toggle button is pressed, take appropriate action
        pan on;

        
        fh = findobj('Tag','tbbcZoom');
        if (get(fh, 'Value')== get(fh,'Max'))
            set(fh,'Value',0);
        end
        fh = findobj('Tag','tbbcDataCursor');
        if (get(fh, 'Value')== get(fh,'Max'))
            set(fh,'Value',0);
        end        
    elseif button_state == get(hObject,'Min')
	% Toggle button is not pressed, take appropriate action
        pan off;
    end


% --- Executes during object creation, after setting all properties.
function axsbcSigMate_CreateFcn(hObject, eventdata, handles)
% hObject    handle to axsbcSigMate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: place code in OpeningFcn to populate axsbcSigMate
    axes(hObject)
    pathLogo = which('SigMate-Logo');
    imshow([pathLogo '\' 'SigMate-Logo.gif'])