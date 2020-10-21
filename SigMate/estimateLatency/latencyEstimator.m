function varargout = latencyEstimator(varargin)
% LATENCYESTIMATOR M-file for latencyEstimator.fig
%      LATENCYESTIMATOR, by itself, creates a new LATENCYESTIMATOR or raises the existing
%      singleton*.
%
%      H = LATENCYESTIMATOR returns the handle to a new LATENCYESTIMATOR or the handle to
%      the existing singleton*.
%
%      LATENCYESTIMATOR('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in LATENCYESTIMATOR.M with the given input arguments.
%
%      LATENCYESTIMATOR('Property','Value',...) creates a new LATENCYESTIMATOR or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before latencyEstimator_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to latencyEstimator_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help latencyEstimator

% Last Modified by GUIDE v2.5 04-May-2012 18:02:22

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @latencyEstimator_OpeningFcn, ...
                   'gui_OutputFcn',  @latencyEstimator_OutputFcn, ...
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


% --- Executes just before latencyEstimator is made visible.
function latencyEstimator_OpeningFcn(hObject, eventdata, handles, varargin)
    %%
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to latencyEstimator (see VARARGIN)

% Choose default command line output for latencyEstimator
handles.output = hObject;

set(handles.figlfpLatencyEstimator, 'CloseRequestFcn', 'closeGUI');

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes latencyEstimator wait for user response (see UIRESUME)
% uiwait(handles.figlfpLatencyEstimator);


% --- Outputs from this function are returned to the command line.
function varargout = latencyEstimator_OutputFcn(hObject, eventdata, handles) 
    %%
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;

% --- Executes when user attempts to close figlfpLatencyEstimator.
function figlfpLatencyEstimator_CloseRequestFcn(hObject, eventdata, handles)
% hObject    handle to figlfpLatencyEstimator (see GCBO)
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


% --- Executes on button press in btnlelfpBrowse.
function btnlelfpBrowse_Callback(hObject, eventdata, handles)
    %%
% hObject    handle to btnlelfpBrowse (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

    %clear if any application data exists
    
    fh = findobj('Tag', 'figlfpLatencyEstimator');    
    
%     fh_laOrder = findobj('Tag','btnlelfplaOrder');
%     set(fh_laOrder,'Enable','off');
    
%     path = uigetdir('D:\MatlabWorks','Select a Directory'); %Select the directory and store the path at folder 

    if (isappdata(fh, 'directoryPath'))
        browseDir = getappdata(fh, 'directoryPath');
        path = uigetdir(browseDir,'Select a Directory'); %Select the directory and store the path at folder 
    else
        path = uigetdir([pwd '\'],'Select a Directory'); %Select the directory and store the path at folder        
    end
    
    
    if(path) % if a directory is selected
        
        setappdata(fh, 'directoryPath', strcat(path,'\'));
        handle_lbllelfpPath = findobj('Tag', 'lbllelfpPath'); % find the object with the Tag lblPath and store the reference handle

        if (handle_lbllelfpPath ~= 0) % if the above searched object found
            text = get(handle_lbllelfpPath,'String');  % get the text of the object
            if(~(strcmp(text,'Selected Directory Path')))
                text = 'Selected Directory Path';
            end
            newtext = strcat(text, ': ', path); % append the folder path to the content
            set(handle_lbllelfpPath,'String',newtext); % set the new text to the control
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
        set(findobj('Tag','lstboxlelfpContent'),'String',handles.file_names,'Value',1);
        set(findobj('Tag','btnlelfpCalculate'),'Enable', 'On');
       
        set(findobj('Tag','btnlelfpRemoveFiles'),'Enable', 'On');

        set(findobj('Tag','chkboxlelfpIm'),'Enable', 'On');
        set(findobj('Tag','chkboxlelfpVm'),'Enable', 'On');
        set(findobj('Tag','chkboxlelfpStimulus'),'Enable', 'On');
        set(findobj('Tag','chkboxlelfpVj'),'Enable', 'On');
        set(findobj('Tag','chkboxlelfpVavg'),'Enable', 'On'); 
        set(findobj('Tag', 'txtThreshold'),'Enable','Off');        
        
        listbox_contents = get(findobj('Tag', 'lstboxlelfpContent'), 'String');
        selected_index = get(findobj('Tag', 'lstboxlelfpContent'), 'Value');    
        if(selected_index == 1)
            set(findobj('Tag','btnlelfpMoveUp'),'Enable', 'Off');
        elseif(selected_index == length(listbox_contents))
            set(findobj('Tag','btnlelfpMoveDown'),'Enable', 'Off');        
        end
        
        fh_lblLatency=findobj('Tag','lbllelfpLatency');
        set(fh_lblLatency,'String','');
    
    else %if the directory selection dialog is cancelled
        
        msgbox('Please Select a Directory for Analysis', 'Directory Not Selected','Error');
    end


% --- Executes on selection change in lstboxlelfpContent.
function lstboxlelfpContent_Callback(hObject, eventdata, handles)
    %%
% hObject    handle to lstboxlelfpContent (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = get(hObject,'String') returns lstboxlelfpContent contents as cell array
%        contents{get(hObject,'Value')} returns selected item from lstboxlelfpContent

    listbox_contents = get(findobj('Tag', 'lstboxlelfpContent'), 'String');
    selected_index = get(findobj('Tag', 'lstboxlelfpContent'), 'Value');
    fh = findobj('Tag','figlfpLatencyEstimator');
    setappdata(fh,'selectedFileName',listbox_contents{selected_index});
    
   if(selected_index == 1)
        set(findobj('Tag','btnlelfpMoveUp'),'Enable', 'Off');
        set(findobj('Tag','btnlelfpMoveDown'),'Enable', 'On');        
    else
        set(findobj('Tag','btnlelfpMoveUp'),'Enable', 'On');        
    end    

    if(selected_index == length(listbox_contents))
        set(findobj('Tag','btnlelfpMoveDown'),'Enable', 'Off');
        set(findobj('Tag','btnlelfpMoveUp'),'Enable', 'On');
    else
        set(findobj('Tag','btnlelfpMoveDown'),'Enable', 'On');        
    end
    
    [checkedColumns, flag] = selectedColumns();
    
    if(flag)  
        filePath = getappdata(fh, 'directoryPath');
%         [fet_time, fet_data] = readData(filePath, listbox_contents{selected_index}, checkedColumns);
%         setappdata(fh,'fet_time',fet_time);
%         setappdata(fh,'fet_data',fet_data);        
        color = {'r','g','b','c','m','y','k'};        
        cla(findobj('Tag','axlelfpMain'));
        columns = length(checkedColumns);
                
        signalType=getappdata(findobj('Tag','figlfpLatencyEstimator'),'signalType');
        
        fh_Cutoff = findobj('Tag','txtlelfpCutoffFreq');
        get(fh_Cutoff,'String');
        cutoffFreq=str2double(get(fh_Cutoff,'String'));
        
%         [t_SS,v_SS,t_RS,v_RS,t_P1,v_P1,l_P1,t_P2,v_P2,l_P2,t_P3,v_P3,l_P3,t_P4,v_P4,l_P4,s,t,flag] = detectLatencyInAvgV3(filePath, listbox_contents{selected_index}, cutoffFreq, signalType);
        [t_SS,v_SS,t_RS,v_RS,t_P1,v_P1,l_P1,t_P2,v_P2,l_P2,t_P3,v_P3,l_P3,t_P4,v_P4,l_P4,s,t,flag] = detectLatencyInAvgV5StimOnset(filePath, listbox_contents{selected_index}, cutoffFreq, signalType);
        if (flag)
        hold on
        for i=1:1:columns-1
            plot(t, s,color{i});
            plot(t_RS, v_RS, 'go');
            if ~isnan(v_P1)
                plot(t_P1, v_P1, 'bo');
            end
            plot(t_P2, v_P2, 'ko');
            plot(t_P3, v_P3, 'co');
            if ~isnan(v_P4)
                plot(t_P4, v_P4, 'yo');
            end
            title(['Plot of Selected Column: ',num2str(i)]);
        end
        axis('tight');
        hold off
        grid on
        else         
            plot(t, s,'r');
            errordlg(['File ', listbox_contents{selected_index}, ' doesnot match the detection criterion'], 'File Selection Error')            
        end
        fh_lblLatency=findobj('Tag','lbllelfpLatency');
        set(fh_lblLatency,'String','');
        msgStr=sprintf(['Stimulus Onset is at %15.8f ms and the Response Onset is at %15.8f ms. \n'...
            'The calculated values are:\n',...
            'First Peak is at %15.8f ms, Amplitude %10.5f mV, Latency from Response Onset %15.8f ms\n',...
            'Second Peak is at %15.8f ms, Amplitude %10.5f mV, Latency from Response Onset %15.8f ms\n',...
            'Third Peak is at %15.8f ms, Amplitude %10.5f mV, Latency from Response Onset %15.8f ms\n'...
            'Fourth Peak is at %15.8f ms, Amplitude %10.5f mV, Latency from Response Onset %15.8f ms'],...
            t_SS*1000,t_RS*1000,t_P1*1000,v_P1,l_P1*1000,t_P2*1000,v_P2,l_P2*1000,t_P3*1000,v_P3,l_P3*1000,t_P4*1000,v_P4,l_P4*1000);
        set(fh_lblLatency,'String',msgStr);
        
        setappdata(fh,'signal',s);
        setappdata(fh,'time',t);
        setappdata(fh,'t_SS',t_SS);
        setappdata(fh,'t_RS',t_RS);
        setappdata(fh,'v_RS',v_RS);
        setappdata(fh,'t_P1',t_P1);
        setappdata(fh,'v_P1',v_P1);
        setappdata(fh,'l_P1',l_P1);
        setappdata(fh,'t_P2',t_P2);
        setappdata(fh,'v_P2',v_P2);
        setappdata(fh,'l_P2',l_P2);
        setappdata(fh,'t_P3',t_P3);
        setappdata(fh,'v_P3',v_P3);
        setappdata(fh,'l_P3',l_P3);
        setappdata(fh,'t_P4',t_P4);
        setappdata(fh,'v_P4',v_P4);
        setappdata(fh,'l_P4',l_P4);
        
        % put the values in the respective text boxes
        
        set(findobj('Tag','txtlelfpManualOnset'),'String',t_RS);
        set(findobj('Tag','txtlelfpManualFirstPeak'),'String',t_P1);   
    end
    

% --- Executes during object creation, after setting all properties.
function lstboxlelfpContent_CreateFcn(hObject, eventdata, handles)
    %%
% hObject    handle to lstboxlelfpContent (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in btnlelfpCalculate.
function btnlelfpCalculate_Callback(hObject, eventdata, handles)
    %%
% hObject    handle to btnlelfpCalculate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%% This part of the code is for normal execution of the program

    try    
%     fh_threshold = findobj('Tag','txtThreshold');
%     threshold=str2double(get(fh_threshold,'String')); %returns contents ...
                                %of txtThreshold as text and then to double
    fh = findobj('Tag','figlfpLatencyEstimator');
    oldPath=pwd;
    directoryPath=getappdata(fh,'directoryPath');
    
    fh_Cutoff = findobj('Tag','txtlelfpCutoffFreq');
    get(fh_Cutoff,'String');
    cutoffFreq=str2double(get(fh_Cutoff,'String'));
    
    latencyMatrix = [];
    
%     fh_laOrder = findobj('Tag','btnlelfplaOrder');
%     set(fh_laOrder,'Enable','on');
    
    fileNames=getappdata(fh,'fileNames');
    
    numberOfParameters = 16;
    
    depthProfile = getappdata(findobj('Tag','figlfpLatencyEstimator'),'DepthProfile');
    
    if depthProfile
        rawDataFile = load([directoryPath fileNames{1}]);
        [rows, columns] = size(rawDataFile);
        timeColumn = rawDataFile(:,1);
        Results = zeros(columns-1, numberOfParameters);
    else
        Results = zeros(length(fileNames), numberOfParameters);
    end

    signalType=getappdata(findobj('Tag','figlfpLatencyEstimator'),'signalType');
    
    fileFormat='\n%13s\t%16.8f\t%16.8f\t%16.8f\t%16.8f\t%16.8f\t%16.8f\t%16.8f\t%16.8f\t%16.8f\t%16.8f\t%16.8f\t';
    headerFormat='%13s\t%16s\t%16s\t%16s\t%16s\t%16s\t%16s\t%16s\t%16s\t%16s\t%16s\t%16s\t';
    
%     if signalType==2 % micropipette recording
%         headerContent=sprintf(headerFormat,'File Name','t_stimulus (ms)','v_Peak1 (mV)','latency_Peak1 (ms)','v_Peak2 (mV)','latency_Peak2 (ms)','v_Peak3 (mV)','latency_Peak3 (ms)');    
%     else % transistor recording
    headerContent=sprintf(headerFormat,'File Name','t_stimulus (ms)','t_response (ms)','latency_response (ms)','v_Peak1 (uV)','latency_Peak1 (ms)','v_Peak2 (uV)','latency_Peak2 (ms)','v_Peak3 (uV)','latency_Peak3 (ms)','v_Peak4 (uV)','latency_Peak4 (ms)');
%     end

    cd(directoryPath);
    
    tmpStr=strrep(datestr(clock),':','');
    tmpStr=strrep(tmpStr,'-','');
    tmpStr=strrep(tmpStr,' ','-');
    tempFileName= inputdlg('Enter the File Name for Saving, without File Extension','Save As',1);
    saveFileName=[tmpStr,'-',tempFileName{1},'.xls'];
    
    fid=fopen(saveFileName,'w');

    if(fid==-1)
        msgbox(['Sorry, the file ', saveFileName,' cannot be opened!'],'File Opening Error','Error');
    else
        fprintf(fid,headerContent);
        
        if depthProfile
            depth = {'0','80','160','240','320','400','480','560','640','720','800','880','960','1040','1120','1200','1280','1360','1440','1520','1600','1680'};
            for i = 1:columns-1
                dataFile = [timeColumn, rawDataFile(:,i+1)];
                [t_SS,v_SS,t_RS,v_RS,t_P1,v_P1,l_P1,t_P2,v_P2,l_P2,t_P3,v_P3,l_P3,t_P4,v_P4,l_P4,s,t,flag] =  detectLatencyInAvgVDepthProfile(dataFile, cutoffFreq, signalType);
                fprintf(fid,fileFormat,depth{i},t_SS*1000,t_RS*1000,(t_RS-t_SS)*1000, v_P1*1000, l_P1*1000, v_P2*1000, l_P2*1000, v_P3*1000, l_P3*1000, v_P4*1000, l_P4*1000);
            end
        else
            tempLat = [];
            for i=1:length(fileNames)
                fileName = fileNames{i};
%                 [t_SS,v_SS,t_RS,v_RS,t_P1,v_P1,l_P1,t_P2,v_P2,l_P2,t_P3,v_P3,l_P3,t_P4,v_P4,l_P4,s,t,flag] =  detectLatencyInAvgV3(directoryPath, fileName, cutoffFreq, signalType);
                [t_SS,v_SS,t_RS,v_RS,t_P1,v_P1,l_P1,t_P2,v_P2,l_P2,t_P3,v_P3,l_P3,t_P4,v_P4,l_P4,s,t,flag] =  detectLatencyInAvgV5StimOnset(directoryPath, fileName, cutoffFreq, signalType);
                fprintf(fid,fileFormat,fileNames{i},t_SS*1000,t_RS*1000,(t_RS-t_SS)*1000, v_P1*1000, l_P1*1000, v_P2*1000, l_P2*1000, v_P3*1000, l_P3*1000, v_P4*1000, l_P4*1000);
                tempLat = [l_P1 l_P2 l_P3 l_P4];
                latencyMatrix = [latencyMatrix, tempLat'];
            end
        end
    end

    fclose('all');

    msgString={datestr(clock),'Data File Containing the Parameters Detected is Saved at ', directoryPath};
    msgbox(msgString,'Program Execution Success','help'); 

    cd(oldPath);
    catch exception1
        errordlg('There were errors in opening the data files','File Opening Error');
    end

%% This part of the code is for multiple folder processing and specially to
%% be used for the processing of the clustered single sweep averaged files.

%     try    
%         startTime = datestr(clock);
%         fh_Cutoff = findobj('Tag','txtlelfpCutoffFreq');
%         get(fh_Cutoff,'String');
%         cutoffFreq=str2double(get(fh_Cutoff,'String'));
% 
%         signalType=getappdata(findobj('Tag','figlfpLatencyEstimator'),'signalType');
% 
%         result = estimateLatencyInMultiple(cutoffFreq, signalType);
% 
%         msgString = {result, ['Execution Started at ', startTime], ['Execution Finished at ' datestr(clock)]};
% 
%         msgbox(msgString, 'Function Call Ended');
%         
%     catch ME
%         errordlg(['There were errors in opening the data files' ME.message],'File Opening Error');
%     end

% --- Executes on button press in btnlelfpRemoveFiles.
function btnlelfpRemoveFiles_Callback(hObject, eventdata, handles)
    %%
% hObject    handle to btnlelfpRemoveFiles (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

    fh=findobj('Tag','lstboxlelfpContent');
    selected = get(fh,'Value'); 
    prev_str = get(fh, 'String'); 
    if ~isempty(prev_str) 
        prev_str(get(fh,'Value')) = []; 
        set(fh, 'String', prev_str, ... 
            'Value', min(selected,length(prev_str))); 
        setappdata(findobj('Tag','figlfpLatencyEstimator'),'fileNames',prev_str);
    end
% --- Executes on selection change in pumlelfpRecType.

function [checkedColumns, flag] = selectedColumns()
%%
    
    figure_handle = findobj('Tag', 'figlfpLatencyEstimator');
      
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


function pumlelfpRecType_Callback(hObject, eventdata, handles)
    %%
% hObject    handle to pumlelfpRecType (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = get(hObject,'String') returns pumlelfpRecType contents as cell array
%        contents{get(hObject,'Value')} returns selected item from pumlelfpRecType

    selectedValue = get(hObject, 'Value');

    setappdata(findobj('Tag','figlfpLatencyEstimator'),'signalType',selectedValue);

    switch selectedValue
        case 2 % if the In-Vivo recording is selected
            set(findobj('Tag', 'btnlelfpBrowse'), 'Enable', 'On');

            set(findobj('Tag', 'chkboxlelfpVm'), 'Visible', 'On');
            set(findobj('Tag', 'chkboxlelfpVm'), 'String', 'VmDC');        
            set(findobj('Tag', 'chkboxlelfpIm'), 'Visible', 'On');    
            set(findobj('Tag', 'chkboxlelfpStimulus'), 'Visible', 'On');        
            set(findobj('Tag', 'chkboxlelfpIm'), 'String', 'VmAC');        
            set(findobj('Tag', 'chkboxlelfpVj'), 'Visible', 'Off');  
            set(findobj('Tag', 'chkboxlelfpVavg'), 'Visible', 'Off');          

        case 3 % if the Transistor recording is selected
            set(findobj('Tag', 'chkboxlelfpIm'), 'Visible', 'On');  
            set(findobj('Tag', 'chkboxlelfpIm'), 'String', 'Im');                
            set(findobj('Tag', 'chkboxlelfpVm'), 'Visible', 'On');  
            set(findobj('Tag', 'chkboxlelfpVm'), 'String', 'Vm');                
            set(findobj('Tag', 'chkboxlelfpVj'), 'Visible', 'On');  
            set(findobj('Tag', 'chkboxlelfpVavg'), 'Visible', 'On');  
            set(findobj('Tag', 'chkboxlelfpStimulus'), 'Visible', 'Off');         

            set(findobj('Tag', 'btnlelfpBrowse'), 'Enable', 'On');        
        otherwise % if nothing is selected
            msgbox('Please Select a Signal Source', 'Signal Source Not Selected','Error');
            set(findobj('Tag', 'btnlelfpBrowse'), 'Enable', 'Off');
            set(findobj('Tag', 'chkboxlelfpIm'), 'Visible', 'Off');  
            set(findobj('Tag', 'chkboxlelfpVm'), 'Visible', 'Off');  
            set(findobj('Tag', 'chkboxlelfpVj'), 'Visible', 'Off');  
            set(findobj('Tag', 'chkboxlelfpVavg'), 'Visible', 'Off'); 
            set(findobj('Tag', 'chkboxlelfpStimulus'), 'Visible', 'Off');         
    end
% --- Executes during object creation, after setting all properties.

function pumlelfpRecType_CreateFcn(hObject, eventdata, handles)
    %%
% hObject    handle to pumlelfpRecType (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes on button press in chkboxlelfpIm.
function chkboxlelfpIm_Callback(hObject, eventdata, handles)
    %%
% hObject    handle to chkboxlelfpIm (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of chkboxlelfpIm

    if (get(hObject,'Value') == get(hObject,'Max'))
        % Checkbox is checked
        setappdata(findobj('Tag','figlfpLatencyEstimator'),'Im',1);
    else
        % Checkbox is not checked
        setappdata(findobj('Tag','figlfpLatencyEstimator'),'Im',0);        
    end    

% --- Executes on button press in chkboxlelfpVm.
function chkboxlelfpVm_Callback(hObject, eventdata, handles)
    %%
% hObject    handle to chkboxlelfpVm (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of chkboxlelfpVm

    if (get(hObject,'Value') == get(hObject,'Max'))
        % Checkbox is checked
        setappdata(findobj('Tag','figlfpLatencyEstimator'),'Vm',1);
    else
        % Checkbox is not checked
        setappdata(findobj('Tag','figlfpLatencyEstimator'),'Vm',0);        
    end    
    
% --- Executes on button press in chkboxlelfpStimulus.
function chkboxlelfpStimulus_Callback(hObject, eventdata, handles)
    %%
% hObject    handle to chkboxlelfpStimulus (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of chkboxlelfpStimulus

    if (get(hObject,'Value') == get(hObject,'Max'))
        % Checkbox is checked
        setappdata(findobj('Tag','figlfpLatencyEstimator'),'Stimulus',1);
    else
        % Checkbox is not checked
        setappdata(findobj('Tag','figlfpLatencyEstimator'),'Stimulus',0);        
    end    
    
% --- Executes on button press in chkboxlelfpVj.
function chkboxlelfpVj_Callback(hObject, eventdata, handles)
    %%
% hObject    handle to chkboxlelfpVj (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of chkboxlelfpVj

    if (get(hObject,'Value') == get(hObject,'Max'))
        % Checkbox is checked
        setappdata(findobj('Tag','figlfpLatencyEstimator'),'Vj',1);
    else
        % Checkbox is not checked
        setappdata(findobj('Tag','figlfpLatencyEstimator'),'Vj',0);        
    end    
    
% --- Executes on button press in chkboxlelfpVavg.
function chkboxlelfpVavg_Callback(hObject, eventdata, handles)
    %%
% hObject    handle to chkboxlelfpVavg (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of chkboxlelfpVavg
    if (get(hObject,'Value') == get(hObject,'Max'))
        % Checkbox is checked
        setappdata(findobj('Tag','figlfpLatencyEstimator'),'Vavg',1);
    else
        % Checkbox is not checked
        setappdata(findobj('Tag','figlfpLatencyEstimator'),'Vavg',0);        
    end    


% --- Executes on button press in tblelfpZoom.
function tblelfpZoom_Callback(hObject, eventdata, handles)
%%
% hObject    handle to tblelfpZoom (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of tblelfpZoom

    button_state = get(hObject,'Value');
    if button_state == get(hObject,'Max')
	% Toggle button is pressed, take appropriate action
        zoom on;
        fh = findobj('Tag','tblelfpDataCursor');
        if (get(fh, 'Value')== get(fh,'Max'))
            set(fh,'Value',0);
        end
        fh = findobj('Tag','tblelfpPan');
        if (get(fh, 'Value')== get(fh,'Max'))
            set(fh,'Value',0);
        end           
    elseif button_state == get(hObject,'Min')
	% Toggle button is not pressed, take appropriate action
        zoom off;
    end

% --- Executes on button press in tblelfpDataCursor.
function tblelfpDataCursor_Callback(hObject, eventdata, handles)
%%
% hObject    handle to tblelfpDataCursor (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of tblelfpDataCursor

    button_state = get(hObject,'Value');
    if button_state == get(hObject,'Max')
	% Toggle button is pressed, take appropriate action
        datacursormode on;
        dcm_obj=datacursormode(findobj('Tag','figlfpLatencyEstimator'));
        set(dcm_obj,'UpdateFcn',@mylelfpupdatefcn);
        
        fh = findobj('Tag','tblelfpZoom');
        if (get(fh, 'Value')== get(fh,'Max'))
            set(fh,'Value',0);
        end
        
        fh = findobj('Tag','tblelfpPan');
        if (get(fh, 'Value')== get(fh,'Max'))
            set(fh,'Value',0);
        end           
    elseif button_state == get(hObject,'Min')
	% Toggle button is not pressed, take appropriate action
        datacursormode off;
    end
    
    
function txt = mylelfpupdatefcn(empt,event_obj)
%%
%This function is for updating the data cursor text
    pos = get(event_obj,'Position');
    txt = {['Time: ',num2str(pos(1)),' ms'],...
        ['Amplitude: ',num2str(pos(2))],' mV'};  

% --- Executes on button press in btnlelfpResetGraph.
function btnlelfpResetGraph_Callback(hObject, eventdata, handles)
%%
% hObject    handle to btnlelfpResetGraph (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

    fh = findobj('Tag','tblelfpZoom');
    if (get(fh, 'Value')== get(fh,'Max'))
        set(fh,'Value',0);
    end
    
    fh = findobj('Tag','tblelfpDataCursor');
    if (get(fh, 'Value')== get(fh,'Max'))
        set(fh,'Value',0);
    end    
    
    fh = findobj('Tag','tblelfpPan');
    if (get(fh, 'Value')== get(fh,'Max'))
        set(fh,'Value',0);
    end       
    
    datacursormode off;
    
    zoom off;
    
    pan off;
    
    axis('tight');


% --- Executes on button press in tblelfpPan.
function tblelfpPan_Callback(hObject, eventdata, handles)
% hObject    handle to tblelfpPan (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of tblelfpPan

    button_state = get(hObject,'Value');
    if button_state == get(hObject,'Max')
	% Toggle button is pressed, take appropriate action
        pan on;

        
        fh = findobj('Tag','tblelfpZoom');
        if (get(fh, 'Value')== get(fh,'Max'))
            set(fh,'Value',0);
        end
        fh = findobj('Tag','tblelfpDataCursor');
        if (get(fh, 'Value')== get(fh,'Max'))
            set(fh,'Value',0);
        end        
    elseif button_state == get(hObject,'Min')
	% Toggle button is not pressed, take appropriate action
        pan off;
    end

 % --- Executes on button press in btnlelfpMoveUp.
function btnlelfpMoveUp_Callback(hObject, eventdata, handles)
%%
% hObject    handle to btnlelfpMoveUp (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
   
    fh = findobj('Tag', 'lstboxlelfpContent');
    listbox_contents = get(fh, 'String');
    selected_index = get(fh, 'Value');    
    
    if (~isempty(listbox_contents) && (selected_index > 1)&&(selected_index <= length(listbox_contents)))
        index = get(fh,'Value');
        tempFile=listbox_contents{index};
        listbox_contents{index}=listbox_contents{index-1};
        listbox_contents{index-1}=tempFile;
        set(fh, 'String', listbox_contents, ... 
            'Value', min(index,length(listbox_contents))); 
        setappdata(findobj('Tag','figlfpLatencyEstimator'),'fileNames',listbox_contents);
        set(fh,'Value',index-1)
    end

    if(selected_index == 1)
        set(findobj('Tag','btnlelfpMoveUp'),'Enable', 'Off');
        set(findobj('Tag','btnlelfpMoveDown'),'Enable', 'On');        
    else
        set(findobj('Tag','btnlelfpMoveUp'),'Enable', 'On');        
    end    

    if(selected_index == length(listbox_contents))
        set(findobj('Tag','btnlelfpMoveDown'),'Enable', 'Off');
        set(findobj('Tag','btnlelfpMoveUp'),'Enable', 'On');
    else
        set(findobj('Tag','btnlelfpMoveDown'),'Enable', 'On');        
    end  

 % --- Executes on button press in btnlelfpMoveDown.
function btnlelfpMoveDown_Callback(hObject, eventdata, handles)
%%
% hObject    handle to btnlelfpMoveDown (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

    fh = findobj('Tag', 'lstboxlelfpContent');    
    listbox_contents = get(fh, 'String');
    selected_index = get(fh, 'Value');
    

    if (~isempty(listbox_contents) && (selected_index >= 1)&&(selected_index < length(listbox_contents)))
        index = get(fh,'Value');
        tempFile=listbox_contents{index};
        listbox_contents{index}=listbox_contents{index+1};
        listbox_contents{index+1}=tempFile;
        set(fh, 'String', listbox_contents, ... 
            'Value', min(index,length(listbox_contents))); 
        setappdata(findobj('Tag','figlfpLatencyEstimator'),'fileNames',listbox_contents);
        set(fh,'Value',index+1)        
    end     

    if(selected_index == 1)
        set(findobj('Tag','btnlelfpMoveUp'),'Enable', 'Off');
        set(findobj('Tag','btnlelfpMoveDown'),'Enable', 'On');        
    else
        set(findobj('Tag','btnlelfpMoveUp'),'Enable', 'On');        
    end    

    if(selected_index == length(listbox_contents))
        set(findobj('Tag','btnlelfpMoveDown'),'Enable', 'Off');
        set(findobj('Tag','btnlelfpMoveUp'),'Enable', 'On');
    else
        set(findobj('Tag','btnlelfpMoveDown'),'Enable', 'On');        
    end


function txtlelfpCutoffFreq_Callback(hObject, eventdata, handles)
%%
% hObject    handle to txtlelfpCutoffFreq (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of txtlelfpCutoffFreq as text
%        str2double(get(hObject,'String')) returns contents of txtlelfpCutoffFreq as a double



% --- Executes during object creation, after setting all properties.

function txtlelfpCutoffFreq_CreateFcn(hObject, eventdata, handles)
%%
% hObject    handle to txtlelfpCutoffFreq (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function txtlelfpManualOnset_Callback(hObject, eventdata, handles)
%%
% hObject    handle to txtlelfpManualOnset (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of txtlelfpManualOnset as text
%        str2double(get(hObject,'String')) returns contents of txtlelfpManualOnset as a double


% --- Executes during object creation, after setting all properties.
function txtlelfpManualOnset_CreateFcn(hObject, eventdata, handles)
%%
% hObject    handle to txtlelfpManualOnset (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function txtlelfpManualFirstPeak_Callback(hObject, eventdata, handles)
%%
% hObject    handle to txtlelfpManualFirstPeak (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of txtlelfpManualFirstPeak as text
%        str2double(get(hObject,'String')) returns contents of txtlelfpManualFirstPeak as a double


% --- Executes during object creation, after setting all properties.
function txtlelfpManualFirstPeak_CreateFcn(hObject, eventdata, handles)
%%
% hObject    handle to txtlelfpManualFirstPeak (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in btnlelfpSaveTraceParameters.
function btnlelfpSaveTraceParameters_Callback(hObject, eventdata, handles)
%%
% hObject    handle to btnlelfpSaveTraceParameters (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

    fh = findobj('Tag','figlfpLatencyEstimator');

    s = getappdata(fh,'signal');
    t = getappdata(fh,'time');

    t_SS = getappdata(fh,'t_SS');
    t_RS = str2double(get(findobj('Tag','txtlelfpManualOnset'),'String'));
    l_RS = t_RS - t_SS;
    posRS = find(t == t_RS);
    v_RS = s(posRS);
    t_P1 = str2double(get(findobj('Tag','txtlelfpManualFirstPeak'),'String'));
    posP1 = find(t == t_P1);
    v_P1 = s(posP1);
    l_P1 = t_P1 - t_RS;
    t_P2 = getappdata(fh,'t_P2');
    v_P2 = getappdata(fh,'v_P2');
    l_P2 = t_P2 - t_RS;
    t_P3 = getappdata(fh,'t_P3');
    v_P3 = getappdata(fh,'v_P3');
    l_P3 = t_P3 - t_RS;
    t_P4 = getappdata(fh,'t_P4');
    v_P4 = getappdata(fh,'v_P4');
    l_P4 = t_P4 - t_RS;


    fh_fileName = findobj('Tag', 'lstboxlelfpContent');    
    listbox_contents = get(fh_fileName, 'String');
    selected_index = get(fh_fileName, 'Value');

    cla(findobj('Tag','axlelfpMain'))
    hold on

    plot(t, s,'r');
    plot(t_RS, v_RS, 'go');
    if ~isnan(v_P1)
        plot(t_P1, v_P1, 'bo');
    end
    plot(t_P2, v_P2, 'ko');
    plot(t_P3, v_P3, 'co');
    if ~isnan(v_P4)
        plot(t_P4, v_P4, 'yo');
    end
    title(['Plot of Selected File: ',listbox_contents{selected_index}]);
    axis('tight');
    hold off
    grid on

    fh_lblLatency=findobj('Tag','lbllelfpLatency');
    set(fh_lblLatency,'String','');
    msgStr=sprintf(['Stimulus Onset is at %15.8f ms and the Response Onset is at %15.8f ms. \n'...
        'The calculated values are:\n',...
        'First Peak is at %15.8f ms, Amplitude %10.5f mV, Latency from Response Onset %15.8f ms\n',...
        'Second Peak is at %15.8f ms, Amplitude %10.5f mV, Latency from Response Onset %15.8f ms\n',...
        'Third Peak is at %15.8f ms, Amplitude %10.5f mV, Latency from Response Onset %15.8f ms\n'...
        'Fourth Peak is at %15.8f ms, Amplitude %10.5f mV, Latency from Response Onset %15.8f ms'],...
        t_SS*1000,t_RS*1000,t_P1*1000,v_P1,l_P1*1000,t_P2*1000,v_P2,l_P2*1000,t_P3*1000,v_P3,l_P3*1000,t_P4*1000,v_P4,l_P4*1000);
    set(fh_lblLatency,'String',msgStr);

    try    
        oldPath=pwd;
        directoryPath=getappdata(fh,'directoryPath');

        numberOfParameters = 16;

        fileFormat='\n%13s\t%16.8f\t%16.8f\t%16.8f\t%16.8f\t%16.8f\t%16.8f\t%16.8f\t%16.8f\t%16.8f\t%16.8f\t%16.8f\t';
        headerFormat='%13s\t%16s\t%16s\t%16s\t%16s\t%16s\t%16s\t%16s\t%16s\t%16s\t%16s\t%16s\t';

        headerContent=sprintf(headerFormat,'File Name','t_stimulus (ms)','t_response (ms)','latency_response (ms)','v_Peak1 (uV)','latency_Peak1 (ms)','v_Peak2 (uV)','latency_Peak2 (ms)','v_Peak3 (uV)','latency_Peak3 (ms)','v_Peak4 (uV)','latency_Peak4 (ms)');

        cd(directoryPath);

        tmpStr=strrep(datestr(clock),':','');
        tmpStr=strrep(tmpStr,'-','');
        tmpStr=strrep(tmpStr,' ','-');
        tempFileName= inputdlg('Enter the File Name for Saving, without File Extension','Save As',1);
        saveFileName=[tmpStr,'-',tempFileName{1},'.xls'];

        fid=fopen(saveFileName,'w');

        if(fid==-1)
            msgbox(['Sorry, the file ', saveFileName,' cannot be opened!'],'File Opening Error','Error');
        else
            fprintf(fid,headerContent);
            fprintf(fid,fileFormat,listbox_contents{selected_index},t_SS*1000,t_RS*1000,l_RS*1000, v_P1*1000, l_P1*1000, v_P2*1000, l_P2*1000, v_P3*1000, l_P3*1000, v_P4*1000, l_P4*1000);
        end

        fclose('all');

        msgString={datestr(clock),'Data File Containing the Parameters Detected is Saved at ', directoryPath};
        msgbox(msgString,'Program Execution Success','help'); 

        cd(oldPath);
    catch exception1
        errordlg('There were errors in opening the data files','File Opening Error');
    end


% --- Executes on button press in btnlelfpSaveFiltered.
function btnlelfpSaveFiltered_Callback(hObject, eventdata, handles)
%%
% hObject    handle to btnlelfpSaveFiltered (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

    fileNames = get(findobj('Tag', 'lstboxlelfpContent'), 'String');
    selected_index = get(findobj('Tag', 'lstboxlelfpContent'), 'Value');
    fh = findobj('Tag','figlfpLatencyEstimator');
    setappdata(fh,'selectedFileName',fileNames{selected_index});
    
    filePath = getappdata(fh, 'directoryPath');
        
    [checkedColumns, flag] = selectedColumns();
    
    for i = 1:length(fileNames)
        if(flag)  
            signalType=getappdata(findobj('Tag','figlfpLatencyEstimator'),'signalType');

            fh_Cutoff = findobj('Tag','txtlelfpCutoffFreq');
            get(fh_Cutoff,'String');
            cutoffFreq=str2double(get(fh_Cutoff,'String'));

            finalPath=[filePath,fileNames{i}];
            data = load (finalPath);
                     
            color = {'r','g','b','c','m','y','k'};        
            cla(findobj('Tag','axlelfpMain'));
            columns = length(checkedColumns);
            
            [t_SS,v_SS,t_RS,v_RS,t_P1,v_P1,l_P1,t_P2,v_P2,l_P2,t_P3,v_P3,l_P3,t_P4,v_P4,l_P4,s,t,flag] = detectLatencyInAvgV3(filePath, fileNames{i}, cutoffFreq, signalType);
            
            if (flag)
            hold on
            for j=1:1:columns-1
                plot(t, s,color{j});
                plot(t_RS, v_RS, 'go');
                if ~isnan(v_P1)
                    plot(t_P1, v_P1, 'bo');
                end
                plot(t_P2, v_P2, 'ko');
                plot(t_P3, v_P3, 'co');
                if ~isnan(v_P4)
                    plot(t_P4, v_P4, 'yo');
                end
                title(['Plot of Selected Column: ',num2str(j)]);
            end
            axis('tight');
            hold off
            grid on
            else         
                plot(t, s,'r');
                errordlg(['File ', fileNames{i}, ' doesnot match the detection criterion'], 'File Selection Error')            
            end
            fh_lblLatency=findobj('Tag','lbllelfpLatency');
            set(fh_lblLatency,'String','');
            msgStr=sprintf(['Stimulus Onset is at %15.8f ms and the Response Onset is at %15.8f ms. \n'...
                'The calculated values are:\n',...
                'First Peak is at %15.8f ms, Amplitude %10.5f mV, Latency from Response Onset %15.8f ms\n',...
                'Second Peak is at %15.8f ms, Amplitude %10.5f mV, Latency from Response Onset %15.8f ms\n',...
                'Third Peak is at %15.8f ms, Amplitude %10.5f mV, Latency from Response Onset %15.8f ms\n'...
                'Fourth Peak is at %15.8f ms, Amplitude %10.5f mV, Latency from Response Onset %15.8f ms'],...
                t_SS*1000,t_RS*1000,t_P1*1000,v_P1,l_P1*1000,t_P2*1000,v_P2,l_P2*1000,t_P3*1000,v_P3,l_P3*1000,t_P4*1000,v_P4,l_P4*1000);
            set(fh_lblLatency,'String',msgStr);
            
            newData = [];
            newData = [t, s];
            
            newFileName = ['filtered-',fileNames{i}];
            cdCurr = pwd;
            cd(filePath)
            save(newFileName, 'newData', '-ascii', '-tabs')
            cd(cdCurr)            

            pause(0.10)
        end
    end
    msgbox(['The filtered files are saved successfully at ', filePath],'Operation Complete','help')


% --- Executes on button press in btnlelfplaOrder.
function btnlelfplaOrder_Callback(hObject, eventdata, handles)
%%
% hObject    handle to btnlelfplaOrder (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
    try    
% 
        fh = findobj('Tag','figlfpLatencyEstimator');
        oldPath=pwd;
        directoryPath=getappdata(fh,'directoryPath');

        fh_Cutoff = findobj('Tag','txtlelfpCutoffFreq');
        get(fh_Cutoff,'String');
        cutoffFreq=str2double(get(fh_Cutoff,'String'));


        fileNames=getappdata(fh,'fileNames');

        numberOfParameters = 16;

        Results = zeros(length(fileNames), numberOfParameters);

        signalType=getappdata(findobj('Tag','figlfpLatencyEstimator'),'signalType');

        latMat=[];
        respLatMat=[];
        
        if (isequal(signalType,3)) %if signal source is Transistor recording
            flagFET=1;
        else
            flagFET=0;
        end
        
        depthArray = 80:80:1520;
        
        for i=1:length(fileNames)

%             if (~flagFET)
%                 fileName=fileNames{i};
%             else
%                 tempFileName=fileNames{i};
%                 alpPos=find(isletter(tempFileName)==1);
%                 numPos=find(isletter(tempFileName)==0);
%                 if alpPos(1)>numPos(1)
%                     fileName=tempFileName(alpPos(1):end);
%                 else
%                     newAlpPos=find(isletter(tempFileName(numPos(1):end))==1);
%                     fileName=tempFileName(numPos(1)+newAlpPos(1):end);
%                 end
%             end
%             
%             if (i<length(fileNames))              
%                 if (~flagFET)
%                     compFileName=fileNames{i+1};
%                 else
%                     tempCompFileName=fileNames{i+1};
%                     alpPos=find(isletter(tempCompFileName)==1);
%                     numPos=find(isletter(tempCompFileName)==0);
%                     if alpPos(1)>numPos(1)
%                         compFileName=tempCompFileName(alpPos(1):end);
%                     else
%                         newAlpPos=find(isletter(tempCompFileName(numPos(1):end))==1);
%                         compFileName=tempCompFileName(numPos(1)+newAlpPos(1):end);
%                     end
%                 end
%             else
%                 if (~flagFET)
%                     compFileName=fileNames{i-1};
%                 else
%                     tempCompFileName=fileNames{i-1};
%                     alpPos=find(isletter(tempCompFileName)==1);
%                     numPos=find(isletter(tempCompFileName)==0);
%                     if alpPos(1)>numPos(1)
%                         compFileName=tempCompFileName(alpPos(1):end);
%                     else
%                         newAlpPos=find(isletter(tempCompFileName(numPos(1):end))==1);
%                         compFileName=tempCompFileName(numPos(1)+newAlpPos(1):end);
%                     end
%                 end
%             end
% 
%             diff=find(fileName(1:length(fileName))~=compFileName(1:length(fileName)));
%             indx=diff(1);
%             
%             if (indx>=3)
%                 tempIndx=indx-2;
%                 cond=1;
%                 while(cond)
%                     if (fileName(tempIndx)>='0' && fileName(tempIndx)<='9')
%                         temp=str2num(fileName(tempIndx:indx));
%                         if isempty(temp)
%                             tempIndx=tempIndx+1;
%                         else
%                             cond=0;
%                         end                        
%                     else
%                         tempIndx=tempIndx+1;
%                     end                   
%                 end
%                 indx=tempIndx;
%             end
%             
%             if fileName(indx)=='+'
%                 continue;
%             elseif fileName(indx)=='-'
%                 j=1;
%                 tmp=fileName(indx);
%                 while(fileName(indx+j)>='0' && fileName(indx+j)<='9')
%                     tmp(j+1)=fileName(indx+j);
%                     j=j+1;
%                 end                
%             elseif fileName(indx)>='0' && fileName(indx)<='9'
%                 j=1;
%                 tmp=fileName(indx);
%                 while(fileName(indx+j)>='0' && fileName(indx+j)<='9')
%                     tmp(j+1)=fileName(indx+j);
%                     j=j+1;
%                 end               
%             end
%             
%             depth=str2num(tmp);
%             
%             if (flagFET)
%                 fileName=tempFileName;
%             end
            
%             [t_SS,v_SS,t_RS,v_RS,t_P1,v_P1,l_P1,t_P2,v_P2,l_P2,t_P3,v_P3,
%             l_P3,t_P4,v_P4,l_P4,s,t,flag] =  detectLatencyInAvgV3(directoryPath, fileName, cutoffFreq, signalType);

            depth = depthArray(i); % disable if pipette recordings
            fileName = fileNames{i};

            [t_SS,v_SS,t_RS,v_RS,t_P1,v_P1,l_P1,t_P2,v_P2,l_P2,t_P3,v_P3,l_P3,t_P4,v_P4,l_P4,s,t,flag] =  detectLatencyInAvgV5StimOnset(directoryPath, fileName, cutoffFreq, signalType);

            
            latMat=[latMat;depth, (l_P2*1000)];
            respLatMat=[respLatMat; depth, ((t_RS-t_SS)*1000)];
        end
        
    catch exception1
        errordlg('There were errors in opening the data files','File Opening Error');
    end
    
    %calculate layer activation order
    
%     layerActivationOrder(latMat(:,2),latMat(:,1));

%     layerActivationOrderByLFP(latMat,'XXX');
    layerActivationOrderByCSD(latMat);
% %     
%% This portion of the program is meant for continual creation of layer activation graphs from a defined path

%     fh = findobj('Tag','figlfpLatencyEstimator');
%     oldPath=pwd;
% 
%     fh_Cutoff = findobj('Tag','txtlelfpCutoffFreq');
%     get(fh_Cutoff,'String');
%     cutoffFreq=str2double(get(fh_Cutoff,'String'));
% 
%     numberOfParameters = 16;
% 
%     signalType=getappdata(findobj('Tag','figlfpLatencyEstimator'),'signalType');
%     
%     folderNameFormat='DataSet%05d';
%     path='E:\In-Vivo Recordings\ClusteredLFPs-DataSets-20091022\';
%     figureNameFormat='Figure-%s.jpg';
%     foldersToSelect=(1:1:5527);
%     
% %     foldersToSelect=sort(randi([1 4532], 2, 1)); 
% 
% %     aviObj=avifile('E:\In-Vivo Recordings\ClusteredLFPs-DataSets\2LFPFigures\lao.avi','FPS',3);
%     
%     for k=1:length(foldersToSelect)
%         folderName=sprintf(folderNameFormat, foldersToSelect(k));
%         directoryPath=[path folderName '\'];
% 
%         fileNames=getDirContents(directoryPath,'*.txt');
% 
%         try    
%             Results = zeros(length(fileNames), numberOfParameters);
%             latMat=[];
%             respLatMat=[];
% 
%             if (isequal(signalType,3)) %if signal source is Transistor recording
%                 flagFET=1;
%             else
%                 flagFET=0;
%             end
% 
%             for i=1:length(fileNames)
% 
%                 if (~flagFET)
%                     fileName=fileNames{i};
%                 else
%                     tempFileName=fileNames{i};
%                     alpPos=find(isletter(tempFileName)==1);
%                     numPos=find(isletter(tempFileName)==0);
%                     if alpPos(1)>numPos(1)
%                         fileName=tempFileName(alpPos(1):end);
%                     else
%                         newAlpPos=find(isletter(tempFileName(numPos(1):end))==1);
%                         fileName=tempFileName(numPos(1)+newAlpPos(1):end);
%                     end
%                 end
% 
%                 if (i<length(fileNames))              
%                     if (~flagFET)
%                         compFileName=fileNames{i+1};
%                     else
%                         tempCompFileName=fileNames{i+1};
%                         alpPos=find(isletter(tempCompFileName)==1);
%                         numPos=find(isletter(tempCompFileName)==0);
%                         if alpPos(1)>numPos(1)
%                             compFileName=tempCompFileName(alpPos(1):end);
%                         else
%                             newAlpPos=find(isletter(tempCompFileName(numPos(1):end))==1);
%                             compFileName=tempCompFileName(numPos(1)+newAlpPos(1):end);
%                         end
%                     end
%                 else
%                     if (~flagFET)
%                         compFileName=fileNames{i-1};
%                     else
%                         tempCompFileName=fileNames{i-1};
%                         alpPos=find(isletter(tempCompFileName)==1);
%                         numPos=find(isletter(tempCompFileName)==0);
%                         if alpPos(1)>numPos(1)
%                             compFileName=tempCompFileName(alpPos(1):end);
%                         else
%                             newAlpPos=find(isletter(tempCompFileName(numPos(1):end))==1);
%                             compFileName=tempCompFileName(numPos(1)+newAlpPos(1):end);
%                         end
%                     end
%                 end
% 
%                 diff=find(fileName(1:length(fileName))~=compFileName(1:length(fileName)));
%                 indx=diff(1);
% 
%                 if (indx>=3)
%                     tempIndx=indx-2;
%                     cond=1;
%                     while(cond)
%                         if (fileName(tempIndx)>='0' && fileName(tempIndx)<='9')
%                             temp=str2num(fileName(tempIndx:indx));
%                             if isempty(temp)
%                                 tempIndx=tempIndx+1;
%                             else
%                                 cond=0;
%                             end                        
%                         else
%                             tempIndx=tempIndx+1;
%                         end                   
%                     end
%                     indx=tempIndx;
%                 end
% 
%                 if fileName(indx)=='+'
%                     continue;
%                 elseif fileName(indx)>='0' && fileName(indx)<='9'
%                     j=1;
%                     tmp=fileName(indx);
%                     while(fileName(indx+j)>='0' && fileName(indx+j)<='9')
%                         tmp(j+1)=fileName(indx+j);
%                         j=j+1;
%                     end               
%                 end
% 
%                 depth=str2num(tmp);
% 
%                 if (flagFET)
%                     fileName=tempFileName;
%                 end
% 
%                 [t_SS,v_SS,t_RS,v_RS,t_P1,v_P1,l_P1,t_P2,v_P2,l_P2,t_P3,v_P3,l_P3,t_P4,v_P4,l_P4,s,t,flag] =  detectLatencyInAvgV3(directoryPath, fileName, cutoffFreq, signalType);
% 
%                 latMat=[latMat;depth, (l_P2*1000)];
%                 respLatMat=[respLatMat; depth, ((t_RS-t_SS)*1000)];
%             end
% 
%         catch exception1
%             errordlg('There were errors in opening the data files','File Opening Error');
%         end
% 
%         %calculate layer activation order
% 
%     %     layerActivationOrder(latMat(:,2),latMat(:,1));
%         layerActivationOrderByLFP(latMat, folderName);
%         
% %         M=getframe(gcf);
% %         aviObj = addframe(aviObj,M);         
%         
%         currDir=cd('E:\In-Vivo Recordings\ClusteredLFPs-DataSets-20091022\2LFPFigures\');
%         figureName=sprintf(figureNameFormat,folderName);
%         print(gcf,'-djpeg',figureName);
%         cd(currDir);
%         close(gcf);
%     end  
%     
% %     aviObj=close(aviObj);
%     
%     
% 
% %     figure('Name','Latencies of the Maximum Negative Peak in LFPs','NumberTitle', 'Off');
% %     plot(latMat(:,1),latMat(:,2),'o-');
% %     title('Latencies of the Maximum Negative Peak in LFPs');
% %     set(gca,'XTick',latMat(:,1));
% %     xlabel('recording depths [um]');
% %     ylabel('latency [ms]');
% %     grid on;
% %     
% %     figure('Name','Latencies of the Response Onset in LFPs','NumberTitle', 'Off');
% %     plot(respLatMat(:,1),respLatMat(:,2),'o-');
% %     title('Latencies of the  Response Onset in LFPs');
% %     set(gca,'XTick',respLatMat(:,1));    
% %     xlabel('recording depths [um]');
% %     ylabel('latency [ms]');    
% %     grid on;    


% --- Executes on button press in chkboxlelfpDepthProfile.
function chkboxlelfpDepthProfile_Callback(hObject, eventdata, handles)
% hObject    handle to chkboxlelfpDepthProfile (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of chkboxlelfpDepthProfile

    if (get(hObject,'Value') == get(hObject,'Max'))
        % Checkbox is checked
        setappdata(findobj('Tag','figlfpLatencyEstimator'),'DepthProfile',1);
    else
        % Checkbox is not checked
        setappdata(findobj('Tag','figlfpLatencyEstimator'),'DepthProfile',0);        
    end  


% --- Executes during object creation, after setting all properties.
function axslelfpSigMate_CreateFcn(hObject, eventdata, handles)
% hObject    handle to axslelfpSigMate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: place code in OpeningFcn to populate axslelfpSigMate
    axes(hObject)
    pathLogo = which('SigMate-Logo');
    imshow([pathLogo '\' 'SigMate-Logo.gif'])
