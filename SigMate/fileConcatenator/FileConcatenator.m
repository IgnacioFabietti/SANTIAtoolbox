function varargout = FileConcatenator(varargin)
% FileConcatenator M-file for FileConcatenator.fig
%      FileConcatenator, by itself, creates a new FileConcatenator or raises the existing
%      singleton*.
%
%      H = FileConcatenator returns the handle to a new FileConcatenator or the handle to
%      the existing singleton*.
%
%      FileConcatenator('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in FileConcatenator.M with the given input arguments.
%
%      FileConcatenator('Property','Value',...) creates a new FileConcatenator or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before FileConcatenator_OpeningFunction gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to FileConcatenator_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help FileConcatenator

% Last Modified by GUIDE v2.5 09-May-2012 12:59:32

% Begin initialization code - DO NOT EDIT


gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @FileConcatenator_OpeningFcn, ...
                   'gui_OutputFcn',  @FileConcatenator_OutputFcn, ...
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

% --- Executes just before FileConcatenator is made visible.
function FileConcatenator_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to FileConcatenator (see VARARGIN)

% Choose default command line output for FileConcatenator
handles.output = hObject;

set(handles.figConcatenate, 'CloseRequestFcn', 'closeGUI');

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes FileConcatenator wait for user response (see UIRESUME)
% uiwait(handles.figConcatenate);

%%

% --- Outputs from this function are returned to the command line.
function varargout = FileConcatenator_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;

%%

% --- Executes on button press in btnfcClose.
function btnfcClose_Callback(hObject, eventdata, handles)
% hObject    handle to btnfcClose (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%     delete(gcf);
    closeGUI(); % Call the function from the CloseGUI.m file


%%


% --- Executes on button press in btnBrowseConcatenate.
function btnBrowseConcatenate_Callback(hObject, eventdata, handles)
% hObject    handle to btnBrowseConcatenate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
    
%     global filelist, filenames
    
    fh = findobj('Tag','figConcatenate');
    if (isappdata(fh, 'directoryPath'))
        browseDir = getappdata(fh, 'directoryPath');
        path = uigetdir(browseDir,'Select a Directory'); %Select the directory and store the path at folder 
    else
        path = uigetdir([pwd '\'],'Select a Directory'); %Select the directory and store the path at folder        
    end
    
    if(path) % if a directory is selected
        
%         fh = findobj('Tag', 'figConcatenate');
        path=strcat(path,'\');
%         setappdata(fh, 'directoryPath', path);
        setappdata(findobj('Tag', 'figConcatenate'),'directoryPath',path);
        handle_lblPathConcatenate = findobj('Tag', 'lblPathConcatenate'); % find the object with the Tag lblPathConcatenate and store the reference handle

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
       
        set(findobj('Tag','lstboxContentConcatenate'),'String',handles.file_names,...
            'Value',1);
        
        set(findobj('Tag','btnRemoveFilesConcatenate'),'Enable','On');
        set(findobj('Tag','btnConcatenate'),'Enable','On');
        set(findobj('Tag','btnPlotConcatenated'),'Enable','On');   
        
        set(findobj('Tag','radiobtnWinW'),'Value',1);
        guidata(hObject,handles);
    else %if the directory selection dialog is cancelled
        
        msgbox('Please Select a Directory for Analysis', 'Directory Not Selected','Error');
    end
        


%%


% --- Executes on selection change in lstboxContentConcatenate.
function lstboxContentConcatenate_Callback(hObject, eventdata, handles)
% hObject    handle to lstboxContentConcatenate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = get(hObject,'String') returns lstboxContentConcatenate contents as cell array
%        contents{get(hObject,'Value')} returns selected item from lstboxContentConcatenate

    listbox_contents = get(findobj('Tag', 'lstboxContentConcatenate'), 'String');
    selected_index = get(findobj('Tag', 'lstboxContentConcatenate'), 'Value');
    dirPath=getappdata(findobj('Tag','figConcatenate'),'directoryPath');
    data=load([dirPath, listbox_contents{selected_index}]);

    plot(data(:,1), data(:,2:end));
    

%%

% --- Executes during object creation, after setting all properties.
function lstboxContentConcatenate_CreateFcn(hObject, eventdata, handles)
% hObject    handle to lstboxContentConcatenate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



%%

% --- Executes on button press in btnConcatenate.
function btnConcatenate_Callback(hObject, eventdata, handles)
% hObject    handle to btnConcatenate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%     listbox_contents = get(findobj('Tag', 'lstboxContentConcatenate'), 'String');
%     selected_index = get(findobj('Tag', 'lstboxContentConcatenate'), 'Value');
%     filename = contents{selected_index};
    
%     [averaged_time, averaged_data, odd_averaged_data, even_averaged_data] = readandAverageData(listbox_contents);

%     handles.averaged_time = averaged_time;
%     handles.averaged_data = averaged_data;
%     handles.odd_data = odd_averaged_data;
%     handles.even_data = even_averaged_data;
%     guidata(hObject, handles); 
%     hold on;
    fh = findobj('Tag', 'figConcatenate');

    listbox_contents = get(findobj('Tag', 'lstboxContentConcatenate'), 'String');
    if (get(findobj('Tag','radiobtnWinW'),'Value')==1)
        outputFileType = 'WinW';
    elseif(get(findobj('Tag','radiobtnClampFit'),'Value')==1)
        outputFileType = 'ClampFit';
    end
    
    saveFileName = concatenateFiles(listbox_contents, getappdata(fh,'directoryPath'),lower(outputFileType));
    
    setappdata(fh, 'concatenatedFile', saveFileName);
    
    
%     time = getappdata(fh, 'fet_time');
%     data = getappdata(fh, 'fet_data');    

%     [averaged_time, averaged_data] = processData(time, data, 'Average');
%     processData(time, data, 'Average');   
    
%     plotData(getappdata(fh,'averaged_time'),getappdata(fh,'averaged_data'),handles.axMainConcatenate, 'Average of FET Recordings', fh);
%     plotData(handles.averaged_time, handles.odd_data, handles.axMainConcatenate, 'odd');
%     plotData(handles.averaged_time, handles.even_data, handles.axMainConcatenate, 'even');
%     hold off;
    
    
    
%%


% --- Executes on button press in btnConcatenateHz.
function btnConcatenateHz_Callback(hObject, eventdata, handles)
%%
% hObject    handle to btnConcatenateHz (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

    fh = findobj('Tag', 'figConcatenate');

    listbox_contents = get(findobj('Tag', 'lstboxContentConcatenate'), 'String');
    
    directoryPath=getappdata(fh,'directoryPath');
    
    data=load([directoryPath listbox_contents{1}]);
    
    [~, nc]=size(data);
    
    resp = questdlg({['Your selected data file contains ' num2str(nc-1) ' data columns'], 'Do you want to continue with the concatenation?'},'Confirm Concatenation');
    
    switch resp
        case 'Yes'
    
            saveFileName = concatenateColumns(listbox_contents, directoryPath);
            
            setappdata(fh, 'concatenatedFile', saveFileName);                       
    end


%%

% --- Executes on button press in btnPlotConcatenated.
function btnPlotConcatenated_Callback(hObject, eventdata, handles)
% hObject    handle to btnPlotConcatenated (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

   fh = findobj('Tag', 'figConcatenate');
   
   if ~isappdata(fh, 'concatenatedFile')
       
       errordlg('File Concatenation is not Yet Done','File Fetching Error');
       
   else
   
       fileName = getappdata(fh, 'concatenatedFile');

       cla(handles.axMainConcatenate)

       data=load([getappdata(fh,'directoryPath') fileName]);
       
       t=data(:,1);
       
       [~, n] = size(data);

       if n>2
           hold on;
           for i=2:n
               plot(t, data(:,i));
           end
           hold off;
       else
           plot(t,data(:,2))           
       end 
       axis('tight')
       xlabel('Time (s)');
       ylabel('Amplitude (mV)');
       title('Concatenated File')
   end
%     selected_index = get(findobj('Tag', 'lstboxContentConcatenate'), 'Value');
%     filename = contents{selected_index};
    
%     [averaged_time, averaged_data, odd_averaged_data, even_averaged_data] = rootMeanSquare(listbox_contents);
% 
%     handles.averaged_time = averaged_time;
%     handles.averaged_data = averaged_data;
%     handles.odd_data = odd_averaged_data;
%     handles.even_data = even_averaged_data;
%     guidata(hObject, handles); 
% %     hold on;
%     plotData(handles.averaged_time, handles.averaged_data,handles.axMainConcatenate, 'Root Mean Square of FET Recordings', handles);



%%


% function processData(time, data, flagString)
% 
%     
%     time = time';
%     data = data';
%     switch lower(flagString)
%         case 'average'
%             processed_time = sum(time)/length(time); % calculates the average of time
%             processed_data = sum(data)/length(data); % calculates the average of data points
%             
%             fh = findobj('Tag', 'figConcatenate');
% %             fh.averaged_time = processed_time'; % stores in the figure handle using the variable averaged_time
% %             fh.averaged_data = processed_data'; % stores in the figure handle using the variable averaged_data
% 
%             setappdata(fh, 'averaged_time', processed_time');
%             setappdata(fh, 'averaged_data', processed_data');            
%             
% 
%             odd_data = sum(data(:,1:2:length(data)))/(length(data)/2);
%             even_data = sum(data(:,2:2:length(data)))/(length(data)/2);
%             
% %             fh.odd_data = odd_data'; % stores the odd data points average in the figure handle using the variable odd_average
% %             fh.even_data = even_data'; % stores the even data points average in the figure handle using the variable even_average           
% 
%             setappdata(fh, 'odd_data', odd_data');
%             setappdata(fh, 'even_data', even_data');                
% %             guidata(fh, handles);
%     end
%     

    %%



% --- Executes on button press in btnRemoveFilesConcatenate.
function btnRemoveFilesConcatenate_Callback(hObject, eventdata, handles)
% hObject    handle to btnRemoveFilesConcatenate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
%%

    fh=findobj('Tag','lstboxContentConcatenate');
    selected = get(fh,'Value'); 
    prev_str = get(fh, 'String'); 
    if ~isempty(prev_str) 
        prev_str(get(fh,'Value')) = []; 
        set(fh, 'String', prev_str, ... 
            'Value', min(selected,length(prev_str))); 
    end



% --- Executes during object creation, after setting all properties.
function figConcatenate_CreateFcn(hObject, eventdata, handles)
    %%
% hObject    handle to figConcatenate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called


% --- Executes on button press in radiobtnWinW.
function radiobtnWinW_Callback(hObject, eventdata, handles)
%%
% hObject    handle to radiobtnWinW (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of radiobtnWinW

    fh = findobj('Tag','radiobtnClampFit');
    
    if(get(findobj('Tag','radiobtnClampFit'),'Value')==1 && get(findobj('Tag','radiobtnWinW'),'Value')==0)
        set(findobj('Tag','radiobtnClampFit'),'Value',0);
        set(findobj('Tag','radiobtnWinW'),'Value',1);
    else
        set(findobj('Tag','radiobtnWinW'),'Value',1);        
        set(findobj('Tag','radiobtnClampFit'),'Value',0);        
    end

    guidata(fh,handles);


% --- Executes on button press in radiobtnClampFit.
function radiobtnClampFit_Callback(hObject, eventdata, handles)
%%
% hObject    handle to radiobtnClampFit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of radiobtnClampFit

    fh = findobj('Tag','radiobtnWinW');
    
    if(get(findobj('Tag','radiobtnWinW'),'Value') == 1 && get(findobj('Tag','radiobtnClampFit'),'Value') == 0)
        set(findobj('Tag','radiobtnWinW'),'Value',0);
        set(findobj('Tag','radiobtnClampFit'),'Value',1);
    else
        set(findobj('Tag','radiobtnClampFit'),'Value',1);  
        set(findobj('Tag','radiobtnWinW'),'Value',0);        
    end
       
    guidata(fh,handles);



% --- Executes on button press in tbZoomConcatenate.
function tbZoomConcatenate_Callback(hObject, eventdata, handles)
%%
% hObject    handle to tbZoomConcatenate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of tbZoomConcatenate

    button_state = get(hObject,'Value');
    if button_state == get(hObject,'Max')
	% Toggle button is pressed, take appropriate action
        zoom on;
        fh = findobj('Tag','tbDataCursorConcatenate');
        if (get(fh, 'Value')== get(fh,'Max'))
            set(fh,'Value',0);
        end
    elseif button_state == get(hObject,'Min')
	% Toggle button is not pressed, take appropriate action
        zoom off;
    end
    
% --- Executes on button press in tbDataCursorConcatenate.
function tbDataCursorConcatenate_Callback(hObject, eventdata, handles)
%%
% hObject    handle to tbDataCursorConcatenate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of tbDataCursorConcatenate
    button_state = get(hObject,'Value');
    if button_state == get(hObject,'Max')
	% Toggle button is pressed, take appropriate action
        datacursormode on;
        dcm_obj=datacursormode(findobj('Tag','figBaselineCorrector'));
        set(dcm_obj,'UpdateFcn',@myupdatefcnConcatenate);
        
        fh = findobj('Tag','tbZoomConcatenate');
        if (get(fh, 'Value')== get(fh,'Max'))
            set(fh,'Value',0);
        end
    elseif button_state == get(hObject,'Min')
	% Toggle button is not pressed, take appropriate action
        datacursormode off;
    end
    
    
function txt = myupdatefcnConcatenate(empt,event_obj)
%%
%This function is for updating the data cursor text
    pos = get(event_obj,'Position');
    txt = {['Time: ',num2str(pos(1)),' ms'],...
        ['Amplitude: ',num2str(pos(2))],' mV'};  

% --- Executes on button press in btnResetGraphConcatenate.
function btnResetGraphConcatenate_Callback(hObject, eventdata, handles)
%%
% hObject    handle to btnResetGraphConcatenate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

    fh = findobj('Tag','tbZoomConcatenate');
    if (get(fh, 'Value')== get(fh,'Max'))
        set(fh,'Value',0);
    end
    
    fh = findobj('Tag','tbDataCursorConcatenate');
    if (get(fh, 'Value')== get(fh,'Max'))
        set(fh,'Value',0);
    end    
    
    datacursormode off;
    
    zoom off;
    
    axis('tight');


% --- Executes during object creation, after setting all properties.
function axscnSigMate_CreateFcn(hObject, eventdata, handles)
% hObject    handle to axscnSigMate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: place code in OpeningFcn to populate axscnSigMate
    axes(hObject)
    pathLogo = which('SigMate-Logo');
    imshow([pathLogo '\' 'SigMate-Logo.gif'])
