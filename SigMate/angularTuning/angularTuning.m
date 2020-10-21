function varargout = angularTuning(varargin)
% ANGULARTUNING M-file for angularTuning.fig
%      ANGULARTUNING, by itself, creates a new ANGULARTUNING or raises the existing
%      singleton*.
%
%      H = ANGULARTUNING returns the handle to a new ANGULARTUNING or the handle to
%      the existing singleton*.
%
%      ANGULARTUNING('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in ANGULARTUNING.M with the given input arguments.
%
%      ANGULARTUNING('Property','Value',...) creates a new ANGULARTUNING or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before FirstGUI_OpeningFunction gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to angularTuning_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help angularTuning

% Last Modified by GUIDE v2.5 04-May-2012 17:46:59

% Begin initialization code - DO NOT EDIT


gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @angularTuning_OpeningFcn, ...
                   'gui_OutputFcn',  @angularTuning_OutputFcn, ...
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

% --- Executes just before angularTuning is made visible.
function angularTuning_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to angularTuning (see VARARGIN)

% Choose default command line output for angularTuning
handles.output = hObject;

set(handles.figAngularTuning, 'CloseRequestFcn', 'closeGUI');

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes angularTuning wait for user response (see UIRESUME)
% uiwait(handles.figAngularTuning);

%%

% --- Outputs from this function are returned to the command line.
function varargout = angularTuning_OutputFcn(hObject, eventdata, handles) 
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

% --- Executes on button press in btnatBrowse.
function btnatBrowse_Callback(hObject, eventdata, handles)
% hObject    handle to btnatBrowse (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
    
%     global filelist, filenames
    
    %clear if any application data exists
    
    fh = findobj('Tag', 'figAngularTuning');    

    if getappdata(fh,'ContinuousAnalysis')==0    
        if(isappdata(fh,'latencyMatrix'))
            rmappdata(fh,'latencyMatrix');
            rmappdata(fh,'amplitudeMatrix');
        end
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
        handle_lblPath = findobj('Tag', 'lblatPath'); % find the object with the Tag lblatPath and store the reference handle

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
        set(findobj('Tag','lstboxatContent'),'String',handles.file_names,...
            'Value',1);
        set(findobj('Tag','btnatLoad'),'Enable', 'On');
        set(findobj('Tag','btnatLoad'),'String', 'Load Data Files');        
        set(findobj('Tag','btnatRemoveFile'),'Enable', 'On');
       
        if (strcmpi(get(findobj('Tag','btnAngularTuning'),'Enable'),'On'))
            set(findobj('Tag','btnAngularTuning'),'Enable', 'Off');
        end
        
        if (strcmpi(get(findobj('Tag','btnatCalculateLatencies'),'Enable'),'On'))
            set(findobj('Tag','btnatCalculateLatencies'),'Enable', 'Off');
        end        
        
        set(findobj('Tag','chkboxatCh1'),'Enable', 'On');
        set(findobj('Tag','chkboxatCh2'),'Enable', 'On');
        set(findobj('Tag','chkboxatCh3'),'Enable', 'On');
        set(findobj('Tag','chkboxatCh4'),'Enable', 'On');
        set(findobj('Tag','chkboxatCh5'),'Enable', 'On');
        
        set(findobj('Tag','btnatMoveUp'),'Enable', 'On');
        set(findobj('Tag','btnatMoveDown'),'Enable', 'On');
        
    else %if the directory selection dialog is cancelled
        
        msgbox('Please Select a Directory for Analysis', 'Directory Not Selected','Error');
    end

    listbox_contents = get(findobj('Tag', 'lstboxatContent'), 'String');
    selected_index = get(findobj('Tag', 'lstboxatContent'), 'Value');    
    if(selected_index == 1)
        set(findobj('Tag','btnatMoveUp'),'Enable', 'Off');
    elseif(selected_index == length(listbox_contents))
        set(findobj('Tag','btnatMoveDown'),'Enable', 'Off');        
    end


%%

% --- Executes on button press in btnatLoad.
function btnatLoad_Callback(hObject, eventdata, handles)
% hObject    handle to btnatLoad (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

    figure_handle = findobj('Tag', 'figAngularTuning');
    
    listbox_contents = get(findobj('Tag', 'lstboxatContent'), 'String');    
            
    [checkedColumns, flag]=selectedColumns();
    
    rawRecordings = getappdata(figure_handle, 'RawRecordings');
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
        
        waitbarMsg ={'Please Wait... Loading Data Files...', 'Now Loading File: ', listbox_contents{1}};
        h=waitbar(0,waitbarMsg,'Name','Loading Data Files');         
        
        if columns>5
            
            fet_data(:,1:columns-1)=tempData(:,2:end);
            
            if channelOverlap
                set(findobj('Tag','chkboxatOvCh'),'Value', 0);
            end
            
        else
        
            if rawRecordings
                
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
                        updatedWaitBarMsg={'Please Wait... Loading Data Files...', 'Now Loading File: ', listbox_contents{i}};
                        waitbar(i/length(listbox_contents),h,updatedWaitBarMsg);
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
                        updatedWaitBarMsg={'Please Wait... Loading Data Files...', 'Now Loading File: ', listbox_contents{i}};
                        waitbar(i/length(listbox_contents),h,updatedWaitBarMsg);                           
                    end            
                end
            else % if the recordings selected are whole depth profile separated in individual files
                for i = 1:length(listbox_contents)
                    data = load([directoryPath listbox_contents{i}]);
                    data = filtfilt(b,a,data);
                    fet_data(:,i)=data(:,2);
                    updatedWaitBarMsg={'Please Wait... Loading Data Files...', 'Now Loading File: ', listbox_contents{i}};
                    waitbar(i/length(listbox_contents),h,updatedWaitBarMsg);                       
                end
            end
        end

        close(h);
        
        setappdata(figure_handle, 'fet_time', fet_time);
        setappdata(figure_handle, 'fet_data', fet_data);        
        setappdata(figure_handle, 'samplingFreq', Fs);
%         setappdata(figure_handle, 'dataPoints', dataPoints);        

        set(findobj('Tag','btnatLoad'),'String', 'Data Files Loaded');
        set(findobj('Tag','btnatLoad'),'Enable', 'Off');
        set(findobj('Tag','btnatMoveUp'),'Enable', 'Off');
        set(findobj('Tag','btnatMoveDown'),'Enable', 'Off');           

        set(findobj('Tag','btnatRemoveFile'),'Enable', 'Off');
        set(findobj('Tag','chkboxatCh1'),'Enable', 'Off');
        set(findobj('Tag','chkboxatCh2'),'Enable', 'Off');
        set(findobj('Tag','chkboxatCh3'),'Enable', 'Off');
        set(findobj('Tag','chkboxatCh4'),'Enable', 'Off');
        set(findobj('Tag','chkboxatCh5'),'Enable', 'Off');

        if (strcmpi(get(findobj('Tag','btnatCalculateLatencies'),'Enable'),'Off'))
            set(findobj('Tag','btnatCalculateLatencies'),'Enable', 'On');
        end
        
        if (strcmpi(get(findobj('Tag','btnAngularTuning'),'Enable'),'Off'))
            set(findobj('Tag','btnAngularTuning'),'Enable', 'On');
        end
        
    end
        
%%

% --- Executes on selection change in lstboxatContent.
function lstboxatContent_Callback(hObject, eventdata, handles)
% hObject    handle to lstboxatContent (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = get(hObject,'String') returns lstboxatContent contents as cell array
%        contents{get(hObject,'Value')} returns selected item from lstboxatContent

    listbox_contents = get(findobj('Tag', 'lstboxatContent'), 'String');
    selected_index = get(findobj('Tag', 'lstboxatContent'), 'Value');
    fh = findobj('Tag','figAngularTuning');
    
    if(selected_index == 1)
        set(findobj('Tag','btnatMoveUp'),'Enable', 'Off');
        set(findobj('Tag','btnatMoveDown'),'Enable', 'On');        
    else
        set(findobj('Tag','btnatMoveUp'),'Enable', 'On');        
    end    

    if(selected_index == length(listbox_contents))
        set(findobj('Tag','btnatMoveDown'),'Enable', 'Off');
        set(findobj('Tag','btnatMoveUp'),'Enable', 'On');
    else
        set(findobj('Tag','btnatMoveDown'),'Enable', 'On');        
    end
    
    [checkedColumns, flag] = selectedColumns();
%     checkedColumns = getappdata(fh, 'checkedColumns');
    
    if(flag)       
        filePath = getappdata(fh, 'directoryPath');
        [fet_time, fet_data] = readData(filePath, listbox_contents{selected_index}, checkedColumns);
        color = {'r','g','b','c','m','y','k'};        
        cla(findobj('Tag','axatMain'));
%         axes(findobj('Tag','axatMain'));
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

%     listbox_contents = get(findobj('Tag', 'lstboxatContent'), 'String');
%     selected_index = get(findobj('Tag', 'lstboxatContent'), 'Value');
%     
%     fh=findobj('Tag','figAngularTuning');
%     
%     if(isappdata(fh, 'plottedSweeps'))
%         plottedSweeps=getappdata(fh, 'plottedSweeps');
%         
%         if  (length(selected_index)==1)
%             cla(findobj('Tag','axatMain'));  
%             filesToPlot = selected_index;
%         elseif (length(plottedSweeps)>length(selected_index))
%             cla(findobj('Tag','axatMain'));
%             if selected_index(1)< plottedSweeps(1)
%                 filesToPlot = selected_index;
%             else
%                 filesToPlot=intersect(plottedSweeps, selected_index);
%             end
%         else
%             filesToPlot=setdiff(selected_index, plottedSweeps);      
%         end
%                 
%         setappdata(fh,'plottedSweeps',selected_index);
%     else
%         filesToPlot=selected_index;        
%         setappdata(fh,'plottedSweeps',filesToPlot);
%     end
%     
%     fh = findobj('Tag','figAngularTuning');
%     
%     if(selected_index == 1)
%         set(findobj('Tag','btnatMoveUp'),'Enable', 'Off');
%         set(findobj('Tag','btnatMoveDown'),'Enable', 'On');        
%     else
%         set(findobj('Tag','btnatMoveUp'),'Enable', 'On');        
%     end    
% 
%     if(selected_index == length(listbox_contents))
%         set(findobj('Tag','btnatMoveDown'),'Enable', 'Off');
%         set(findobj('Tag','btnatMoveUp'),'Enable', 'On');
%     else
%         set(findobj('Tag','btnatMoveDown'),'Enable', 'On');        
%     end
%     
%     [checkedColumns, flag] = selectedColumns();
% 
%     if(flag)
%         filePath = getappdata(fh, 'directoryPath');
% 
%         color = {'r','g','b','c','m','y','k','r','g','b','c','m','y','k','r','g','b','c','m','y','k','r','g','b','c','m','y','k','r','g','b','c','m','y','k'...
%             'r','g','b','c','m','y','k','r','g','b','c','m','y','k','r','g','b','c','m','y','k','r','g','b','c','m','y','k','r','g','b','c','m','y','k',...
%             'r','g','b','c','m','y','k','r','g','b','c','m','y','k','r','g','b','c','m','y','k','r','g','b','c','m','y','k','r','g','b','c','m','y','k'};        
%                        
%         columns = length(checkedColumns);
%                
%         for j=1:length(filesToPlot)
%             [fet_time, fet_data] = readData(filePath, listbox_contents{filesToPlot(j)}, checkedColumns);    
% 
%             hold on
%             for i=1:1:columns-1
%                 plot(fet_time, fet_data(:,i),color{j});
%                 title(['Plot of Channel#',num2str(i)]);
%             end          
%            
%         end
%         
%         axis('tight');
%         hold off
%     end    

%%

% --- Executes during object creation, after setting all properties.
function lstboxatContent_CreateFcn(hObject, eventdata, handles)
% hObject    handle to lstboxatContent (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



%%

% --- Executes on button press in btnatCalculateLatencies.
function btnatCalculateLatencies_Callback(hObject, eventdata, handles)

% hObject    handle to btnatCalculateLatencies (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

    fh = findobj('Tag', 'figAngularTuning');

    if isappdata(fh, 'latencyMatrix')
    
        latMat = getappdata(fh, 'latencyMatrix');
        ampMat = getappdata(fh, 'amplitudeMatrix');
        time = getappdata(fh, 'fet_time');    
        data = getappdata(fh, 'fet_data');

        Fs = 1/(time(2)-time(1));%getappdata(fh, 'samplingFreq');

    %     createDepthProfile(time, data);

        [~,c] = size(data);

        latencies = [];
        amplitudes = [];

        stimOnset = 0.15;
        timeResp = 0.2;
        limitResp = 0.35;

        stimOnsetDP = floor(Fs * stimOnset + 1);
        stopDP = floor(Fs * limitResp + 1);

        T = time(2) - time(1);              % sampling step
        Fs=1/T;    
        % low pass filter the signal with the specified cutoff frequency
        fNorm = 100 / (Fs/2);
        [b,a] = butter(5,fNorm,'low');

        for i = 1:c
            dataCol = data(:,i);
            dataCol = filtfilt(b,a,dataCol);
            [~, locE2] = min(dataCol(stimOnsetDP:stopDP));
            latencies(i) = time(stimOnsetDP+locE2) - stimOnset;
            amplitudes(i) = dataCol(stimOnsetDP+locE2);
        end
%         latencies(i+1) = latencies(1); % to create a full angular tuning profile
%         amplitudes(i+1) = amplitudes(1);
    else
        latMat = [];
        ampMat = [];
        
        time = getappdata(fh, 'fet_time');
        data = getappdata(fh, 'fet_data');

        Fs = 1/(time(2)-time(1));%getappdata(fh, 'samplingFreq');

    %     createDepthProfile(time, data);

        [~,c] = size(data);

        latencies = [];
        amplitudes = [];

        stimOnset = 0.15;
        timeResp = 0.2;
        limitResp = 0.35;

        stimOnsetDP = floor(Fs * stimOnset + 1);
        stopDP = floor(Fs * limitResp + 1);

        T = time(2) - time(1);              % sampling step
        Fs=1/T;    
        % low pass filter the signal with the specified cutoff frequency
        fNorm = 100 / (Fs/2);
        [b,a] = butter(5,fNorm,'low');

        for i = 1:c
            dataCol = data(:,i);
            dataCol = filtfilt(b,a,dataCol);
            [~, locE2] = min(dataCol(stimOnsetDP:stopDP));
            latencies(i) = time(stimOnsetDP+locE2) - stimOnset;
            amplitudes(i) = dataCol(stimOnsetDP+locE2);
        end
%         latencies(i+1) = latencies(1); % to create a full angular tuning profile
%         amplitudes(i+1) = amplitudes(1);
    end
    
    latMat = [latMat, latencies'];
    ampMat = [ampMat, amplitudes'];
    
    setappdata(fh, 'latencyMatrix', latMat);
    setappdata(fh, 'amplitudeMatrix', ampMat);
    
    msgbox('The Latency Calculation is Completed','Completion of Latency Calculation','help');
    
%%

% --- Executes on button press in btnAngularTuning.
function btnAngularTuning_Callback(hObject, eventdata, handles)
% hObject    handle to btnAngularTuning (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

    fh = findobj('Tag', 'figAngularTuning');

    if ~isappdata(fh, 'latencyMatrix')
        msgbox('Latency Information Not Found! Please first calculate the latencies and then calculate the angular tuning.', 'Latency Information Missing');
    else
        latMat = getappdata(fh, 'latencyMatrix');
        [rows, columns] = size(latMat);
        ampMat = getappdata(fh, 'amplitudeMatrix');
        
        if columns<8
            msgbox([{'Insufficient data for angular tuning calculation!'}, {'Please calculate latencies for the whole angular profile.'}],'Incomplete Angular Profile');
        elseif columns==8
        
            angles = [0:45:315,0] .* 0.0174532925'; %convert degrees into radians
            
            latMat = getappdata(fh, 'latencyMatrix');
            ampMat = getappdata(fh, 'amplitudeMatrix');
            
            latMat(:,columns+1) = latMat(:,1);
            ampMat(:,columns+1) = ampMat(:,1);
            
            depths = [80:80:1520];
            
%             figure('NumberTitle','Off','Name','SigMate: Angular Tuning for the Recordings - Latencies');
            
            if rem(rows, 2)
                spNo = floor(rows/2)+1;
            else
                spNo = floor(rows/2);
            end
            
%             hold on;



            for i = 1:rows
%                 subplot(spNo, 2, i)
                figure('NumberTitle','Off','Name',['SigMate: Angular Tuning Based on Latencies for the Recordings at: ' num2str(depths(i)) 'um']);
%                 myPolar(angles, latMat(i,:),[min(min(latMat)) max(max(latMat))]);
                myPolar(angles, latMat(i,:));%,[min(min(latMat)) max(max(latMat))]);
%                 polar
            end

            for i = 1:rows
%                 subplot(spNo, 2, i)
                figure('NumberTitle','Off','Name',['SigMate: Angular Tuning Based on Amplitudes for the Recordings at: ' num2str(depths(i)) 'um']);
                myPolar(angles, ampMat(i,:));
            end
            
            figure('NumberTitle','Off','Name',['SigMate: Angular Tuning of Latencies']);% num2str(depths(i)) 'um']);
            hold on
            for i = 1:columns
                plot(depths, latMat(:,i),'b*-')
            end
            hold off
            title('Response Latencies at Different Depths and Angles')
            xlabel('Depth [um]')
            ylabel('Latency [s]')

            figure('NumberTitle','Off','Name',['SigMate: Angular Tuning of Response Amplitudes']);% num2str(depths(i)) 'um']);
            hold on
            for i = 1:columns
                plot(depths, ampMat(:,i),'r*-')
            end
            hold off
            title('Response Amplitudes at Different Depths and Angles')
            xlabel('Depth [um]')
            ylabel('Amplitude [V]')
            
            layers={'I','II','III','IV','Va','Vb','VI'};
            
            anglesDeg = [0:45:315];
            latPref = latMat(:,1:end-1);
            ampPref = ampMat(:,1:end-1);
            
            prefAngles = anglePreference(depths, anglesDeg, latPref, 'latency');
            figure('NumberTitle','Off','Name',['SigMate: Angular Tuning of Response Latencies']);
            plot(1:7,prefAngles,'o-')
            set(gca,'XTickLabel',layers)
            ylim([0 315])
            set(gca, 'YTick',[0:45:315])
            title('Different Cortical Layers Angular Preferentiality based on Latencies')
            xlabel('Cortical Layers')
            ylabel('Stimulation Angle [degree]')
            
            prefAngles = anglePreference(depths, anglesDeg, ampPref, 'amplitude');
            figure('NumberTitle','Off','Name',['SigMate: Angular Tuning of Response Amplitude']);
            plot(1:7,prefAngles,'o-')
            set(gca,'XTickLabel',layers)
            ylim([0 315])
            set(gca, 'YTick',[0:45:315])
            title('Different Cortical Layers Angular Preferentiality based on Amplitudes')
            xlabel('Cortical Layers')
            ylabel('Stimulation Angle [degree]')            
            
        elseif columns>8
            msgbox([{'Data overflow for angular tuning calculation!'}, {'Please calculate latencies exactly for the complete angular profile.'}],'Angular Profile Data Overflow');
            rmappdata(fh,'latencyMatrix');
        end
    end
        
%%

function prefAngles=anglePreference(depth, angle, dataMatrix, operation)

    
    switch lower(operation)
        case 'latency'
            minAngles=[];
            miniLat = [];
            for i = 1:length(depth)        
                data = dataMatrix(i,:);
                minData = min(data);
                miniLat(i) = minData;
                minAngles(i) = angle(find(data==minData));
            end
            
            latencies = miniLat;
            
            ind=zeros(7,1);

            layerILat=[];
            layerIILat=[];
            layerIIILat=[];
            layerIVLat=[];
            layerVaLat=[];
            layerVbLat=[];
            layerVILat=[];

            layerIDepths=[];
            layerIIDepths=[];
            layerIIIDepths=[];
            layerIVDepths=[];
            layerVaDepths=[];
            layerVbDepths=[];
            layerVIDepths=[];
            
            layerIAngles=[];
            layerIIAngles=[];
            layerIIIAngles=[];
            layerIVAngles=[];
            layerVaAngles=[];
            layerVbAngles=[];
            layerVIAngles=[];            

            for i = 1:length(depth)
                if isnan(latencies(i))
                    currLat=inf;
                else
                    currLat=latencies(i);
                end
                if (depth(i)<=250)
                    ind(1)=ind(1)+1;
                    layerILat(ind(1))=currLat;
                    layerIDepths(ind(1))=depth(i);
                    layerIAngles(ind(1))=minAngles(i);
                elseif((depth(i)>250)&& (depth(i)<=350))
                    ind(2)=ind(2)+1;
                    layerIILat(ind(2))=currLat;
                    layerIIDepths(ind(2))=depth(i);
                    layerIIAngles(ind(2))=minAngles(i);
                elseif((depth(i)>350)&& (depth(i)<=500))
                    ind(3)=ind(3)+1;
                    layerIIILat(ind(3))=currLat;
                    layerIIIDepths(ind(3))=depth(i);
                    layerIIIAngles(ind(3))=minAngles(i);
                elseif((depth(i)>500)&& (depth(i)<=750))
                    ind(4)=ind(4)+1;
                    layerIVLat(ind(4))=currLat;
                    layerIVDepths(ind(4))=depth(i);
                    layerIVAngles(ind(4))=minAngles(i);
                elseif((depth(i)>750)&& (depth(i)<=1200))
                    ind(5)=ind(5)+1;
                    layerVaLat(ind(5))=currLat;
                    layerVaDepths(ind(5))=depth(i);
                    layerVaAngles(ind(5))=minAngles(i);
                elseif((depth(i)>1200)&& (depth(i)<=1475))
                    ind(6)=ind(6)+1;
                    layerVbLat(ind(6))=currLat;
                    layerVbDepths(ind(6))=depth(i);
                    layerVbAngles(ind(6))=minAngles(i);
                elseif(depth(i)>1475)
                    ind(7)=ind(7)+1;
                    layerVILat(ind(7))=currLat;
                    layerVIDepths(ind(7))=depth(i);
                    layerVIAngles(ind(7))=minAngles(i);
                end
            end
            
            layers={'I','II','III','IV','Va','Vb','VI'};

            minLat=zeros(7,1);
            posLatLayers=zeros(7,1);
            angleLayers = zeros(7,1);

            if ~isempty(layerILat)
                minLat(1)=min(layerILat);
                angleLayers(1) = layerIAngles(find(layerILat==minLat(1)));
            else
                minLat(1)=NaN;
                posLatLayers(1) = NaN;
            end
            if ~isempty(layerIILat)
                minLat(2)=min(layerIILat);
                angleLayers(2) = layerIIAngles(find(layerIILat==minLat(2)));
            else
                minLat(2)=NaN;
                posLatLayers(2) = NaN;
            end    
            minLat(3)=min(layerIIILat);
            angleLayers(3) = layerIIIAngles(find(layerIIILat==minLat(3)));
            minLat(4)=min(layerIVLat);
            angleLayers(4) = layerIVAngles(find(layerIVLat==minLat(4)));
            minLat(5)=min(layerVaLat);
            angleLayers(5) = layerVaAngles(find(layerVaLat==minLat(5)));
            minLat(6)=min(layerVbLat);
            angleLayers(6) = layerVbAngles(find(layerVbLat==minLat(6)));
            minLat(7)=min(layerVILat);
            angleLayers(7) = layerVIAngles(find(layerVILat==minLat(7)));
            
            prefAngles = angleLayers;
            
        case 'amplitude'
            maxAngles=[];
            maxLat = [];
            for i = 1:length(depth)        
                data = dataMatrix(i,:);
                maxData = max(data);
                maxLat(i) = maxData;
                minAngles(i) = angle(find(data==maxData));
            end
            
            latencies = maxLat;
            
            ind=zeros(7,1);

            layerILat=[];
            layerIILat=[];
            layerIIILat=[];
            layerIVLat=[];
            layerVaLat=[];
            layerVbLat=[];
            layerVILat=[];

            layerIDepths=[];
            layerIIDepths=[];
            layerIIIDepths=[];
            layerIVDepths=[];
            layerVaDepths=[];
            layerVbDepths=[];
            layerVIDepths=[];
            
            layerIAngles=[];
            layerIIAngles=[];
            layerIIIAngles=[];
            layerIVAngles=[];
            layerVaAngles=[];
            layerVbAngles=[];
            layerVIAngles=[];            

            for i = 1:length(depth)
                if isnan(latencies(i))
                    currLat=inf;
                else
                    currLat=latencies(i);
                end
                if (depth(i)<=250)
                    ind(1)=ind(1)+1;
                    layerILat(ind(1))=currLat;
                    layerIDepths(ind(1))=depth(i);
                    layerIAngles(ind(1))=minAngles(i);
                elseif((depth(i)>250)&& (depth(i)<=350))
                    ind(2)=ind(2)+1;
                    layerIILat(ind(2))=currLat;
                    layerIIDepths(ind(2))=depth(i);
                    layerIIAngles(ind(2))=minAngles(i);
                elseif((depth(i)>350)&& (depth(i)<=500))
                    ind(3)=ind(3)+1;
                    layerIIILat(ind(3))=currLat;
                    layerIIIDepths(ind(3))=depth(i);
                    layerIIIAngles(ind(3))=minAngles(i);
                elseif((depth(i)>500)&& (depth(i)<=750))
                    ind(4)=ind(4)+1;
                    layerIVLat(ind(4))=currLat;
                    layerIVDepths(ind(4))=depth(i);
                    layerIVAngles(ind(4))=minAngles(i);
                elseif((depth(i)>750)&& (depth(i)<=1200))
                    ind(5)=ind(5)+1;
                    layerVaLat(ind(5))=currLat;
                    layerVaDepths(ind(5))=depth(i);
                    layerVaAngles(ind(5))=minAngles(i);
                elseif((depth(i)>1200)&& (depth(i)<=1475))
                    ind(6)=ind(6)+1;
                    layerVbLat(ind(6))=currLat;
                    layerVbDepths(ind(6))=depth(i);
                    layerVbAngles(ind(6))=minAngles(i);
                elseif(depth(i)>1475)
                    ind(7)=ind(7)+1;
                    layerVILat(ind(7))=currLat;
                    layerVIDepths(ind(7))=depth(i);
                    layerVIAngles(ind(7))=minAngles(i);
                end
            end
            
            layers={'I','II','III','IV','Va','Vb','VI'};

            minLat=zeros(7,1);
            posLatLayers=zeros(7,1);
            angleLayers = zeros(7,1);

            if ~isempty(layerILat)
                minLat(1)=max(layerILat);
                angleLayers(1) = layerIAngles(find(layerILat==minLat(1)));
            else
                minLat(1)=NaN;
                posLatLayers(1) = NaN;
            end
            if ~isempty(layerIILat)
                minLat(2)=max(layerIILat);
                angleLayers(2) = layerIIAngles(find(layerIILat==minLat(2)));
            else
                minLat(2)=NaN;
                posLatLayers(2) = NaN;
            end    
            minLat(3)=max(layerIIILat);
            angleLayers(3) = layerIIIAngles(find(layerIIILat==minLat(3)));
            minLat(4)=max(layerIVLat);
            angleLayers(4) = layerIVAngles(find(layerIVLat==minLat(4)));
            minLat(5)=max(layerVaLat);
            angleLayers(5) = layerVaAngles(find(layerVaLat==minLat(5)));
            minLat(6)=max(layerVbLat);
            angleLayers(6) = layerVbAngles(find(layerVbLat==minLat(6)));
            minLat(7)=max(layerVILat);
            angleLayers(7) = layerVIAngles(find(layerVILat==minLat(7)));
            
            prefAngles = angleLayers;            
    end

%%

function createDepthProfile(time, data)
    
    fh = findobj('Tag','figAngularTuning');
    
    fileCount=length(getappdata(findobj('Tag','figAngularTuning'),'fileNames'));    
    
    [rows,columns]=size(data);
    
    fhDistance = findobj('Tag','txtatDistance');
    
%     stringValue = get(handles.editTextBox, 'string'); 
%     doubleValue = str2double(stringValue); 
    
    maxAmpl = str2double(get(fhDistance,'String'));
    
%     maxAmpl = min(min(data))/2;
    
%     angularTuning = zeros(rows, columns+1);
    
%     angularTuning(:,1) = time;
    
    h=waitbar(0,'Performing Operations on Data Files to Create Depth Profile... Please wait... ');
    
    for i = 1:columns
        if i>1
            tempData=data(:,i);
            data(:,i)=tempData+(maxAmpl*(i-1));
        end
        waitbar(i/columns)
    end
    
    close(h);
      
    cla(findobj('Tag','axatMain'));
    plot(time, data)
    directoryPath=getappdata(fh,'directoryPath');
    oldPath=pwd;
    cd(directoryPath);
    datafile=[];
    dataFile = [time, data];
    save('DepthProfile.txt', 'dataFile','-ASCII','-tabs');
    cd(oldPath);   

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


function [checkedColumns, flag] = selectedColumns()
%%
    
    figure_handle = findobj('Tag', 'figAngularTuning');
      
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

% --- Executes on button press in btnatRemoveFile.
function btnatRemoveFile_Callback(hObject, eventdata, handles)
    %%
% hObject    handle to btnatRemoveFile (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

    fh=findobj('Tag','lstboxatContent');
    selected = get(fh,'Value'); 
    prev_str = get(fh, 'String'); 
    if ~isempty(prev_str) 
        prev_str(get(fh,'Value')) = []; 
        set(fh, 'String', prev_str, ... 
            'Value', min(selected,length(prev_str))); 
        setappdata(findobj('Tag','figAngularTuning'),'fileNames',prev_str);
    end

% --- Executes on selection change in pumatRecType.
function pumatRecType_Callback(hObject, eventdata, handles)
    %%
% hObject    handle to pumatRecType (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = get(hObject,'String') returns pumatRecType contents as cell array
%        contents{get(hObject,'Value')} returns selected item from pumatRecType

% selectedString = get(handles.pumatRecType, 'String');
    selectedValue = get(hObject, 'Value');

    setappdata(findobj('Tag','figAngularTuning'),'signalType',selectedValue);
    switch selectedValue
        case 2 % if the micropipette recording is selected
            set(findobj('Tag', 'btnatBrowse'), 'Enable', 'On');
            set(findobj('Tag', 'chkboxatCh1'), 'Visible', 'On');
            set(findobj('Tag', 'chkboxatCh2'), 'Visible', 'On');
            set(findobj('Tag', 'chkboxatCh3'), 'Visible', 'On');
            set(findobj('Tag', 'chkboxatCh4'), 'Visible', 'On');
            set(findobj('Tag', 'chkboxatCh5'), 'Visible', 'On');
            
            set(findobj('Tag', 'lblatTranRaw'), 'Visible', 'Off');
            set(findobj('Tag', 'chkboxatTranRaw'), 'Visible', 'Off');
            set(findobj('Tag', 'chkboxatTranRaw'), 'Value', 0);
            
            set(findobj('Tag', 'lblatPosition'), 'Visible', 'Off');
            set(findobj('Tag', 'txtatPosition'), 'Visible', 'Off');

            set(findobj('Tag', 'lblatOverlapChannels'), 'Visible', 'Off');
            set(findobj('Tag', 'chkboxatOvCh'), 'Visible', 'Off');
            set(findobj('Tag', 'chkboxatOvCh'), 'Value', 0);

            set(findobj('Tag', 'lblatDepthProfile'), 'Visible', 'Off');
            set(findobj('Tag', 'chkboxatDepthProfile'), 'Visible', 'Off');
            set(findobj('Tag', 'chkboxatDepthProfile'), 'Value', 0);

            if getappdata(findobj('Tag','figAngularTuning'),'DepthProfile')==1
                set(findobj('Tag', 'lblatDistance'), 'Visible', 'Off');
                set(findobj('Tag', 'txtatDistance'), 'Visible', 'Off');
            end            
            
        case 3 % if the Transistor recording is selected
            set(findobj('Tag', 'btnatBrowse'), 'Enable', 'On');
            set(findobj('Tag', 'chkboxatCh1'), 'Visible', 'On');
            set(findobj('Tag', 'chkboxatCh2'), 'Visible', 'On');
            set(findobj('Tag', 'chkboxatCh3'), 'Visible', 'On');
            set(findobj('Tag', 'chkboxatCh4'), 'Visible', 'On');
            set(findobj('Tag', 'chkboxatCh5'), 'Visible', 'On');
            
            set(findobj('Tag', 'lblatTranRaw'), 'Visible', 'On');
            set(findobj('Tag', 'chkboxatTranRaw'), 'Visible', 'On');
            
        otherwise % if nothing is selected
            
            set(findobj('Tag', 'btnatBrowse'), 'Enable', 'Off');
            set(findobj('Tag', 'chkboxatCh1'), 'Visible', 'Off');  
            set(findobj('Tag', 'chkboxatCh2'), 'Visible', 'Off');  
            set(findobj('Tag', 'chkboxatCh4'), 'Visible', 'Off');  
            set(findobj('Tag', 'chkboxatCh5'), 'Visible', 'Off'); 
            set(findobj('Tag', 'chkboxatCh3'), 'Visible', 'Off');
            
            if getappdata(findobj('Tag','figAngularTuning'),'RawRecordings')==1

                set(findobj('Tag', 'lblatTranRaw'), 'Visible', 'Off');
                set(findobj('Tag', 'chkboxatTranRaw'), 'Visible', 'Off');
                set(findobj('Tag', 'chkboxatTranRaw'), 'Value', 0);

                set(findobj('Tag', 'lblatPosition'), 'Visible', 'Off');
                set(findobj('Tag', 'txtatPosition'), 'Visible', 'Off');

                set(findobj('Tag', 'lblatOverlapChannels'), 'Visible', 'Off');
                set(findobj('Tag', 'chkboxatOvCh'), 'Visible', 'Off');
                set(findobj('Tag', 'chkboxatOvCh'), 'Value', 0);

                set(findobj('Tag', 'lblatDepthProfile'), 'Visible', 'Off');
                set(findobj('Tag', 'chkboxatDepthProfile'), 'Visible', 'Off');
                set(findobj('Tag', 'chkboxatDepthProfile'), 'Value', 0);
            end

            if getappdata(findobj('Tag','figAngularTuning'),'DepthProfile')==1
                set(findobj('Tag', 'lblatDistance'), 'Visible', 'Off');
                set(findobj('Tag', 'txtatDistance'), 'Visible', 'Off');
            end
            
            msgbox('Please Select a Signal Source', 'Signal Source Not Selected','Error');
    end            

% --- Executes during object creation, after setting all properties.
function pumatRecType_CreateFcn(hObject, eventdata, handles)
% hObject    handle to pumatRecType (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

%%

% --- Executes on button press in chkboxatCh1.
function chkboxatCh1_Callback(hObject, eventdata, handles)
% hObject    handle to chkboxatCh1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of chkboxatCh1

    if (get(hObject,'Value') == get(hObject,'Max'))
        % Checkbox is checked
        setappdata(findobj('Tag','figAngularTuning'),'Ch1',1);
    else
        % Checkbox is not checked
        setappdata(findobj('Tag','figAngularTuning'),'Ch1',0);        
    end    



%%

% --- Executes on button press in chkboxatCh2.
function chkboxatCh2_Callback(hObject, eventdata, handles)
% hObject    handle to chkboxatCh2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of chkboxatCh2

    if (get(hObject,'Value') == get(hObject,'Max'))
        % Checkbox is checked
        setappdata(findobj('Tag','figAngularTuning'),'Ch2',1);
    else
        % Checkbox is not checked
        setappdata(findobj('Tag','figAngularTuning'),'Ch2',0);        
    end    

%%

% --- Executes on button press in chkboxatCh4.
function chkboxatCh4_Callback(hObject, eventdata, handles)
% hObject    handle to chkboxatCh4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of chkboxatCh4

    if (get(hObject,'Value') == get(hObject,'Max'))
        % Checkbox is checked
        setappdata(findobj('Tag','figAngularTuning'),'Ch4',1);
    else
        % Checkbox is not checked
        setappdata(findobj('Tag','figAngularTuning'),'Ch4',0);        
    end    

%%

% --- Executes on button press in chkboxatCh5.
function chkboxatCh5_Callback(hObject, eventdata, handles)
%%
% hObject    handle to chkboxatCh5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of chkboxatCh5

    if (get(hObject,'Value') == get(hObject,'Max'))
        % Checkbox is checked
        setappdata(findobj('Tag','figAngularTuning'),'Ch5',1);
    else
        % Checkbox is not checked
        setappdata(findobj('Tag','figAngularTuning'),'Ch5',0);        
    end    

% --- Executes on button press in chkboxatCh3.
function chkboxatCh3_Callback(hObject, eventdata, handles)
%%
% hObject    handle to chkboxatCh3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of chkboxatCh3


    if (get(hObject,'Value') == get(hObject,'Max'))
        % Checkbox is checked
        setappdata(findobj('Tag','figAngularTuning'),'Ch3',1);
    else
        % Checkbox is not checked
        setappdata(findobj('Tag','figAngularTuning'),'Ch3',0);        
    end    
   
% --- Executes on button press in btnatMoveUp.
function btnatMoveUp_Callback(hObject, eventdata, handles)
    %%
% hObject    handle to btnatMoveUp (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

    fh = findobj('Tag', 'lstboxatContent');
    listbox_contents = get(fh, 'String');
    selected_index = get(fh, 'Value');    
    
    if (~isempty(listbox_contents) && (selected_index > 1)&&(selected_index <= length(listbox_contents)))
        index = get(fh,'Value');
        tempFile=listbox_contents{index};
        listbox_contents{index}=listbox_contents{index-1};
        listbox_contents{index-1}=tempFile;
        set(fh, 'String', listbox_contents, ... 
            'Value', min(index,length(listbox_contents))); 
        setappdata(findobj('Tag','figAngularTuning'),'fileNames',listbox_contents);
        set(fh,'Value',index-1)
    end

    if(selected_index == 1)
        set(findobj('Tag','btnatMoveUp'),'Enable', 'Off');
        set(findobj('Tag','btnatMoveDown'),'Enable', 'On');        
    else
        set(findobj('Tag','btnatMoveUp'),'Enable', 'On');        
    end    

    if(selected_index == length(listbox_contents))
        set(findobj('Tag','btnatMoveDown'),'Enable', 'Off');
        set(findobj('Tag','btnatMoveUp'),'Enable', 'On');
    else
        set(findobj('Tag','btnatMoveDown'),'Enable', 'On');        
    end  

% --- Executes on button press in btnatMoveDown.
function btnatMoveDown_Callback(hObject, eventdata, handles)
    %%
% hObject    handle to btnatMoveDown (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

    fh = findobj('Tag', 'lstboxatContent');    
    listbox_contents = get(fh, 'String');
    selected_index = get(fh, 'Value');    

    if (~isempty(listbox_contents) && (selected_index >= 1)&&(selected_index < length(listbox_contents)))
        index = get(fh,'Value');
        tempFile=listbox_contents{index};
        listbox_contents{index}=listbox_contents{index+1};
        listbox_contents{index+1}=tempFile;
        set(fh, 'String', listbox_contents, ... 
            'Value', min(index,length(listbox_contents))); 
        setappdata(findobj('Tag','figAngularTuning'),'fileNames',listbox_contents);
        set(fh,'Value',index+1)        
    end     

    if(selected_index == 1)
        set(findobj('Tag','btnatMoveUp'),'Enable', 'Off');
        set(findobj('Tag','btnatMoveDown'),'Enable', 'On');        
    else
        set(findobj('Tag','btnatMoveUp'),'Enable', 'On');        
    end    

    if(selected_index == length(listbox_contents))
        set(findobj('Tag','btnatMoveDown'),'Enable', 'Off');
        set(findobj('Tag','btnatMoveUp'),'Enable', 'On');
    else
        set(findobj('Tag','btnatMoveDown'),'Enable', 'On');        
    end
    
% --- Executes on button press in tbatZoom.
function tbatZoom_Callback(hObject, eventdata, handles)
    %%
% hObject    handle to tbatZoom (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of tbatZoom

    button_state = get(hObject,'Value');
    if button_state == get(hObject,'Max')
	% Toggle button is pressed, take appropriate action
        zoom on;
        fh = findobj('Tag','tbatDataCursor');
        if (get(fh, 'Value')== get(fh,'Max'))
            set(fh,'Value',0);
        end
        
        fh = findobj('Tag','tbatPan');
        if (get(fh, 'Value')== get(fh,'Max'))
            set(fh,'Value',0);
        end          
    elseif button_state == get(hObject,'Min')
	% Toggle button is not pressed, take appropriate action
        zoom off;
    end

% --- Executes on button press in tbatDataCursor.
function tbatDataCursor_Callback(hObject, eventdata, handles)
    %%
% hObject    handle to tbatDataCursor (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of tbatDataCursor

    button_state = get(hObject,'Value');
    if button_state == get(hObject,'Max')
	% Toggle button is pressed, take appropriate action
        datacursormode on;
        dcm_obj=datacursormode(findobj('Tag','figAngularTuning'));
        set(dcm_obj,'UpdateFcn',@myupdatefcn);
        
        fh = findobj('Tag','tbatZoom');
        if (get(fh, 'Value')== get(fh,'Max'))
            set(fh,'Value',0);
        end
        
        fh = findobj('Tag','tbatPan');
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
%%

% --- Executes on button press in btnatResetGraph.
function btnatResetGraph_Callback(hObject, eventdata, handles)
    %%
% hObject    handle to btnatResetGraph (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

    fh = findobj('Tag','tbatZoom');
    if (get(fh, 'Value')== get(fh,'Max'))
        set(fh,'Value',0);
    end
    
    fh = findobj('Tag','tbatDataCursor');
    if (get(fh, 'Value')== get(fh,'Max'))
        set(fh,'Value',0);
    end    
    
    fh = findobj('Tag','tbatPan');
    if (get(fh, 'Value')== get(fh,'Max'))
        set(fh,'Value',0);
    end      
    
    datacursormode off;
    
    zoom off;
    
    pan off;
    
    axis('tight');
%%

% --- Executes on button press in tbatPan.
function tbatPan_Callback(hObject, eventdata, handles)
%%
% hObject    handle to tbatPan (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of tbatPan


    button_state = get(hObject,'Value');
    if button_state == get(hObject,'Max')
	% Toggle button is pressed, take appropriate action
        pan on;
%         dcm_obj=datacursormode(findobj('Tag','figAngularTuning'));
%         set(dcm_obj,'UpdateFcn',@myupdatefcn);
        
        fh = findobj('Tag','tbatZoom');
        if (get(fh, 'Value')== get(fh,'Max'))
            set(fh,'Value',0);
        end
        fh = findobj('Tag','tbatDataCursor');
        if (get(fh, 'Value')== get(fh,'Max'))
            set(fh,'Value',0);
        end        
    elseif button_state == get(hObject,'Min')
	% Toggle button is not pressed, take appropriate action
        pan off;
    end
%%

% --- Executes on selection change in chkboxatOvCh.
function chkboxatOvCh_Callback(hObject, eventdata, handles)
%%
% hObject    handle to chkboxatOvCh (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns chkboxatOvCh contents as cell array
%        contents{get(hObject,'Value')} returns selected item from chkboxatOvCh


    if (get(hObject,'Value') == get(hObject,'Max'))
        % Checkbox is checked
        setappdata(findobj('Tag','figAngularTuning'),'ChannelOverlap',1);
    else
        % Checkbox is not checked
        setappdata(findobj('Tag','figAngularTuning'),'ChannelOverlap',0);        
    end    

%%

% --- Executes during object creation, after setting all properties.
function chkboxatOvCh_CreateFcn(hObject, eventdata, handles)
% hObject    handle to chkboxatOvCh (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

%%


function txtatDistance_Callback(hObject, eventdata, handles)
% hObject    handle to txtatDistance (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of txtatDistance as text
%        str2double(get(hObject,'String')) returns contents of txtatDistance as a double

%%

% --- Executes during object creation, after setting all properties.
function txtatDistance_CreateFcn(hObject, eventdata, handles)
% hObject    handle to txtatDistance (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
%%

% --- Executes on button press in chkboxatTranRaw.
function chkboxatTranRaw_Callback(hObject, eventdata, handles)
% hObject    handle to chkboxatTranRaw (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of chkboxatTranRaw

    if (get(hObject,'Value') == get(hObject,'Max'))
        % Checkbox is checked
        setappdata(findobj('Tag','figAngularTuning'),'RawRecordings',1);
        set(findobj('Tag', 'lblatPosition'), 'Visible', 'On');
        set(findobj('Tag', 'txtatPosition'), 'Visible', 'On');
        
        set(findobj('Tag', 'lblatOverlapChannels'), 'Visible', 'On');
        set(findobj('Tag', 'chkboxatOvCh'), 'Visible', 'On');
        
        set(findobj('Tag', 'lblatDepthProfile'), 'Visible', 'On');
        set(findobj('Tag', 'chkboxatDepthProfile'), 'Visible', 'On');
    else
        % Checkbox is not checked
        setappdata(findobj('Tag','figAngularTuning'),'RawRecordings',0);
        set(findobj('Tag', 'lblatPosition'), 'Visible', 'Off');
        set(findobj('Tag', 'txtatPosition'), 'Visible', 'Off');
        
        set(findobj('Tag', 'lblatOverlapChannels'), 'Visible', 'Off');
        set(findobj('Tag', 'chkboxatOvCh'), 'Visible', 'Off');
        set(findobj('Tag', 'chkboxatOvCh'), 'Value', 0);
        
        set(findobj('Tag', 'lblatDepthProfile'), 'Visible', 'Off');
        set(findobj('Tag', 'chkboxatDepthProfile'), 'Visible', 'Off');
        set(findobj('Tag', 'chkboxatDepthProfile'), 'Value', 0);
        
        if getappdata(findobj('Tag','figAngularTuning'),'DepthProfile')==1
            set(findobj('Tag', 'lblatDistance'), 'Visible', 'Off');
            set(findobj('Tag', 'txtatDistance'), 'Visible', 'Off');            
        end
        
    end    
%%

% --- Executes on button press in chkboxatDepthProfile.
function chkboxatDepthProfile_Callback(hObject, eventdata, handles)
% hObject    handle to chkboxatDepthProfile (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of chkboxatDepthProfile

    if (get(hObject,'Value') == get(hObject,'Max'))
        % Checkbox is checked
        setappdata(findobj('Tag','figAngularTuning'),'DepthProfile',1);
        set(findobj('Tag', 'lblatDistance'), 'Visible', 'On');
        set(findobj('Tag', 'txtatDistance'), 'Visible', 'On');
    else
        % Checkbox is not checked
        setappdata(findobj('Tag','figAngularTuning'),'DepthProfile',0);
        set(findobj('Tag', 'lblatDistance'), 'Visible', 'Off');
        set(findobj('Tag', 'txtatDistance'), 'Visible', 'Off');        
    end   

%%


function txtatPosition_Callback(hObject, eventdata, handles)
% hObject    handle to txtatPosition (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of txtatPosition as text
%        str2double(get(hObject,'String')) returns contents of txtatPosition as a double

%%

% --- Executes during object creation, after setting all properties.
function txtatPosition_CreateFcn(hObject, eventdata, handles)
% hObject    handle to txtatPosition (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
%%


%%

% --- Executes on button press in chkboxContinuous.
function chkboxContinuous_Callback(hObject, eventdata, handles)
%%
% hObject    handle to chkboxContinuous (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of chkboxContinuous

    if (get(hObject,'Value') == get(hObject,'Max'))
        % Checkbox is checked
        setappdata(findobj('Tag','figAngularTuning'),'ContinuousAnalysis',1);
    else
        % Checkbox is not checked
        setappdata(findobj('Tag','figAngularTuning'),'ContinuousAnalysis',0);
    end   



% --- Executes during object creation, after setting all properties.
function axsatSigMate_CreateFcn(hObject, eventdata, handles)
% hObject    handle to axsatSigMate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: place code in OpeningFcn to populate axsatSigMate

    axes(hObject)
    pathLogo = which('SigMate-Logo');
    imshow([pathLogo '\' 'SigMate-Logo.gif'])
