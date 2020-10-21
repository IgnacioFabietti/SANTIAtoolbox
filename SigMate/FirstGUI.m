function varargout = FirstGUI(varargin)
% FIRSTGUI M-file for FirstGUI.fig
%      FIRSTGUI, by itself, creates a new FIRSTGUI or raises the existing
%      singleton*.
%
%      H = FIRSTGUI returns the handle to a new FIRSTGUI or the handle to
%      the existing singleton*.
%
%      FIRSTGUI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in FIRSTGUI.M with the given input arguments.
%
%      FIRSTGUI('Property','Value',...) creates a new FIRSTGUI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before FirstGUI_OpeningFunction gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to FirstGUI_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help FirstGUI

% Last Modified by GUIDE v2.5 09-May-2012 13:00:23

% Begin initialization code - DO NOT EDIT


gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @FirstGUI_OpeningFcn, ...
                   'gui_OutputFcn',  @FirstGUI_OutputFcn, ...
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

% pathToAdd = which('FirstGUI');
% pathToAdd = pathToAdd(1:end-(length('FirstGUI.m')+1));
% 
% j=1;
% xx=dir(fullfile(pathToAdd));
% fullPath=[];
% for i=1:length(xx)
%     temp=xx(i,1).name; 
%     if (~isequal(temp, '.') && ~isequal(temp, '..')) && isdir(temp)
%         folders{j}=[pathToAdd '\' temp ';']; %#ok<AGROW>
%         fullPath=[fullPath folders{j}]; %#ok<AGROW>
% 
%         j=j+1;
%     end
% end
% 
% % addpath(fullPath);

% fh = findobj('Tag', 'figMain');
% setappdata(fh, 'addedPath','fullPath');
% addpath(genpath(pathToAdd))

%%

% --- Executes just before FirstGUI is made visible.
function FirstGUI_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to FirstGUI (see VARARGIN)

% Choose default command line output for FirstGUI
handles.output = hObject;

pathToAdd = which('FirstGUI');
pathToAdd = pathToAdd(1:end-(length('FirstGUI.m')+1));

j=1;
xx=dir(fullfile(pathToAdd));
fullPath=[pathToAdd ';'];
for i=1:length(xx)
    temp=xx(i,1).name; 
    if (~isequal(temp, '.') && ~isequal(temp, '..')) && isdir(temp)
        folders{j}=[pathToAdd '\' temp ';']; %#ok<AGROW>
        fullPath=[fullPath folders{j}]; %#ok<AGROW>

        j=j+1;
    end
end

addpath(fullPath);

fh = findobj('Tag', 'figMain');
setappdata(fh, 'addedPath',fullPath);

set(handles.figMain, 'CloseRequestFcn', 'closeGUI');

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes FirstGUI wait for user response (see UIRESUME)
% uiwait(handles.figMain);

%%

% --- Outputs from this function are returned to the command line.
function varargout = FirstGUI_OutputFcn(hObject, eventdata, handles) 
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
    fh = findobj('Tag', 'figMain');
    fullPath=getappdata(fh, 'addedPath');
    
    closeGUI(); % Call the function from the CloseGUI.m file
    
    rmpath(fullPath)    


%%


% --- Executes on button press in btnBrowse.
function btnBrowse_Callback(hObject, eventdata, handles)
% hObject    handle to btnBrowse (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
    
%     global filelist, filenames
    
    %clear if any application data exists
    
    fh = findobj('Tag', 'figMain');    
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
        handle_lblPath = findobj('Tag', 'lblPath'); % find the object with the Tag lblPath and store the reference handle

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
        set(findobj('Tag','lstboxContent'),'String',handles.file_names,...
            'Value',1);
        set(findobj('Tag','btnLoad'),'Enable', 'On');
        set(findobj('Tag','btnLoad'),'String', 'Load Data Files');        
        set(findobj('Tag','btnRemoveFile'),'Enable', 'On');
        set(findobj('Tag','btnPlot3D'),'Enable', 'On');
        set(findobj('Tag','btnMoveUp'),'Enable', 'On');
        set(findobj('Tag','btnMoveDown'),'Enable', 'On');        
        set(findobj('Tag','chkboxCh1'),'Enable', 'On');
        set(findobj('Tag','chkboxCh2'),'Enable', 'On');
        set(findobj('Tag','chkboxCh3'),'Enable', 'On');
        set(findobj('Tag','chkboxCh4'),'Enable', 'On');
        set(findobj('Tag','chkboxCh5'),'Enable', 'On');
        if(strcmpi(get(findobj('Tag','btnAverage'),'Enable'),'On'))
            set(findobj('Tag','btnAverage'),'Enable', 'Off');
            set(findobj('Tag','btnNoiseEstimation'),'Enable', 'Off');
            set(findobj('Tag','btnInvertedAverage'),'Enable', 'Off');
            set(findobj('Tag','btnMeanSquare'),'Enable', 'Off');
            set(findobj('Tag','btnRootMeanSquare'),'Enable', 'Off');
        end
        
        if(strcmpi(get(findobj('Tag','btnRearrange'),'Enable'),'On'))
            set(findobj('Tag','btnRearrange'),'Enable', 'Off');  
            set(findobj('Tag','btnRearrange'),'Visible', 'Off');          
            set(findobj('Tag','chkboxSeparateChannels'),'Enable', 'Off');  
            set(findobj('Tag','chkboxSeparateChannels'),'Visible', 'Off');
            set(findobj('Tag','btnLoad'),'Visible', 'On');
            set(findobj('Tag','btnAverage'),'Visible', 'On');
            set(findobj('Tag','btnNoiseEstimation'),'Visible', 'On');
            set(findobj('Tag','btnInvertedAverage'),'Visible', 'On');
            set(findobj('Tag','btnMeanSquare'),'Visible', 'On');
            set(findobj('Tag','btnRootMeanSquare'),'Visible', 'On');            
        end
        
%         if(strcmpi(get(findobj('Tag','btnPlot3D'),'Enable'),'On'))
%             set(findobj('Tag','btnPlot3D'),'Enable', 'Off');            
%             set(findobj('Tag','btnPlot3D'),'Visible', 'Off');
% 
%             set(findobj('Tag','btnLoad'),'Visible', 'On');
%             set(findobj('Tag','btnAverage'),'Visible', 'On');
%             set(findobj('Tag','btnNoiseEstimation'),'Visible', 'On');
%             set(findobj('Tag','btnInvertedAverage'),'Visible', 'On');
%             set(findobj('Tag','btnMeanSquare'),'Visible', 'On');
%             set(findobj('Tag','btnRootMeanSquare'),'Visible', 'On');            
%         end        
    else %if the directory selection dialog is cancelled
        
        msgbox('Please Select a Directory for Analysis', 'Directory Not Selected','Error');
    end

    listbox_contents = get(findobj('Tag', 'lstboxContent'), 'String');
    selected_index = get(findobj('Tag', 'lstboxContent'), 'Value');    
    if(selected_index == 1)
        set(findobj('Tag','btnMoveUp'),'Enable', 'Off');
    elseif(selected_index == length(listbox_contents))
        set(findobj('Tag','btnMoveDown'),'Enable', 'Off');        
    end


%%


% --- Executes on selection change in lstboxContent.
function lstboxContent_Callback(hObject, eventdata, handles)
% hObject    handle to lstboxContent (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = get(hObject,'String') returns lstboxContent contents as cell array
%        contents{get(hObject,'Value')} returns selected item from lstboxContent

    listbox_contents = get(findobj('Tag', 'lstboxContent'), 'String');
    selected_index = get(findobj('Tag', 'lstboxContent'), 'Value');
    fh = findobj('Tag','figMain');
    
    if(selected_index == 1)
        set(findobj('Tag','btnMoveUp'),'Enable', 'Off');
        set(findobj('Tag','btnMoveDown'),'Enable', 'On');        
    else
        set(findobj('Tag','btnMoveUp'),'Enable', 'On');        
    end    

    if(selected_index == length(listbox_contents))
        set(findobj('Tag','btnMoveDown'),'Enable', 'Off');
        set(findobj('Tag','btnMoveUp'),'Enable', 'On');
    else
        set(findobj('Tag','btnMoveDown'),'Enable', 'On');        
    end
    
    [checkedColumns, flag] = selectedColumns();
%     checkedColumns = getappdata(fh, 'checkedColumns');
    
    if(flag)       
        filePath = getappdata(fh, 'directoryPath');
        [fet_time, fet_data] = readDatasigmate(filePath, listbox_contents{selected_index}, checkedColumns);
        color = {'r','g','b','c','m','y','k'};        
        cla(findobj('Tag','axMain'));
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
    end
    
    
    
    
%     plotData(handles.fet_time, handles.fet_data,handles.axMain, ['Selected FET Recording of ',listbox_contents{selected_index}], handles);
    


%%

% --- Executes during object creation, after setting all properties.
function lstboxContent_CreateFcn(hObject, eventdata, handles)
% hObject    handle to lstboxContent (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



%%

% --- Executes on button press in btnAverage.
function btnAverage_Callback(hObject, eventdata, handles)
% hObject    handle to btnAverage (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%     hold on;
    fh = findobj('Tag', 'figMain');
    
%     signalType = getappdata(fh,'signalType');
    
%     checkedColumns = getappdata(fh, 'checkedColumns');
    time = getappdata(fh, 'fet_time');    
    data = getappdata(fh, 'fet_data');
    
    if(~isappdata(fh,'averaged_data'))
        processData(time, data, 'Average');        
    end
    
    plotData(findobj('Tag','axMain'), 'Average of FET Recordings', fh);
    
%     plotData(handles.averaged_time, handles.odd_data, handles.axMain, 'odd');
%     plotData(handles.averaged_time, handles.even_data, handles.axMain, 'even');
%     hold off;
    
    
    
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

% --- Executes on button press in btnNoiseEstimation.
function btnNoiseEstimation_Callback(hObject, eventdata, handles)
% hObject    handle to btnNoiseEstimation (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

    fh = findobj('Tag', 'figMain');
        
    if((~isappdata(fh,'averaged_odd_data'))&&(~isappdata(fh,'averaged_even_data')))

        time = getappdata(fh, 'fet_time');    
        data = getappdata(fh, 'fet_data');
        processData(time, data, 'Average');
    end

%     averaged_time = getappdata(fh, 'averaged_time');
    evenData = getappdata(fh, 'averaged_even_data');
    oddData = getappdata(fh, 'averaged_odd_data');
    averagedData = getappdata(fh,'averaged_data');
    averagedTime = getappdata(fh,'averaged_time');    
    
    noiseEstimation = evenData-oddData;
    
    setappdata(fh,'noiseEstimation',noiseEstimation);


    j=1;
    for i = 1:2:length(averagedData)
        averagedData(i)= averagedData(i)-noiseEstimation(j); 
        j=j+1; 
    end
    j=1;    
    for i = 2:2:length(averagedData)
        averagedData(i)= averagedData(i)-noiseEstimation(j); 
        j=j+1; 
    end    
    
    setappdata(fh,'noiselessAveragedData',averagedData);
    
    directoryPath=getappdata(fh,'directoryPath');
    oldPath=pwd;
    cd(directoryPath);
    datafile=[];
    dataFile = [averagedTime, averagedData];
    save('NoiselessAveragedData.txt', 'dataFile','-ASCII','-tabs');
    cd(oldPath);
    
    plotData(findobj('Tag','axMain'),'Estimated Noise in the Recordings', fh);

%%

% --- Executes on button press in btnInvertedAverage.
function btnInvertedAverage_Callback(hObject, eventdata, handles)
% hObject    handle to btnInvertedAverage (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
   
    fh = findobj('Tag','figMain');    
    
    if((~isappdata(fh,'averaged_odd_data'))&&(~isappdata(fh,'averaged_even_data')))
        time = getappdata(fh, 'fet_time');    
        data = getappdata(fh, 'fet_data');        
        processData(time, data, 'Average');
    end
    
    plotData(findobj('Tag','axMain'), '+/- Average of FET Recordings', fh);


%%

% --- Executes on button press in btnMeanSquare.
function btnMeanSquare_Callback(hObject, eventdata, handles)
% hObject    handle to btnMeanSquare (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

    fh=findobj('Tag', 'figMain');
    if(~isappdata(fh,'ms_averaged_data'))
        time = getappdata(fh, 'fet_time');    
        data = getappdata(fh, 'fet_data');        
        processData(time, data, 'MeanSquare');
    end
%     hold on;
    plotData(findobj('Tag','axMain'), 'Mean Square Average of FET Recordings', fh);

%%

% --- Executes on button press in btnRootMeanSquare.
function btnRootMeanSquare_Callback(hObject, eventdata, handles)
% hObject    handle to btnRootMeanSquare (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

    fh=findobj('Tag', 'figMain');
    if(~isappdata(fh,'rms_averaged_data'))
        time = getappdata(fh, 'fet_time');    
        data = getappdata(fh, 'fet_data');        
        processData(time, data, 'MeanSquare');
    end
%     hold on;
    plotData(findobj('Tag','axMain'), 'Root Mean Square Average of FET Recordings', fh);

%%

% --- Executes on button press in btnLoad.
function btnLoad_Callback(hObject, eventdata, handles)
% hObject    handle to btnLoad (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

    figure_handle = findobj('Tag', 'figMain');
    
    listbox_contents = get(findobj('Tag', 'lstboxContent'), 'String');    
    
    [checkedColumns, flag]=selectedColumns();
    
    filePath = getappdata(figure_handle,'directoryPath');
    
    if(flag) %if proper signal source and channels are selected

        [fet_time, fet_data, samplingFreq, dataPoints] = loadData(listbox_contents, filePath, checkedColumns);

        setappdata(figure_handle, 'fet_time', fet_time);
        setappdata(figure_handle, 'fet_data', fet_data);        
        setappdata(figure_handle, 'samplingFreq', samplingFreq);
        setappdata(figure_handle, 'dataPoints', dataPoints);        

        set(findobj('Tag','btnLoad'),'String', 'Data Files Loaded');
        set(findobj('Tag','btnLoad'),'Enable', 'Off');
        set(findobj('Tag','btnMoveUp'),'Enable', 'Off');
        set(findobj('Tag','btnMoveDown'),'Enable', 'Off');           
        set(findobj('Tag','btnAverage'),'Enable', 'On');
        set(findobj('Tag','btnNoiseEstimation'),'Enable', 'On');    
        set(findobj('Tag','btnInvertedAverage'),'Enable', 'On');    
        set(findobj('Tag','btnMeanSquare'),'Enable', 'On');   
        set(findobj('Tag','btnRootMeanSquare'),'Enable', 'On'); 
        set(findobj('Tag','btnRemoveFile'),'Enable', 'Off');
        set(findobj('Tag','chkboxCh1'),'Enable', 'Off');
        set(findobj('Tag','chkboxCh2'),'Enable', 'Off');
        set(findobj('Tag','chkboxCh3'),'Enable', 'Off');
        set(findobj('Tag','chkboxCh4'),'Enable', 'Off');
        set(findobj('Tag','chkboxCh5'),'Enable', 'Off');
        
    end
    
    if (isappdata(figure_handle,'averaged_data'))
        rmappdata(figure_handle,'averaged_data');
    end
    
%%

function [checkedColumns, flag] = selectedColumns()
%%
    
    figure_handle = findobj('Tag', 'figMain');
      
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

% function [processed_time, processed_data] = processData(time, data, flagString)

% --- Executes on button press in btnRemoveFile.
function btnRemoveFile_Callback(hObject, eventdata, handles)
    %%
% hObject    handle to btnRemoveFile (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

    fh=findobj('Tag','lstboxContent');
    selected = get(fh,'Value'); 
    prev_str = get(fh, 'String'); 
    if ~isempty(prev_str) 
        prev_str(get(fh,'Value')) = []; 
        set(fh, 'String', prev_str, ... 
            'Value', min(selected,length(prev_str))); 
        setappdata(findobj('Tag','figMain'),'fileNames',prev_str);
    end



function processData(time, data, flagString)
    
    fh = findobj('Tag','figMain');
    
    fileCount=length(getappdata(findobj('Tag','figMain'),'fileNames'));    
    
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
 
            fh = findobj('Tag', 'figMain');

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
 
            fh = findobj('Tag', 'figMain');

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

% --- Executes on selection change in pumRecType.
function pumRecType_Callback(hObject, eventdata, handles)
    %%
% hObject    handle to pumRecType (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = get(hObject,'String') returns pumRecType contents as cell array
%        contents{get(hObject,'Value')} returns selected item from pumRecType

% selectedString = get(handles.pumRecType, 'String');
    selectedValue = get(hObject, 'Value');

    setappdata(findobj('Tag','figMain'),'signalType',selectedValue);
    switch selectedValue
        case 2 % if the micropipette recording is selected
            set(findobj('Tag', 'btnBrowse'), 'Enable', 'On');
            set(findobj('Tag', 'chkboxCh1'), 'Visible', 'On');
            set(findobj('Tag', 'chkboxCh2'), 'Visible', 'On');
            set(findobj('Tag', 'chkboxCh3'), 'Visible', 'On');
            set(findobj('Tag', 'chkboxCh4'), 'Visible', 'On');
            set(findobj('Tag', 'chkboxCh5'), 'Visible', 'On');
        case 3 % if the Transistor recording is selected
            set(findobj('Tag', 'btnBrowse'), 'Enable', 'On');
            set(findobj('Tag', 'chkboxCh1'), 'Visible', 'On');
            set(findobj('Tag', 'chkboxCh2'), 'Visible', 'On');
            set(findobj('Tag', 'chkboxCh3'), 'Visible', 'On');
            set(findobj('Tag', 'chkboxCh4'), 'Visible', 'On');
            set(findobj('Tag', 'chkboxCh5'), 'Visible', 'On');        
        otherwise % if nothing is selected
            msgbox('Please Select a Signal Source', 'Signal Source Not Selected','Error');
            set(findobj('Tag', 'btnBrowse'), 'Enable', 'Off');
            set(findobj('Tag', 'chkboxCh1'), 'Visible', 'Off');  
            set(findobj('Tag', 'chkboxCh2'), 'Visible', 'Off');  
            set(findobj('Tag', 'chkboxCh4'), 'Visible', 'Off');  
            set(findobj('Tag', 'chkboxCh5'), 'Visible', 'Off'); 
            set(findobj('Tag', 'chkboxCh3'), 'Visible', 'Off');         
    end            

%     switch selectedValue
%         case 2 % if the In-Vivo recording is selected
%             set(findobj('Tag', 'btnBrowse'), 'Enable', 'On');
% 
%             set(findobj('Tag', 'chkboxCh2'), 'Visible', 'On');
%             set(findobj('Tag', 'chkboxCh2'), 'String', 'VmDC');        
%             set(findobj('Tag', 'chkboxCh1'), 'Visible', 'On');    
%             set(findobj('Tag', 'chkboxCh3'), 'Visible', 'On');        
%             set(findobj('Tag', 'chkboxCh1'), 'String', 'VmAC');        
%             set(findobj('Tag', 'chkboxCh4'), 'Visible', 'Off');  
%             set(findobj('Tag', 'chkboxCh5'), 'Visible', 'Off');          
% 
%         case 3 % if the Transistor recording is selected
%             set(findobj('Tag', 'chkboxCh1'), 'Visible', 'On');  
%             set(findobj('Tag', 'chkboxCh1'), 'String', 'Ch1');                
%             set(findobj('Tag', 'chkboxCh2'), 'Visible', 'On');  
%             set(findobj('Tag', 'chkboxCh2'), 'String', 'Vm');                
%             set(findobj('Tag', 'chkboxCh4'), 'Visible', 'On');  
%             set(findobj('Tag', 'chkboxCh5'), 'Visible', 'On');  
%             set(findobj('Tag', 'chkboxCh3'), 'Visible', 'Off');         
% 
%             set(findobj('Tag', 'btnBrowse'), 'Enable', 'On');        
%         otherwise % if nothing is selected
%             msgbox('Please Select a Signal Source', 'Signal Source Not Selected','Error');
%             set(findobj('Tag', 'btnBrowse'), 'Enable', 'Off');
%             set(findobj('Tag', 'chkboxCh1'), 'Visible', 'Off');  
%             set(findobj('Tag', 'chkboxCh2'), 'Visible', 'Off');  
%             set(findobj('Tag', 'chkboxCh4'), 'Visible', 'Off');  
%             set(findobj('Tag', 'chkboxCh5'), 'Visible', 'Off'); 
%             set(findobj('Tag', 'chkboxCh3'), 'Visible', 'Off');         
%     end


% --- Executes during object creation, after setting all properties.
function pumRecType_CreateFcn(hObject, eventdata, handles)
% hObject    handle to pumRecType (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

%%

% --- Executes on button press in chkboxCh1.
function chkboxCh1_Callback(hObject, eventdata, handles)
% hObject    handle to chkboxCh1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of chkboxCh1

    if (get(hObject,'Value') == get(hObject,'Max'))
        % Checkbox is checked
        setappdata(findobj('Tag','figMain'),'Ch1',1);
    else
        % Checkbox is not checked
        setappdata(findobj('Tag','figMain'),'Ch1',0);        
    end    



%%

% --- Executes on button press in chkboxCh2.
function chkboxCh2_Callback(hObject, eventdata, handles)
% hObject    handle to chkboxCh2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of chkboxCh2

    if (get(hObject,'Value') == get(hObject,'Max'))
        % Checkbox is checked
        setappdata(findobj('Tag','figMain'),'Ch2',1);
    else
        % Checkbox is not checked
        setappdata(findobj('Tag','figMain'),'Ch2',0);        
    end    

%%

% --- Executes on button press in chkboxCh4.
function chkboxCh4_Callback(hObject, eventdata, handles)
% hObject    handle to chkboxCh4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of chkboxCh4

    if (get(hObject,'Value') == get(hObject,'Max'))
        % Checkbox is checked
        setappdata(findobj('Tag','figMain'),'Ch4',1);
    else
        % Checkbox is not checked
        setappdata(findobj('Tag','figMain'),'Ch4',0);        
    end    

%%

% --- Executes on button press in chkboxCh5.
function chkboxCh5_Callback(hObject, eventdata, handles)
%%
% hObject    handle to chkboxCh5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of chkboxCh5

    if (get(hObject,'Value') == get(hObject,'Max'))
        % Checkbox is checked
        setappdata(findobj('Tag','figMain'),'Ch5',1);
    else
        % Checkbox is not checked
        setappdata(findobj('Tag','figMain'),'Ch5',0);        
    end    

% --- Executes on button press in chkboxCh3.
function chkboxCh3_Callback(hObject, eventdata, handles)
%%
% hObject    handle to chkboxCh3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of chkboxCh3


    if (get(hObject,'Value') == get(hObject,'Max'))
        % Checkbox is checked
        setappdata(findobj('Tag','figMain'),'Ch3',1);
    else
        % Checkbox is not checked
        setappdata(findobj('Tag','figMain'),'Ch3',0);        
    end    

% --------------------------------------------------------------------
function sigPlotter_Callback(hObject, eventdata, handles)
%%
% hObject    handle to sigPlotter (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function plot3D_Callback(hObject, eventdata, handles)
%%
% hObject    handle to plot3D (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%     fh = findobj('Tag', 'plot3D');
%     last_file_path=getappdata(fh,'last_file_path');
    set(findobj('Tag','btnPlot3D'),'Visible', 'On');
    set(findobj('Tag','btnPlot3D'),'Enable', 'On');    
%     set(findobj('Tag','btnRearrange'),'Enable', 'Off');
%     set(findobj('Tag','btnRearrange'),'Visible', 'Off');
%     set(findobj('Tag','btnLoad'),'Visible', 'Off');
%     set(findobj('Tag','btnRemoveFile'),'Enable', 'On');
%     set(findobj('Tag','btnAverage'),'Visible', 'Off');
%     set(findobj('Tag','btnNoiseEstimation'),'Visible', 'Off');
%     set(findobj('Tag','btnInvertedAverage'),'Visible', 'Off');
%     set(findobj('Tag','btnMeanSquare'),'Visible', 'Off');
%     set(findobj('Tag','btnRootMeanSquare'),'Visible', 'Off');
%     set(findobj('Tag','chkboxCh1'),'Enable', 'On');
%     set(findobj('Tag','chkboxCh2'),'Enable', 'On');
%     set(findobj('Tag','chkboxCh3'),'Enable', 'On');
%     set(findobj('Tag','chkboxCh4'),'Enable', 'On');
%     set(findobj('Tag','chkboxCh5'),'Enable', 'On');    
    
function fileOperators_Callback(hObject, eventdata, handles)
%%
% hObject    handle to fileOperators (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


    % --------------------------------------------------------------------
function fileConcatenator_Callback(hObject, eventdata, handles)
%%
% hObject    handle to fileConcatenator (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
%     path=pwd;
%     newPath=strcat(path,'\fileConcatenator\');
%     cd(newPath);
    run FileConcatenator;
%     cd(path);


% --------------------------------------------------------------------
function fileColumnRearranger_Callback(hObject, eventdata, handles)
%%
% hObject    handle to fileColumnRearranger (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

    fh = findobj('Tag', 'figMain');    
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
        handle_lblPath = findobj('Tag', 'lblPath'); % find the object with the Tag lblPath and store the reference handle

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
        set(findobj('Tag','lstboxContent'),'String',handles.file_names,...
            'Value',1);
        set(findobj('Tag','btnRearrange'),'Visible', 'On');
        set(findobj('Tag','btnRearrange'),'Enable', 'On');        
        set(findobj('Tag','btnLoad'),'Visible', 'Off');
        set(findobj('Tag','btnRemoveFile'),'Enable', 'On');
        set(findobj('Tag','btnAverage'),'Visible', 'Off');
        set(findobj('Tag','btnNoiseEstimation'),'Visible', 'Off');
        set(findobj('Tag','btnInvertedAverage'),'Visible', 'Off');
        set(findobj('Tag','btnMeanSquare'),'Visible', 'Off');
        set(findobj('Tag','btnRootMeanSquare'),'Visible', 'Off');
        set(findobj('Tag','chkboxSeparateChannels'),'Visible', 'On');
        set(findobj('Tag','chkboxSeparateChannels'),'Enable', 'On');
        set(findobj('Tag','chkboxCh1'),'Enable', 'On');
        set(findobj('Tag','chkboxCh2'),'Enable', 'On');
        set(findobj('Tag','chkboxCh3'),'Enable', 'On');
        set(findobj('Tag','chkboxCh4'),'Enable', 'On');
        set(findobj('Tag','chkboxCh5'),'Enable', 'On');
    else %if the directory selection dialog is cancelled
        
        msgbox('Please Select a Directory for Analysis', 'Directory Not Selected','Error');
    end



% --- Executes on button press in btnRearrange.

function btnRearrange_Callback(hObject, eventdata, handles)
    %%
% hObject    handle to btnRearrange (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

    figure_handle = findobj('Tag', 'figMain');
    
    listbox_contents = get(findobj('Tag', 'lstboxContent'), 'String');    
    
    [checkedColumns, flag]=selectedColumns();
    
    if(flag) %if proper signal source and channels are selected

        separateChannels = getappdata(findobj('Tag', 'figMain'), 'SeparateChannels');
        rearrangeData(listbox_contents, getappdata(figure_handle,'directoryPath'),checkedColumns, separateChannels);
        
    end
    
    
function rearrangeData(fileList, path, checkedColumns, separateChannels)
    %%
         
    h=waitbar(0,'Please wait... Rearranging Data Columns and Saving...');
      
    oldPath = pwd;  
    cd(path);
    
    if separateChannels
          
        for i = 1 : length(fileList)
            filePath = strcat(path,fileList{i});

            loaded_file = load (filePath); % load the file into loaded_file from the filename provided as an array of strings

            [rows,columns]=size(loaded_file);                       

            if(columns>rows)
                msgbox('Consider Transposing Your Data File',['Data File Format Error in ',filePath],'Error');
            else
                time_fet = loaded_file(:,1);
                t=time_fet(2)-time_fet(1);
                if(t>=0.05)
                    time_fet=(0:t:t*length(time_fet)-t)'*0.001;
                else
                    time_fet=(0:t:t*length(time_fet)-t)';
                end

                data_fet=[];
                k=2;
                for j = 1:1:columns-1

                    combinedFile = [];

                    data_fet = loaded_file(:,k);
%                      = tempData; 

                    k=k+1;
                    
                    combinedFile = [time_fet, data_fet];
                    newFileName = ['column', int2str(j), '-', fileList{i}];
                    save(newFileName, 'combinedFile', '-ASCII', '-tabs');

                end

                waitbar(i/length(fileList));
            end
        end
    else
        
        columns = length(checkedColumns); 
        for i = 1 : length(fileList)
            filePath = strcat(path,fileList{i});

            loaded_file = load (filePath); % load the file into loaded_file from the filename provided as an array of strings

            [m,n]=size(loaded_file);

            if(n>m)
                msgbox('Consider Transposing Your Data File',['Data File Format Error in ',filePath],'Error');
            else
                time_fet = loaded_file(:,1);
                t=time_fet(2)-time_fet(1);
                if(t>=0.05)
                    time_fet=(0:t:t*length(time_fet)-t)'*0.001;
                else
                    time_fet=(0:t:t*length(time_fet)-t)';
                end

                k=2;
                for j = 1:1:columns-1

                        tempData = loaded_file(:,checkedColumns(k));
                        data_fet(:,j) = tempData; 

                        k=k+1;                 
                end

                combinedFile = [time_fet, data_fet];
                newFileName = strcat('Rearranged-',fileList{i});
                save(newFileName, 'combinedFile', '-ASCII', '-tabs');

                waitbar(i/length(fileList));
            end
        end
    
    end
    cd(oldPath);

    close(h);

    
%%    

% --- Executes on button press in btnConvertCommaToDot.
function btnConvertCommaToDot_Callback(hObject, eventdata, handles)
% hObject    handle to btnConvertCommaToDot (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

    fh = findobj('Tag','figMain');
    directoryPath = getappdata(fh, 'directoryPath');
    
    fileNames = get(findobj('Tag', 'lstboxContent'), 'String');
    
    waitbarMsg ={'Please Wait... Converting Data Files...', 'Now Converting File: ', fileNames{1}};
    h=waitbar(0,waitbarMsg,'Name','Converting Data Files'); 
    
    for i = 1:length(fileNames)
        fileName = [directoryPath fileNames{i}];
        convertItalian2English(fileName);
        updatedWaitBarMsg={'Please Wait... Converting Data Files...', 'Now Converting File: ', fileNames{i}};
        waitbar(i/length(fileNames),h,updatedWaitBarMsg);
    end

    close(h)
    
%%

% --- Executes on button press in btnMoveUp.
function btnMoveUp_Callback(hObject, eventdata, handles)
    %%
% hObject    handle to btnMoveUp (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

    fh = findobj('Tag', 'lstboxContent');
    listbox_contents = get(fh, 'String');
    selected_index = get(fh, 'Value');    
    
    if (~isempty(listbox_contents) && (selected_index > 1)&&(selected_index <= length(listbox_contents)))
        index = get(fh,'Value');
        tempFile=listbox_contents{index};
        listbox_contents{index}=listbox_contents{index-1};
        listbox_contents{index-1}=tempFile;
        set(fh, 'String', listbox_contents, ... 
            'Value', min(index,length(listbox_contents))); 
        setappdata(findobj('Tag','figMain'),'fileNames',listbox_contents);
        set(fh,'Value',index-1)
    end

    if(selected_index == 1)
        set(findobj('Tag','btnMoveUp'),'Enable', 'Off');
        set(findobj('Tag','btnMoveDown'),'Enable', 'On');        
    else
        set(findobj('Tag','btnMoveUp'),'Enable', 'On');        
    end    

    if(selected_index == length(listbox_contents))
        set(findobj('Tag','btnMoveDown'),'Enable', 'Off');
        set(findobj('Tag','btnMoveUp'),'Enable', 'On');
    else
        set(findobj('Tag','btnMoveDown'),'Enable', 'On');        
    end  

% --- Executes on button press in btnMoveDown.
function btnMoveDown_Callback(hObject, eventdata, handles)
    %%
% hObject    handle to btnMoveDown (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

    fh = findobj('Tag', 'lstboxContent');    
    listbox_contents = get(fh, 'String');
    selected_index = get(fh, 'Value');
    

    if (~isempty(listbox_contents) && (selected_index >= 1)&&(selected_index < length(listbox_contents)))
        index = get(fh,'Value');
        tempFile=listbox_contents{index};
        listbox_contents{index}=listbox_contents{index+1};
        listbox_contents{index+1}=tempFile;
        set(fh, 'String', listbox_contents, ... 
            'Value', min(index,length(listbox_contents))); 
        setappdata(findobj('Tag','figMain'),'fileNames',listbox_contents);
        set(fh,'Value',index+1)        
    end     

    if(selected_index == 1)
        set(findobj('Tag','btnMoveUp'),'Enable', 'Off');
        set(findobj('Tag','btnMoveDown'),'Enable', 'On');        
    else
        set(findobj('Tag','btnMoveUp'),'Enable', 'On');        
    end    

    if(selected_index == length(listbox_contents))
        set(findobj('Tag','btnMoveDown'),'Enable', 'Off');
        set(findobj('Tag','btnMoveUp'),'Enable', 'On');
    else
        set(findobj('Tag','btnMoveDown'),'Enable', 'On');        
    end
    
% --- Executes on button press in btnPlot3D.
function btnPlot3D_Callback(hObject, eventdata, handles)
    %%
% hObject    handle to btnPlot3D (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%     set(findobj('Tag','btnMoveUp'),'Enable', 'Off');
%     set(findobj('Tag','btnMoveDown'),'Enable', 'Off');

    [checkedColumns, flag]=selectedColumns();
    if(flag && length(checkedColumns)==2)
        fh = findobj('Tag','figMain');        
        fileList = getappdata(fh,'fileNames');
        directoryPath = getappdata(fh,'directoryPath');
        threeDPlot(directoryPath, fileList,checkedColumns);
    else%if(length(checkedColumns)>2)
        errordlg('To View 3D Mapping, Please Select Only One Channel at a Time');     
    end

%%
% --- Executes on button press in chkboxSeparateChannels.

function chkboxSeparateChannels_Callback(hObject, eventdata, handles)
% hObject    handle to chkboxSeparateChannels (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of chkboxSeparateChannels

    if (get(hObject,'Value') == get(hObject,'Max'))
        % Checkbox is checked
        setappdata(findobj('Tag','figMain'),'SeparateChannels',1);
    else
        % Checkbox is not checked
        setappdata(findobj('Tag','figMain'),'SeparateChannels',0);        
    end 


% --------------------------------------------------------------------
function baselineCorrectorMenu_Callback(hObject, eventdata, handles)
%%
% hObject    handle to baselineCorrectorMenu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

    run baselineCorrector;


% --------------------------------------------------------------------
function fileSplitter_Callback(hObject, eventdata, handles)
    %%
% hObject    handle to fileSplitter (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

    [fileName, pathName] = uigetfile({'*.txt','ASCII Text Format Recording (*.txt)'}, 'Select a Multisweep ASCII Text Format Recording (*.txt)', 'Select a Multisweep Recording File');
    if isequal(fileName,0)
       errordlg('Please Select a Multisweep Recording File for Splitting');
    else
       fileList=readnsplitFile(fileName,pathName);
       set(findobj('Tag','lstboxContent'),'String',fileList,...
            'Value',1);
       set(findobj('Tag','lblPath'),'String',pathName);
       setappdata(findobj('Tag','figMain'),'directoryPath',pathName);
       set(findobj('Tag','btnLoad'),'Enable','On');
       set(findobj('Tag','btnLoad'),'String','Load Data Files')
    end

% --------------------------------------------------------------------
function artifactRemover_Callback(hObject, eventdata, handles)
    %%
    % hObject    handle to artifactRemover (see GCBO)
    % eventdata  reserved - to be defined in a future version of MATLAB
    % handles    structure with handles and user data (see GUIDATA)



% --- Executes on button press in tbZoom.
function tbZoom_Callback(hObject, eventdata, handles)
    %%
% hObject    handle to tbZoom (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of tbZoom

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

% --- Executes on button press in tbDataCursor.
function tbDataCursor_Callback(hObject, eventdata, handles)
    %%
% hObject    handle to tbDataCursor (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of tbDataCursor

    button_state = get(hObject,'Value');
    if button_state == get(hObject,'Max')
	% Toggle button is pressed, take appropriate action
        datacursormode on;
        dcm_obj=datacursormode(findobj('Tag','figMain'));
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


% --- Executes on button press in btnResetGraph.
function btnResetGraph_Callback(hObject, eventdata, handles)
    %%
% hObject    handle to btnResetGraph (see GCBO)
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


% --- Executes on button press in tbPan.
function tbPan_Callback(hObject, eventdata, handles)
%%
% hObject    handle to tbPan (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of tbPan


    button_state = get(hObject,'Value');
    if button_state == get(hObject,'Max')
	% Toggle button is pressed, take appropriate action
        pan on;
%         dcm_obj=datacursormode(findobj('Tag','figMain'));
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
function lfpCharacterization_Callback(hObject, eventdata, handles)
%%
% hObject    handle to lfpCharacterization (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function estimateLatency_Callback(hObject, eventdata, handles)
%%
% hObject    handle to estimateLatency (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

    run latencyEstimator;


% --------------------------------------------------------------------
function fileDownSampler_Callback(hObject, eventdata, handles)
%%
% hObject    handle to fileDownSampler (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

    run DownSampler;


% --------------------------------------------------------------------
function modelBasedSimulations_Callback(hObject, eventdata, handles)
%%
% hObject    handle to modelBasedSimulations (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function apSimulationMenu_Callback(hObject, eventdata, handles)
%%
% hObject    handle to apSimulationMenu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

    msgbox({'Sorry!', 'This feature will be available in the future releases!'},'Feature Unavailable','Error');

% --------------------------------------------------------------------
function stimBasedSimulationMenu_Callback(hObject, eventdata, handles)
%%
% hObject    handle to stimBasedSimulationMenu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

    msgbox({'Sorry!', 'This feature will be available in the future releases!'},'Feature Unavailable','Error');
% --------------------------------------------------------------------
function characterizeNoiseMenu_Callback(hObject, eventdata, handles)
%%
% hObject    handle to characterizeNoiseMenu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
    
    run noiseCharacterizer;

% --------------------------------------------------------------------
function helpMenu_Callback(hObject, eventdata, handles)
%%
% hObject    handle to helpMenu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function manualMenu_Callback(hObject, eventdata, handles)
%%
% hObject    handle to manualMenu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

    msgbox({'Sorry!', 'This feature will be available in the future releases!'},'Feature Unavailable','Error');
% --------------------------------------------------------------------
function aboutMenu_Callback(hObject, eventdata, handles)
%%
% hObject    handle to aboutMenu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

    run aboutSigMate;
    
    
% --------------------------------------------------------------------
function creditsMenu_Callback(hObject, eventdata, handles)
%%
% hObject    handle to creditsMenu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function menuSpike_Callback(hObject, eventdata, handles)
% hObject    handle to menuSpike (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function spikeDetectionAndSorting_Callback(hObject, eventdata, handles)
% hObject    handle to spikeDetectionAndSorting (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

    run wave_clus;


% --------------------------------------------------------------------
function csdAnalysis_Callback(hObject, eventdata, handles)
% hObject    handle to csdAnalysis (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


    run csdAnalyzer;


% --------------------------------------------------------------------
function lfpmnuShapeCharacterization_Callback(hObject, eventdata, handles)
% hObject    handle to lfpmnuShapeCharacterization (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


    run lfpSorting


% --------------------------------------------------------------------
function fastArtifactRemover_Callback(hObject, eventdata, handles)
% hObject    handle to fastArtifactRemover (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%     run artifactRemovalTemplateSubtraction;

    msgbox({'Sorry!', 'This feature will be available in the future releases!'},'Feature Unavailable','Error');

% --------------------------------------------------------------------
function slowArtifactRemover_Callback(hObject, eventdata, handles)
% hObject    handle to slowArtifactRemover (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


    run artifactRemoval;    


% --------------------------------------------------------------------
function eegInterface_Callback(hObject, eventdata, handles)
% hObject    handle to eegInterface (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function acqProcEEG_Callback(hObject, eventdata, handles)
% hObject    handle to acqProcEEG (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%     run gMOBIlabBCI_muda_V4:

    msgbox({'Sorry!', 'This feature will be available in the future releases!'},'Feature Unavailable','Error');

%%
% --------------------------------------------------------------------
function depthProfiler_Callback(hObject, eventdata, handles)
% hObject    handle to depthProfiler (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

    run depthProfile;


% --------------------------------------------------------------------
function angularTuningCalculator_Callback(hObject, eventdata, handles)
% hObject    handle to angularTuningCalculator (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

    run angularTuning;



% --------------------------------------------------------------------
function eeglab_Callback(hObject, eventdata, handles)
% hObject    handle to eeglab (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

    run eeglab;


% --------------------------------------------------------------------
function chronuxLink_Callback(hObject, eventdata, handles)
% hObject    handle to chronuxLink (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

    run run_chronux;

% --- Executes during object creation, after setting all properties.
% function axsmainSigMate_CreateFcn(hObject, eventdata, handles)
% hObject    handle to axsmainSigMate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: place code in OpeningFcn to populate axsmainSigMate

%     axes(findobj('Tag','axHead'))
%     pathLogo = which('SigMate-Logo.gif');
%     imshow(pathLogo)
