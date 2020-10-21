function varargout = lfpSorting(varargin)
% LFPSORTING M-file for lfpSorting.fig
%      LFPSORTING, by itself, creates a new LFPSORTING or raises the existing
%      singleton*.
%
%      H = LFPSORTING returns the handle to a new LFPSORTING or the handle to
%      the existing singleton*.
%
%      LFPSORTING('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in LFPSORTING.M with the given input arguments.
%
%      LFPSORTING('Property','Value',...) creates a new LFPSORTING or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before FirstGUI_OpeningFunction gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to lfpSorting_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help lfpSorting

% Last Modified by GUIDE v2.5 04-May-2012 18:18:23

% Begin initialization code - DO NOT EDIT


gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @lfpSorting_OpeningFcn, ...
                   'gui_OutputFcn',  @lfpSorting_OutputFcn, ...
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

% --- Executes just before lfpSorting is made visible.
function lfpSorting_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to lfpSorting (see VARARGIN)

% Choose default command line output for lfpSorting
handles.output = hObject;

pathToAdd = which('lfpSorting');
pathToAdd = [pathToAdd(1:end-(length('lfpSorting.m')+1)) '\functions' ];

addpath(pathToAdd);

fh = findobj('Tag', 'figlfpsMain');
setappdata(fh, 'addedPath',pathToAdd);

set(handles.figlfpsMain, 'CloseRequestFcn', 'closeGUI');

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes lfpSorting wait for user response (see UIRESUME)
% uiwait(handles.figlfpsMain);

%%

% --- Outputs from this function are returned to the command line.
function varargout = lfpSorting_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;

%%

% --- Executes on button press in btnlfpsClose.
function btnlfpsClose_Callback(hObject, eventdata, handles)
% hObject    handle to btnlfpsClose (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

    fh = findobj('Tag', 'figlfpsMain');
    fullPath=getappdata(fh, 'addedPath');
    
    closeGUI(); % Call the function from the CloseGUI.m file
    
    rmpath(fullPath)    


%%


% --- Executes on button press in btnlfpsBrowse.
function btnlfpsBrowse_Callback(hObject, eventdata, handles)
% hObject    handle to btnlfpsBrowse (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
    
%     global filelist, filenames
    
    %clear if any application data exists
    
    fh = findobj('Tag', 'figlfpsMain');    
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
    
    if(path) % if a directory is selected
        
        setappdata(fh, 'directoryPath', strcat(path,'\'));
        handle_lblPath = findobj('Tag', 'lbllfpsPath'); % find the object with the Tag lbllfpsPath and store the reference handle

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
        [timeStamp,timeIndex]=sortrows({dir_struct.date}');
        
%         [file_names,file_index] = sortrows({dir_struct.name}');
  
        file_names={};
        for indx = 1:length(timeStamp)
            file_names{indx}=dir_struct(timeIndex(indx)).name;
        end
        
        file_names=file_names';
        handles.file_names = file_names;
        handles.is_dir = [dir_struct.isdir];

        guidata(hObject,handles);        
        setappdata(fh,'fileNames',file_names);
        set(findobj('Tag','lstboxlfpsContent'),'String',handles.file_names,...
            'Value',1);
        set(findobj('Tag','btnlfpsLoad'),'Enable', 'On');
        set(findobj('Tag','btnlfpsLoad'),'String', 'Load Data Files');        
        set(findobj('Tag','btnlfpsRemoveFile'),'Enable', 'On');
        set(findobj('Tag','btnlfpsMoveUp'),'Enable', 'On');
        set(findobj('Tag','btnlfpsMoveDown'),'Enable', 'On');        
        set(findobj('Tag','chkboxlfpsCh1'),'Enable', 'On');
        set(findobj('Tag','chkboxlfpsCh2'),'Enable', 'On');
        set(findobj('Tag','chkboxlfpsCh3'),'Enable', 'On');
        set(findobj('Tag','chkboxlfpsCh4'),'Enable', 'On');
        set(findobj('Tag','chkboxlfpsCh5'),'Enable', 'On');
        set(findobj('Tag','btnlfpsSort'),'Enable', 'Off')        
        
        % set initial waveform recognition technique to Contour Method
        fh=findobj('Tag','figlfpsMain');
        set(findobj('Tag','rblfpsContour'),'Value', 1);
        set(findobj('Tag','rblfpsMatchedFilter'),'Value', 0);
        selectedMatchingMethod=1;
        setappdata(fh,'selectedMatchingMethod',selectedMatchingMethod);
        
        % set initial clustering technique to K-Means        
        rblfpsKMeans_Callback(hObject, eventdata, handles);
        
        % set initial distance calculation method to Euclidean Distance
        rblfpsEuclideanDistance_Callback(hObject, eventdata, handles);   
        
        % display the first signal in the axis
        lstboxlfpsContent_Callback(hObject, eventdata, handles)        
      
    else %if the directory selection dialog is cancelled
        
        msgbox('Please Select a Directory for Analysis', 'Directory Not Selected','Error');
    end

    listbox_contents = get(findobj('Tag', 'lstboxlfpsContent'), 'String');
    selected_index = get(findobj('Tag', 'lstboxlfpsContent'), 'Value');    
    if(selected_index == 1)
        set(findobj('Tag','btnlfpsMoveUp'),'Enable', 'Off');
    elseif(selected_index == length(listbox_contents))
        set(findobj('Tag','btnlfpsMoveDown'),'Enable', 'Off');        
    end


%%


% --- Executes on selection change in lstboxlfpsContent.
function lstboxlfpsContent_Callback(hObject, eventdata, handles)
% hObject    handle to lstboxlfpsContent (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = get(hObject,'String') returns lstboxlfpsContent contents as cell array
%        contents{get(hObject,'Value')} returns selected item from lstboxlfpsContent

    listbox_contents = get(findobj('Tag', 'lstboxlfpsContent'), 'String');
    selected_index = get(findobj('Tag', 'lstboxlfpsContent'), 'Value');
    
    fh=findobj('Tag','figlfpsMain');
    
    if(isappdata(fh, 'plottedSweeps'))
        plottedSweeps=getappdata(fh, 'plottedSweeps');
        
        if  (length(selected_index)==1)
            cla(findobj('Tag','axlfpsMain'));  
            filesToPlot = selected_index;
        elseif (length(plottedSweeps)>length(selected_index))
            cla(findobj('Tag','axlfpsMain'));
            if selected_index(1)< plottedSweeps(1)
                filesToPlot = selected_index;
            else
                filesToPlot=intersect(plottedSweeps, selected_index);
            end
        else
            filesToPlot=setdiff(selected_index, plottedSweeps);      
        end
                
        setappdata(fh,'plottedSweeps',selected_index);
    else
        filesToPlot=selected_index;        
        setappdata(fh,'plottedSweeps',filesToPlot);
    end
    
    fh = findobj('Tag','figlfpsMain');
    
    if(selected_index == 1)
        set(findobj('Tag','btnlfpsMoveUp'),'Enable', 'Off');
        set(findobj('Tag','btnlfpsMoveDown'),'Enable', 'On');        
    else
        set(findobj('Tag','btnlfpsMoveUp'),'Enable', 'On');        
    end    

    if(selected_index == length(listbox_contents))
        set(findobj('Tag','btnlfpsMoveDown'),'Enable', 'Off');
        set(findobj('Tag','btnlfpsMoveUp'),'Enable', 'On');
    else
        set(findobj('Tag','btnlfpsMoveDown'),'Enable', 'On');        
    end
    
    [checkedColumns, flag] = selectedColumns();

    if(flag)
        filePath = getappdata(fh, 'directoryPath');

        color = {'r','g','b','c','m','y','k','r','g','b','c','m','y','k','r','g','b','c','m','y','k','r','g','b','c','m','y','k','r','g','b','c','m','y','k'...
            'r','g','b','c','m','y','k','r','g','b','c','m','y','k','r','g','b','c','m','y','k','r','g','b','c','m','y','k','r','g','b','c','m','y','k',...
            'r','g','b','c','m','y','k','r','g','b','c','m','y','k','r','g','b','c','m','y','k','r','g','b','c','m','y','k','r','g','b','c','m','y','k'};        
                       
        columns = length(checkedColumns);
               
        for j=1:length(filesToPlot)
            [fet_time, fet_data] = readData(filePath, listbox_contents{filesToPlot(j)}, checkedColumns);    

            hold on
            for i=1:1:columns-1
                plot(fet_time, fet_data(:,i),color{j});
                title(['Plot of Channel#',num2str(i)]);
            end          
           
        end
        
        axis('tight');
        hold off
    end

%%

% --- Executes during object creation, after setting all properties.
function lstboxlfpsContent_CreateFcn(hObject, eventdata, handles)
% hObject    handle to lstboxlfpsContent (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


%%

%%
% --- Executes on button press in btnlfpsLoad.
function btnlfpsLoad_Callback(hObject, eventdata, handles)
% hObject    handle to btnlfpsLoad (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

    fh = findobj('Tag', 'figlfpsMain');
    
    fileNames = get(findobj('Tag', 'lstboxlfpsContent'), 'String');    
    
    [~, flag]=selectedColumns(); % the tilde operation ignores the first argument
    
    if(flag) %if proper signal source and channels are selected

        filePath=getappdata(fh,'directoryPath');
        preData=load([filePath fileNames{1}]);
        signalMatrix = zeros(length(fileNames), length(preData));
        
        clear('preData');
        
        waitbarMsg ={'Please Wait...', 'Loading Data Files...',' '};
        h=waitbar(0,waitbarMsg,'Name','Loading Data Files');        
            
        for i=1:length(fileNames)   
            signalMatrix(i, :) = createMatrix(filePath, fileNames{i});
            
            updatedWaitBarMsg={'Please Wait... Loading Data Files...', 'Now Loading File: ', fileNames{i}};
            waitbar(i/length(fileNames),h,updatedWaitBarMsg);            
        end
        
        close(h);
        
        setappdata(fh, 'signalMatrix', signalMatrix);
        
        set(findobj('Tag','btnlfpsLoad'),'String', 'Data Files Loaded');
        set(findobj('Tag','btnlfpsLoad'),'Enable', 'Off');
        set(findobj('Tag','btnlfpsMoveUp'),'Enable', 'Off');
        set(findobj('Tag','btnlfpsMoveDown'),'Enable', 'Off');           
        set(findobj('Tag','btnlfpsRemoveFile'),'Enable', 'Off');        
        set(findobj('Tag','chkboxlfpsCh1'),'Enable', 'Off');
        set(findobj('Tag','chkboxlfpsCh2'),'Enable', 'Off');
        set(findobj('Tag','chkboxlfpsCh3'),'Enable', 'Off');
        set(findobj('Tag','chkboxlfpsCh4'),'Enable', 'Off');
        set(findobj('Tag','chkboxlfpsCh5'),'Enable', 'Off');
        set(findobj('Tag','btnlfpsSort'),'Enable', 'On')
        
    end
    
%%

% --- Executes on button press in btnlfpsSort.
function btnlfpsSort_Callback(hObject, eventdata, handles)
% hObject    handle to btnlfpsSort (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%% this part of the code is for single folder processing

%     fh=findobj('Tag', 'figlfpsMain');
%     
%     fileNames=getappdata(fh, 'fileNames');
%     
%     data=load([getappdata(fh,'directoryPath') fileNames{1}]);
%     
%     fileLength=length(data);
%     
%     clear data;
% 
%     signalMatrix=getappdata(fh,'signalMatrix');
% 
%     selectedMatchingMethod=getappdata(fh,'selectedMatchingMethod');
% 
%     selectedClusteringMethod=getappdata(fh,'selectedClusteringMethod');
%     
%     if ~isequal(get(findobj('Tag','rblfpsSOM'),'Value'),1)    
%         selectedDistanceCriteria=getappdata(fh,'selectedDistanceCriteria');        
%     else
%         selectedDistanceCriteria=0;
%     end
%     
%     selectedDistanceMethod=getappdata(fh,'selectedDistanceMethod');
% 
% %     if isappdata(fh,'clusterNo')
% %         clusNo=getappdata(fh, 'clusterNo');
% %     else
%     clusNo = randi([5 10], 1, 1);    
%     set(findobj('Tag','ddlClusterNo'),'Value',clusNo);
% %         clusNo=10;
% %     end
% 
%     [~, res2, ~, res4] = sortSweepsVSubplot(signalMatrix, selectedMatchingMethod, selectedClusteringMethod, clusNo, selectedDistanceCriteria, selectedDistanceMethod, fileLength);
%     
%     % save the average of each cluster in seperate files in the folder
%     % 'ClusteredAverages'
%     
%     temp=fileNames{1};
%     [token, remain]=strtok(temp, 'part');
%     fileNameFormat=[token 'cluster%02d.txt'];
% 
%     currPath=cd(getappdata(fh, 'directoryPath'));
%     
%     [status,message,messageid] = mkdir('ClusteredAverages');
%     
%     cd('ClusteredAverages');
% 
%     [~, nc]=size(res4);
%     
%     for i=1:nc-1
%         toSave=[];
%         saveFileName=sprintf(fileNameFormat,i);
%         if (any(isnan(res4(:,i+1)))) || ~(any(res4(:,i+1)))
%             continue;
%         else
%             toSave=[res4(:,1), res4(:,i+1)];
%             save(saveFileName,'toSave','-ascii','-tabs');
%         end
%     end
% 
%     clustFileName='Clustering_details.txt';
%     save(clustFileName, 'res2','-ascii','-tabs');    
% 
% 
%     cd(currPath)  

%% single folder processing ends here %%
    
%% This part is to be activated when multiple folder processing is under consideration

    startTime = datestr(clock);

    fh=findobj('Tag', 'figlfpsMain');
    
    selectedMatchingMethod=getappdata(fh,'selectedMatchingMethod');

    selectedClusteringMethod=getappdata(fh,'selectedClusteringMethod');
    
    if ~isequal(get(findobj('Tag','rblfpsSOM'),'Value'),1)    
        selectedDistanceCriteria=getappdata(fh,'selectedDistanceCriteria');        
    else
        selectedDistanceCriteria=0;
    end
    
    selectedDistanceMethod=getappdata(fh,'selectedDistanceMethod');

%     if isappdata(fh,'clusterNo')
%         clusNo=getappdata(fh, 'clusterNo');
%     else
    clusNo = randi([6 10], 1, 1);    
    set(findobj('Tag','ddlClusterNo'),'Value',clusNo);
%         clusNo=10;
%     end

    result = sortMultipleFolders(selectedMatchingMethod, selectedClusteringMethod, selectedDistanceCriteria, selectedDistanceMethod, clusNo);
    
%     tmpStr=strrep(datestr(clock),':','');
%     tmpStr=strrep(tmpStr,'-','');
%     tmpStr=strrep(tmpStr,' ','-');
    
    if iscell(result)
        msgString = {char(result{1}),char(result{2}),char(result{3}),char(result{4}), ['Execution Started at ', startTime], ['Execution Finished at ' datestr(clock)]};
    else
        msgString = {result, ['Execution Started at ', startTime], ['Execution Finished at ' datestr(clock)]};
    end
    msgbox(msgString, 'Function Call Ended');


function [checkedColumns, flag] = selectedColumns()
%% 
    figure_handle = findobj('Tag', 'figlfpsMain');
      
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
%%
% --- Executes on button press in btnlfpsRemoveFile.
function btnlfpsRemoveFile_Callback(hObject, eventdata, handles)
    %%
% hObject    handle to btnlfpsRemoveFile (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

    fh=findobj('Tag','lstboxlfpsContent');
    selected = get(fh,'Value'); 
    prev_str = get(fh, 'String'); 
    if ~isempty(prev_str) 
        prev_str(get(fh,'Value')) = []; 
        set(fh, 'String', prev_str, ... 
            'Value', min(selected,length(prev_str))); 
        setappdata(findobj('Tag','figlfpsMain'),'fileNames',prev_str);
    end

    %%

% --- Executes on selection change in pumlfpsRecType.
function pumlfpsRecType_Callback(hObject, eventdata, handles)
    %%
% hObject    handle to pumlfpsRecType (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = get(hObject,'String') returns pumlfpsRecType contents as cell array
%        contents{get(hObject,'Value')} returns selected item from pumlfpsRecType

% selectedString = get(handles.pumlfpsRecType, 'String');
    selectedValue = get(hObject, 'Value');

    setappdata(findobj('Tag','figlfpsMain'),'signalType',selectedValue);
    switch selectedValue
        case 2 % if the micropipette recording is selected
            set(findobj('Tag', 'btnlfpsBrowse'), 'Enable', 'On');
            set(findobj('Tag', 'chkboxlfpsCh1'), 'Visible', 'On');
            set(findobj('Tag', 'chkboxlfpsCh2'), 'Visible', 'On');
            set(findobj('Tag', 'chkboxlfpsCh3'), 'Visible', 'On');
            set(findobj('Tag', 'chkboxlfpsCh4'), 'Visible', 'On');
            set(findobj('Tag', 'chkboxlfpsCh5'), 'Visible', 'On');
        case 3 % if the Transistor recording is selected
            set(findobj('Tag', 'btnlfpsBrowse'), 'Enable', 'On');
            set(findobj('Tag', 'chkboxlfpsCh1'), 'Visible', 'On');
            set(findobj('Tag', 'chkboxlfpsCh2'), 'Visible', 'On');
            set(findobj('Tag', 'chkboxlfpsCh3'), 'Visible', 'On');
            set(findobj('Tag', 'chkboxlfpsCh4'), 'Visible', 'On');
            set(findobj('Tag', 'chkboxlfpsCh5'), 'Visible', 'On');        
        otherwise % if nothing is selected
            msgbox('Please Select a Signal Source', 'Signal Source Not Selected','Error');
            set(findobj('Tag', 'btnlfpsBrowse'), 'Enable', 'Off');
            set(findobj('Tag', 'chkboxlfpsCh1'), 'Visible', 'Off');  
            set(findobj('Tag', 'chkboxlfpsCh2'), 'Visible', 'Off');  
            set(findobj('Tag', 'chkboxlfpsCh4'), 'Visible', 'Off');  
            set(findobj('Tag', 'chkboxlfpsCh5'), 'Visible', 'Off'); 
            set(findobj('Tag', 'chkboxlfpsCh3'), 'Visible', 'Off');         
    end            

% --- Executes during object creation, after setting all properties.
function pumlfpsRecType_CreateFcn(hObject, eventdata, handles)
% hObject    handle to pumlfpsRecType (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

%%

% --- Executes on button press in chkboxlfpsCh1.
function chkboxlfpsCh1_Callback(hObject, eventdata, handles)
% hObject    handle to chkboxlfpsCh1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of chkboxlfpsCh1

    if (get(hObject,'Value') == get(hObject,'Max'))
        % Checkbox is checked
        setappdata(findobj('Tag','figlfpsMain'),'Ch1',1);
    else
        % Checkbox is not checked
        setappdata(findobj('Tag','figlfpsMain'),'Ch1',0);        
    end    

%%

% --- Executes on button press in chkboxlfpsCh2.
function chkboxlfpsCh2_Callback(hObject, eventdata, handles)
% hObject    handle to chkboxlfpsCh2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of chkboxlfpsCh2

    if (get(hObject,'Value') == get(hObject,'Max'))
        % Checkbox is checked
        setappdata(findobj('Tag','figlfpsMain'),'Ch2',1);
    else
        % Checkbox is not checked
        setappdata(findobj('Tag','figlfpsMain'),'Ch2',0);        
    end    

%%

% --- Executes on button press in chkboxlfpsCh4.
function chkboxlfpsCh4_Callback(hObject, eventdata, handles)
% hObject    handle to chkboxlfpsCh4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of chkboxlfpsCh4

    if (get(hObject,'Value') == get(hObject,'Max'))
        % Checkbox is checked
        setappdata(findobj('Tag','figlfpsMain'),'Ch4',1);
    else
        % Checkbox is not checked
        setappdata(findobj('Tag','figlfpsMain'),'Ch4',0);        
    end    

%%

% --- Executes on button press in chkboxlfpsCh5.
function chkboxlfpsCh5_Callback(hObject, eventdata, handles)
%%
% hObject    handle to chkboxlfpsCh5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of chkboxlfpsCh5

    if (get(hObject,'Value') == get(hObject,'Max'))
        % Checkbox is checked
        setappdata(findobj('Tag','figlfpsMain'),'Ch5',1);
    else
        % Checkbox is not checked
        setappdata(findobj('Tag','figlfpsMain'),'Ch5',0);        
    end    

% --- Executes on button press in chkboxlfpsCh3.
function chkboxlfpsCh3_Callback(hObject, eventdata, handles)
%%
% hObject    handle to chkboxlfpsCh3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of chkboxlfpsCh3


    if (get(hObject,'Value') == get(hObject,'Max'))
        % Checkbox is checked
        setappdata(findobj('Tag','figlfpsMain'),'Ch3',1);
    else
        % Checkbox is not checked
        setappdata(findobj('Tag','figlfpsMain'),'Ch3',0);        
    end    

%%

% --- Executes on button press in btnlfpsMoveUp.
function btnlfpsMoveUp_Callback(hObject, eventdata, handles)
    %%
% hObject    handle to btnlfpsMoveUp (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

    fh = findobj('Tag', 'lstboxlfpsContent');
    listbox_contents = get(fh, 'String');
    selected_index = get(fh, 'Value');    
    
    if (~isempty(listbox_contents) && (selected_index > 1)&&(selected_index <= length(listbox_contents)))
        index = get(fh,'Value');
        tempFile=listbox_contents{index};
        listbox_contents{index}=listbox_contents{index-1};
        listbox_contents{index-1}=tempFile;
        set(fh, 'String', listbox_contents, ... 
            'Value', min(index,length(listbox_contents))); 
        setappdata(findobj('Tag','figlfpsMain'),'fileNames',listbox_contents);
        set(fh,'Value',index-1)
    end

    if(selected_index == 1)
        set(findobj('Tag','btnlfpsMoveUp'),'Enable', 'Off');
        set(findobj('Tag','btnlfpsMoveDown'),'Enable', 'On');        
    else
        set(findobj('Tag','btnlfpsMoveUp'),'Enable', 'On');        
    end    

    if(selected_index == length(listbox_contents))
        set(findobj('Tag','btnlfpsMoveDown'),'Enable', 'Off');
        set(findobj('Tag','btnlfpsMoveUp'),'Enable', 'On');
    else
        set(findobj('Tag','btnlfpsMoveDown'),'Enable', 'On');        
    end  

% --- Executes on button press in btnlfpsMoveDown.
function btnlfpsMoveDown_Callback(hObject, eventdata, handles)
    %%
% hObject    handle to btnlfpsMoveDown (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

    fh = findobj('Tag', 'lstboxlfpsContent');    
    listbox_contents = get(fh, 'String');
    selected_index = get(fh, 'Value');
    

    if (~isempty(listbox_contents) && (selected_index >= 1)&&(selected_index < length(listbox_contents)))
        index = get(fh,'Value');
        tempFile=listbox_contents{index};
        listbox_contents{index}=listbox_contents{index+1};
        listbox_contents{index+1}=tempFile;
        set(fh, 'String', listbox_contents, ... 
            'Value', min(index,length(listbox_contents))); 
        setappdata(findobj('Tag','figlfpsMain'),'fileNames',listbox_contents);
        set(fh,'Value',index+1)        
    end     

    if(selected_index == 1)
        set(findobj('Tag','btnlfpsMoveUp'),'Enable', 'Off');
        set(findobj('Tag','btnlfpsMoveDown'),'Enable', 'On');        
    else
        set(findobj('Tag','btnlfpsMoveUp'),'Enable', 'On');        
    end    

    if(selected_index == length(listbox_contents))
        set(findobj('Tag','btnlfpsMoveDown'),'Enable', 'Off');
        set(findobj('Tag','btnlfpsMoveUp'),'Enable', 'On');
    else
        set(findobj('Tag','btnlfpsMoveDown'),'Enable', 'On');        
    end
    
% --- Executes on button press in tblfpsZoom.
function tblfpsZoom_Callback(hObject, eventdata, handles)
    %%
% hObject    handle to tblfpsZoom (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of tblfpsZoom

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

% --- Executes on button press in tblfpsDataCursor.
function tblfpsDataCursor_Callback(hObject, eventdata, handles)
    %%
% hObject    handle to tblfpsDataCursor (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of tblfpsDataCursor

    button_state = get(hObject,'Value');
    if button_state == get(hObject,'Max')
	% Toggle button is pressed, take appropriate action
        datacursormode on;
        dcm_obj=datacursormode(findobj('Tag','figlfpsMain'));
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

% --- Executes on button press in btnlfpsResetGraph.
function btnlfpsResetGraph_Callback(hObject, eventdata, handles)
    %%
% hObject    handle to btnlfpsResetGraph (see GCBO)
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

% --- Executes on button press in tblfpsPan.
function tblfpsPan_Callback(hObject, eventdata, handles)
%%
% hObject    handle to tblfpsPan (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of tblfpsPan


    button_state = get(hObject,'Value');
    if button_state == get(hObject,'Max')
	% Toggle button is pressed, take appropriate action
        pan on;
%         dcm_obj=datacursormode(findobj('Tag','figlfpsMain'));
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


% --------------------------------------------------------------------
% --- Executes on button press in rblfpsContour.
%%

function rblfpsContour_Callback(hObject, eventdata, handles)
% hObject    handle to rblfpsContour (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of rblfpsContour

    fh=findobj('Tag','figlfpsMain');
    set(findobj('Tag','rblfpsContour'),'Value', 1);
    set(findobj('Tag','rblfpsMatchedFilter'),'Value', 0);
    selectedMatchingMethod=1;
    setappdata(fh,'selectedMatchingMethod',selectedMatchingMethod);

%%
% --- Executes on button press in rblfpsMatchedFilter.
%%

function rblfpsMatchedFilter_Callback(hObject, eventdata, handles)
% hObject    handle to rblfpsMatchedFilter (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of rblfpsMatchedFilter

    fh=findobj('Tag','figlfpsMain');
    set(findobj('Tag','rblfpsContour'),'Value', 0);
    set(findobj('Tag','rblfpsMatchedFilter'),'Value', 1);
    selectedMatchingMethod=2;
    setappdata(fh,'selectedMatchingMethod',selectedMatchingMethod);

%%

% --- Executes on button press in rblfpsKMeans.
function rblfpsKMeans_Callback(hObject, eventdata, handles)
% hObject    handle to rblfpsKMeans (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of rblfpsKMeans

    fh=findobj('Tag','figlfpsMain');
      
    fhCriteria=findobj('Tag','pnlDistanceCriteria');
    set(fhCriteria, 'Visible', 'On');
    set(fhCriteria, 'Title', 'Distance Criteria');

    set(findobj('Tag','rblfpsSumOfDistances'),'Value', 1);
    set(findobj('Tag','rblfpsSumOfDistances'),'String', 'Sum of Distance');
    set(findobj('Tag','rblfpsSumOfDistances'),'ToolTipString', 'Minimization of the sum of the distances');    

    set(findobj('Tag','rblfpsSumOfVariances'),'Value', 0);
    set(findobj('Tag','rblfpsSumOfVariances'),'String', 'Sum of Variance');
    set(findobj('Tag','rblfpsSumOfVariances'),'ToolTipString', 'Minimization of the sum of variances of the different clusters');    

    set(findobj('Tag','rblfpsRatioOfVariances'),'Value', 0);
    set(findobj('Tag','rblfpsRatioOfVariances'),'String', 'Ratio of Variance');
    set(findobj('Tag','rblfpsRatioOfVariances'),'ToolTipString', 'Minimization of the ratio of the variance inside clusters and between clusters');
        
    selectedDistanceCriteria=1;
    setappdata(fh,'selectedDistanceCriteria',selectedDistanceCriteria); 

    set(findobj('Tag','rblfpsKMeans'),'Value', 1);
    set(findobj('Tag','rblfpsAgglomerative'),'Value', 0);
    set(findobj('Tag','rblfpsSOM'),'Value', 0);
    selectedClusteringMethod=1;
    setappdata(fh,'selectedClusteringMethod',selectedClusteringMethod);
 
%%

% --- Executes on button press in rblfpsAgglomerative.
function rblfpsAgglomerative_Callback(hObject, eventdata, handles)
% hObject    handle to rblfpsAgglomerative (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of rblfpsAgglomerative

    fh=findobj('Tag','figlfpsMain');
    
    set(findobj('Tag','rblfpsKMeans'),'Value', 0);
    set(findobj('Tag','rblfpsAgglomerative'),'Value', 1);
    set(findobj('Tag','rblfpsSOM'),'Value', 0);
    selectedClusteringMethod=2;
    setappdata(fh,'selectedClusteringMethod',selectedClusteringMethod);

    fhCriteria=findobj('Tag','pnlDistanceCriteria');
    set(fhCriteria, 'Visible', 'On');
    set(fhCriteria, 'Title', 'Linkage Criteria');
    
    set(findobj('Tag','rblfpsSumOfDistances'),'Value', 1);
    set(findobj('Tag','rblfpsSumOfDistances'),'String', 'Single Linkage');
    set(findobj('Tag','rblfpsSumOfDistances'),'ToolTipString', 'Calculate Distance using Minimum or single-linkage');
    
    set(findobj('Tag','rblfpsSumOfVariances'),'Value', 0);
    set(findobj('Tag','rblfpsSumOfVariances'),'String', 'Average Linkage');
    set(findobj('Tag','rblfpsSumOfVariances'),'ToolTipString', 'Calculate Distance using Mean or average linkage');    
    
    set(findobj('Tag','rblfpsRatioOfVariances'),'Value', 0);
    set(findobj('Tag','rblfpsRatioOfVariances'),'String', 'Maximum Linkage');
    set(findobj('Tag','rblfpsRatioOfVariances'),'ToolTipString', 'Calculate Distance using Maximum or complete linkage');        
    
    selectedDistanceCriteria=1;
    setappdata(fh,'selectedDistanceCriteria',selectedDistanceCriteria);  

%%

% --- Executes on button press in rblfpsSOM.
function rblfpsSOM_Callback(hObject, eventdata, handles)
% hObject    handle to rblfpsSOM (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of rblfpsSOM

    fh=findobj('Tag','figlfpsMain');
    set(findobj('Tag','rblfpsKMeans'),'Value', 0);
    set(findobj('Tag','rblfpsAgglomerative'),'Value', 0);
    set(findobj('Tag','rblfpsSOM'),'Value', 1);
    selectedClusteringMethod=3;
    setappdata(fh,'selectedClusteringMethod',selectedClusteringMethod);
    
    set(findobj('Tag','pnlDistanceCriteria'), 'Visible', 'Off');    
    
    if isappdata(fh,'selectedDistanceCriteria')
        rmappdata(fh,'selectedDistanceCriteria');
    end    

%%

% --- Executes on button press in rblfpsEuclideanDistance.
function rblfpsEuclideanDistance_Callback(hObject, eventdata, handles)
% hObject    handle to rblfpsEuclideanDistance (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of rblfpsEuclideanDistance

    fh=findobj('Tag','figlfpsMain');    
    set(findobj('Tag','rblfpsEuclideanDistance'),'Value', 1);
    set(findobj('Tag','rblfpsCenteredCorrelation'),'Value', 0);    
    set(findobj('Tag','rblfpsUncenteredCorrelation'),'Value', 0);
    selectedDistanceMethod=1;
    setappdata(fh,'selectedDistanceMethod',selectedDistanceMethod);

    
%%

% --- Executes on button press in rblfpsCenteredCorrelation.
function rblfpsCenteredCorrelation_Callback(hObject, eventdata, handles)
% hObject    handle to rblfpsCenteredCorrelation (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of rblfpsCenteredCorrelation

    fh=findobj('Tag','figlfpsMain');   
    set(findobj('Tag','rblfpsEuclideanDistance'),'Value', 0);
    set(findobj('Tag','rblfpsCenteredCorrelation'),'Value', 1);    
    set(findobj('Tag','rblfpsUncenteredCorrelation'),'Value', 0);
    selectedDistanceMethod=2;
    setappdata(fh,'selectedDistanceMethod',selectedDistanceMethod);
    
    
%%

% --- Executes on button press in rblfpsUncenteredCorrelation.
function rblfpsUncenteredCorrelation_Callback(hObject, eventdata, handles)
% hObject    handle to rblfpsUncenteredCorrelation (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of rblfpsUncenteredCorrelation

    fh=findobj('Tag','figlfpsMain');
    set(findobj('Tag','rblfpsEuclideanDistance'),'Value', 0);    
    set(findobj('Tag','rblfpsCenteredCorrelation'),'Value', 0);
    set(findobj('Tag','rblfpsUncenteredCorrelation'),'Value', 1);
    selectedDistanceMethod=3;
    setappdata(fh,'selectedDistanceMethod',selectedDistanceMethod);

%%

% --- Executes on selection change in ddlClusterNo.
function ddlClusterNo_Callback(hObject, eventdata, handles)
% hObject    handle to ddlClusterNo (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns ddlClusterNo contents as cell array
%        contents{get(hObject,'Value')} returns selected item from ddlClusterNo

    contents = cellstr(get(hObject,'String'));
    clusterNo = str2double(contents{get(hObject,'Value')});
    
    fh=findobj('Tag','figlfpsMain');
    setappdata(fh, 'clusterNo', clusterNo);
    
%%

% --- Executes during object creation, after setting all properties.
function ddlClusterNo_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ddlClusterNo (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
%%

% --- Executes on button press in rblfpsSumOfDistances.
function rblfpsSumOfDistances_Callback(hObject, eventdata, handles)
% hObject    handle to rblfpsSumOfDistances (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of rblfpsSumOfDistances

    fh=findobj('Tag','figlfpsMain');
    set(findobj('Tag','rblfpsSumOfDistances'),'Value', 1);
    set(findobj('Tag','rblfpsSumOfVariances'),'Value', 0);
    set(findobj('Tag','rblfpsRatioOfVariances'),'Value', 0);
    selectedDistanceCriteria=1;
    setappdata(fh,'selectedDistanceCriteria',selectedDistanceCriteria); 

%%

% --- Executes on button press in rblfpsSumOfVariances.
function rblfpsSumOfVariances_Callback(hObject, eventdata, handles)
% hObject    handle to rblfpsSumOfVariances (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of rblfpsSumOfVariances

    fh=findobj('Tag','figlfpsMain');    
    set(findobj('Tag','rblfpsSumOfDistances'),'Value', 0);
    set(findobj('Tag','rblfpsSumOfVariances'),'Value', 1);
    set(findobj('Tag','rblfpsRatioOfVariances'),'Value', 0);
    selectedDistanceCriteria=2;
    setappdata(fh,'selectedDistanceCriteria',selectedDistanceCriteria); 


%%

% --- Executes on button press in rblfpsRatioOfVariances.
function rblfpsRatioOfVariances_Callback(hObject, eventdata, handles)
% hObject    handle to rblfpsRatioOfVariances (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of rblfpsRatioOfVariances

    fh=findobj('Tag','figlfpsMain');    
    set(findobj('Tag','rblfpsSumOfDistances'),'Value', 0);
    set(findobj('Tag','rblfpsSumOfVariances'),'Value', 0);
    set(findobj('Tag','rblfpsRatioOfVariances'),'Value', 1);
    selectedDistanceCriteria=3;
    setappdata(fh,'selectedDistanceCriteria',selectedDistanceCriteria); 


%%

% --- Executes during object creation, after setting all properties.
function axslfpsSigMate_CreateFcn(hObject, eventdata, handles)
% hObject    handle to axslfpsSigMate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: place code in OpeningFcn to populate axslfpsSigMate
    axes(hObject)
    pathLogo = which('SigMate-Logo');
    imshow([pathLogo '\' 'SigMate-Logo.gif'])