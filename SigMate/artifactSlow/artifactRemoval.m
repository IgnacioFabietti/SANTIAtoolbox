function varargout = artifactRemoval(varargin)
% ARTIFACTREMOVAL M-file for artifactRemoval.fig
%      ARTIFACTREMOVAL, by itself, creates a new ARTIFACTREMOVAL or raises the existing
%      singleton*.
%
%      H = ARTIFACTREMOVAL returns the handle to a new ARTIFACTREMOVAL or the handle to
%      the existing singleton*.
%
%      ARTIFACTREMOVAL('CALLBACK',hObject,eventData,handles,...) calls the
%      local
%      function named CALLBACK in ARTIFACTREMOVAL.M with the given input arguments.
%
%      ARTIFACTREMOVAL('Property','Value',...) creates a new ARTIFACTREMOVAL or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before FirstGUI_OpeningFunction gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to artifactRemoval_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help artifactRemoval

% Last Modified by GUIDE v2.5 04-May-2012 17:49:06

% Begin initialization code - DO NOT EDIT


gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @artifactRemoval_OpeningFcn, ...
                   'gui_OutputFcn',  @artifactRemoval_OutputFcn, ...
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

% --- Executes just before artifactRemoval is made visible.
function artifactRemoval_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to artifactRemoval (see VARARGIN)

% Choose default command line output for artifactRemoval
handles.output = hObject;

set(handles.figArtifactRemoval, 'CloseRequestFcn', 'closeGUI');

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes artifactRemoval wait for user response (see UIRESUME)
% uiwait(handles.figArtifactRemoval);

%%

% --- Outputs from this function are returned to the command line.
function varargout = artifactRemoval_OutputFcn(hObject, eventdata, handles) 
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


% --- Executes on button press in btnarBrowse.
function btnarBrowse_Callback(hObject, eventdata, handles)
% hObject    handle to btnarBrowse (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
    
%     global filelist, filenames
    
    %clear if any application data exists
    
    fh = findobj('Tag', 'figArtifactRemoval');    
    if(isappdata(fh,'averaged_time')&& isappdata(fh,'averaged_time_bl'))
        rmappdata(fh,'averaged_time');
        rmappdata(fh,'averaged_time_bl');        
    end
    if(isappdata(fh,'averaged_data')&& isappdata(fh,'averaged_data_bl'))
        rmappdata(fh,'averaged_data');
        rmappdata(fh,'averaged_data_bl');
    end  
    
    path = uigetdir('D:\MatlabWorks','Select a Directory'); %Select the directory and store the path at folder 
    
    if(path) % if a directory is selected
        
        setappdata(fh, 'directoryPath', strcat(path,'\'));
        handle_lblarPath = findobj('Tag', 'lblarPath'); % find the object with the Tag lblarPath and store the reference handle

        if (handle_lblarPath ~= 0) % if the above searched object found
            text = get(handle_lblarPath,'String');  % get the text of the object
            if(~(strcmp(text,'Selected Directory Path of Signal')))
                text = 'Selected Directory Path of Signal';
            end
            newtext = strcat(text, ': ', path); % append the folder path to the content
            set(handle_lblarPath,'String',newtext); % set the new text to the control
        end

        newpath = strcat(regexprep(path,'\','/'),'/*.txt'); %replace the path with a forward slash '/'instead of a backward slash and add the file type

        dir_struct = dir(newpath);
        [file_names,file_index] = sortrows({dir_struct.name}');
        handles.file_names = file_names;
        handles.is_dir = [dir_struct.isdir];
        handles.file_index = file_index;
        guidata(hObject,handles);
        setappdata(fh,'fileNames',file_names);
        set(findobj('Tag','lstboxarContent'),'String',handles.file_names,...
            'Value',1);
        
        %This is to prompt for the baseline directory
        
        pathbl = uigetdir(path,'Select a Directory Containing Baseline Recordings'); %Select the directory and store the path at folder 

        if(pathbl) % if a directory is selected

            setappdata(fh, 'directoryPathBaseline', strcat(pathbl,'\'));
            handle_lblarPathBaseline = findobj('Tag', 'lblarPathBaseline'); % find the object with the Tag lblarPath and store the reference handle

            if (handle_lblarPathBaseline ~= 0) % if the above searched object found
                text = get(handle_lblarPathBaseline,'String');  % get the text of the object
                if(~(strcmp(text,'Selected Directory Path of Baseline')))
                    text = 'Selected Directory Path of Baseline';
                end
                newtext = strcat(text, ': ', pathbl); % append the folder path to the content
                set(handle_lblarPathBaseline,'String',newtext); % set the new text to the control
            end

            newpath = strcat(regexprep(pathbl,'\','/'),'/*.txt'); %replace the path with a forward slash '/'instead of a backward slash and add the file type

            dir_struct = dir(newpath);
            [file_namesbl,file_indexbl] = sortrows({dir_struct.name}');
            handles.file_namesbl = file_namesbl;
            handles.is_dir = [dir_struct.isdir];
            handles.file_indexbl = file_indexbl;
            guidata(hObject,handles);
            setappdata(fh,'fileNamesBaseline',file_namesbl);
            set(findobj('Tag','lstboxarblContent'),'String',handles.file_namesbl,...
                'Value',1);        


            set(findobj('Tag','btnarLoad'),'Enable', 'On');
            set(findobj('Tag','btnarLoad'),'String', 'Load Data Files');        
            set(findobj('Tag','btnarRemoveFile'),'Enable', 'On');
            set(findobj('Tag','btnarRemoveBaselineFiles'),'Enable','On');
            set(findobj('Tag','btnPlot3D'),'Enable', 'On');
            set(findobj('Tag','btnarMoveUp'),'Enable', 'On');
            set(findobj('Tag','btnarMoveDown'),'Enable', 'On');        
            set(findobj('Tag','chkboxarIm'),'Enable', 'On');
            set(findobj('Tag','chkboxarVm'),'Enable', 'On');
            set(findobj('Tag','chkboxarStimulus'),'Enable', 'On');
            set(findobj('Tag','chkboxarVj'),'Enable', 'On');
            set(findobj('Tag','chkboxarVavg'),'Enable', 'On');
            firstCondition=strcmpi(get(findobj('Tag','btnarAverage'),'Enable'),'On');
            secondCondition=strcmpi(get(findobj('Tag','btnRemoveArtifact'),'Enable'),'On');
            if(firstCondition||secondCondition)
                set(findobj('Tag','btnarAverage'),'Enable', 'Off');
                set(findobj('Tag','btnNoiseEstimation'),'Enable', 'Off');
                set(findobj('Tag','btnInvertedAverage'),'Enable', 'Off');
                set(findobj('Tag','btnMeanSquare'),'Enable', 'Off');
                set(findobj('Tag','btnRootMeanSquare'),'Enable', 'Off');
                set(findobj('Tag','btnRemoveArtifact'),'Enable', 'Off');            
            end

    %         if(strcmpi(get(findobj('Tag','btnRearrange'),'Enable'),'On'))
    %             set(findobj('Tag','btnRearrange'),'Enable', 'Off');  
    %             set(findobj('Tag','btnRearrange'),'Visible', 'Off');          
    % 
    %             set(findobj('Tag','btnarLoad'),'Visible', 'On');
    %             set(findobj('Tag','btnarAverage'),'Visible', 'On');
    %             set(findobj('Tag','btnNoiseEstimation'),'Visible', 'On');
    %             set(findobj('Tag','btnInvertedAverage'),'Visible', 'On');
    %             set(findobj('Tag','btnMeanSquare'),'Visible', 'On');
    %             set(findobj('Tag','btnRootMeanSquare'),'Visible', 'On');            
    %         end

    %         if(strcmpi(get(findobj('Tag','btnPlot3D'),'Enable'),'On'))
    %             set(findobj('Tag','btnPlot3D'),'Enable', 'Off');            
    %             set(findobj('Tag','btnPlot3D'),'Visible', 'Off');
    % 
    %             set(findobj('Tag','btnarLoad'),'Visible', 'On');
    %             set(findobj('Tag','btnarAverage'),'Visible', 'On');
    %             set(findobj('Tag','btnNoiseEstimation'),'Visible', 'On');
    %             set(findobj('Tag','btnInvertedAverage'),'Visible', 'On');
    %             set(findobj('Tag','btnMeanSquare'),'Visible', 'On');
    %             set(findobj('Tag','btnRootMeanSquare'),'Visible', 'On');            
    %         end        

        else %if the directory selection dialog is cancelled
            msgbox('Please Select a Directory for Analysis', 'Directory Not Selected','Error');
        end
    end    

    listbox_contents = get(findobj('Tag', 'lstboxarContent'), 'String');
    selected_index = get(findobj('Tag', 'lstboxarContent'), 'Value');    
    if(selected_index == 1)
        set(findobj('Tag','btnarMoveUp'),'Enable', 'Off');
    elseif(selected_index == length(listbox_contents))
        set(findobj('Tag','btnarMoveDown'),'Enable', 'Off');        
    end

    


%%


% --- Executes on selection change in lstboxarContent.
function lstboxarContent_Callback(hObject, eventdata, handles)
% hObject    handle to lstboxarContent (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = get(hObject,'String') returns lstboxarContent contents as cell array
%        contents{get(hObject,'Value')} returns selected item from lstboxarContent

    listbox_contents = get(findobj('Tag', 'lstboxarContent'), 'String');
    selected_index = get(findobj('Tag', 'lstboxarContent'), 'Value');
    fh = findobj('Tag','figArtifactRemoval');
    
    if(selected_index == 1)
        set(findobj('Tag','btnarMoveUp'),'Enable', 'Off');
        set(findobj('Tag','btnarMoveDown'),'Enable', 'On');        
    else
        set(findobj('Tag','btnarMoveUp'),'Enable', 'On');        
    end    

    if(selected_index == length(listbox_contents))
        set(findobj('Tag','btnarMoveDown'),'Enable', 'Off');
        set(findobj('Tag','btnarMoveUp'),'Enable', 'On');
    else
        set(findobj('Tag','btnarMoveDown'),'Enable', 'On');        
    end

    %this is to relate the contents of the two listboxes.
    flag2=0;
    if(get(findobj('Tag','chkboxarRelate'),'Value') == get(findobj('Tag','chkboxarRelate'),'Max'))
    
        fh_listboxbaseline = findobj('Tag','lstboxarblContent');
        set(fh_listboxbaseline,'Value',selected_index);
        contents_baseline=get(fh_listboxbaseline,'String');
        flag2=1;
    end
    
    [checkedColumns, flag] = selectedColumns();
%     checkedColumns = getappdata(fh, 'checkedColumns');
    
    if(flag || flag2)       
        filePath = getappdata(fh, 'directoryPath');
        [fet_time, fet_data] = readData(filePath, listbox_contents{selected_index}, checkedColumns);
        if (flag2)
            filePathBaseline = getappdata(fh,'directoryPathBaseline');
            if (selected_index <= length(contents_baseline))
                [fet_time_bl,fet_data_bl]=readData(filePathBaseline,contents_baseline{selected_index},checkedColumns);
            else
                flag2=0;
                errordlg('There is no corresponding Artifact file for the selected Signal','Relate Error');                
            end
        end
        color = {'r','g','b','c','m','y','k'};        
        cla(findobj('Tag','axarMain'));
%         axes(findobj('Tag','axarMain'));
        columns = length(checkedColumns);
        hold on
        for i=1:1:columns-1
            if (flag2)
                plot(fet_time, fet_data(:,i),color{i},fet_time_bl, fet_data_bl(:,i),color{i+1});
            else
                plot(fet_time, fet_data(:,i),color{i});
            end
            title(['Plot of Selected Column: ',num2str(i)]);
        end
        axis('tight');
        hold off
    end
    
    
    
    
%     plotData(handles.fet_time, handles.fet_data,handles.axarMain, ['Selected FET Recording of ',listbox_contents{selected_index}], handles);
    


%%

% --- Executes during object creation, after setting all properties.
function lstboxarContent_CreateFcn(hObject, eventdata, handles)
% hObject    handle to lstboxarContent (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



%%

% --- Executes on button press in btnarAverage.
function btnarAverage_Callback(hObject, eventdata, handles)
% hObject    handle to btnarAverage (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%     hold on;
    fh = findobj('Tag', 'figArtifactRemoval');
    
%     signalType = getappdata(fh,'signalType');
    
%     checkedColumns = getappdata(fh, 'checkedColumns');
    time = getappdata(fh, 'fet_time');    
    data = getappdata(fh, 'fet_data');
    
    time_bl = getappdata(fh,'fet_time_bl');
    data_bl = getappdata(fh,'fet_data_bl');    
    
    if(~isappdata(fh,'averaged_data')||~isappdata(fh,'averaged_data_bl'))
        processData(time, data, 'Average','signal');
        processData(time_bl, data_bl, 'Average','baseline');
        set(findobj('Tag','btnRemoveArtifact'),'Enable', 'On');        
    end
    
    plotData(findobj('Tag','axarMain'), 'Average of FET Recordings', fh,'signal');
    plotData(findobj('Tag','axarMain'), 'Average of FET Recordings', fh,'baseline');    
    
    set(findobj('Tag','btnRemoveArtifact'),'Enable','On');    
    
%     plotData(handles.averaged_time, handles.odd_data, handles.axarMain, 'odd');
%     plotData(handles.averaged_time, handles.even_data, handles.axarMain, 'even');
%     hold off;
    
    
    
%%

function plotData(axesName, plotTitle, handles, flagData)
    cla(axesName);

    axes(axesName);
    

    grid on
    color = {'r','g','b','c','m','y','k'};     
    checkedColumns = getappdata(handles, 'checkedColumns'); % get the columns which are checked
    switch lower(flagData)
        case 'signal'
            if(strcmp(plotTitle,'Average of FET Recordings'))

                figure('Name','SigMate: Average of FET Recordings','NumberTitle','off');        
                title(plotTitle);
                time = getappdata(handles, 'averaged_time');
                data = getappdata(handles, 'averaged_data');
                if (getappdata(handles, 'signalType')==2)        
                    for i = 1:1:length(checkedColumns)-1
                        if(checkedColumns(i+1)==2)
                            subplot(length(checkedColumns)-1,1,i-1);
                            plot(time,data(:,i),color{i});
                            title('Plot for VmAC');
                            xlabel('Time (S)');
                            ylabel('V (mV)');
                        elseif(checkedColumns(i+1)==3)
                            subplot(length(checkedColumns)-1,1,i-1);
                            plot(time,data(:,i),color{i});
                            title('Plot for VmDC');
                            xlabel('Time (S)');
                            ylabel('V (mV)');                    
                        elseif(checkedColumns(i+1)==4)
                            subplot(length(checkedColumns)-1,1,i-1);
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

            end
        case 'baseline'
            if(strcmp(plotTitle,'Average of FET Recordings'))

                figure('Name','SigMate: Average of Baseline of FET Recordings','NumberTitle','off');        
                title(plotTitle);
                time = getappdata(handles, 'averaged_time_bl');
                data = getappdata(handles, 'averaged_data_bl');
                if (getappdata(handles, 'signalType')==2)        
                    for i = 1:1:length(checkedColumns)-1
                        if(checkedColumns(i+1)==2)
                            subplot(length(checkedColumns)-1,1,i-1);
                            plot(time,data(:,i),color{i});
                            title('Plot for VmAC');
                            xlabel('Time (S)');
                            ylabel('V (mV)');
                        elseif(checkedColumns(i+1)==3)
                            subplot(length(checkedColumns)-1,1,i-1);
                            plot(time,data(:,i),color{i});
                            title('Plot for VmDC');
                            xlabel('Time (S)');
                            ylabel('V (mV)');                    
                        elseif(checkedColumns(i+1)==4)
                            subplot(length(checkedColumns)-1,1,i-1);
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

            elseif(strcmp(plotTitle,'Estimated Noise in the Baseline Recordings'))
                time = getappdata(handles, 'averaged_time_bl');
                data = getappdata(handles, 'averaged_data_bl');      
                estimatedNoise = getappdata(handles, 'noiseEstimation_bl');
                noiselessAveragedData = getappdata(handles,'noiselessAveragedData_bl');
                figure('Name','SigMate: Estimated Noise in Baseline of the Recordings','NumberTitle','off');
                for i=1:1:length(checkedColumns)-1
                    subplot((length(checkedColumns)-1)*3,1,(i*3)-2);
                    plot(time,data(:,i),color{i});          
                    title(['Plot of Averaged Baseline Signal for FET Recordings for Channel', num2str(i)]);
                    xlabel('Time (S)');
                    ylabel('V (mV)');
                    subplot((length(checkedColumns)-1)*3,1,(i*3)-1);
                    plot(time(1:2:length(time)),estimatedNoise(:,i),color{i});
                    title(['Noise Estimation for the Baseline Channel ', num2str(i)]);
                    xlabel('Time (S)');
                    ylabel('V (mV)');
                    subplot((length(checkedColumns)-1)*3,1,(i*3));
                    plot(time,noiselessAveragedData(:,i),color{i});
                    title(['Averaged Baseline Signal after Noise Subtraction for the Channel ', num2str(i)]);
                    xlabel('Time (S)');
                    ylabel('V (mV)');              
                end
                axis('tight');

            elseif(strcmp(plotTitle,'+/- Average of FET Recordings'))
                time = getappdata(handles, 'averaged_time_bl');
                data = getappdata(handles, 'averaged_data_bl');      
                averagedOdd = getappdata(handles, 'averaged_odd_data_bl');
                averagedEven = getappdata(handles, 'averaged_even_data_bl');        
                figure('Name','SigMate: +/- Average of Baseline of FET Recordings','NumberTitle','off');
                for i=1:1:length(checkedColumns)-1
                    subplot((length(checkedColumns)-1)*2,1,(i*2)-1);
                    plot(time,data(:,i),color{i});          
                    title(['Plot of Averaged Baseline Signal for FET Recordings for Channel', num2str(i)]);
                    xlabel('Time (S)');
                    ylabel('V (mV)');
                    subplot((length(checkedColumns)-1)*2,1,(i*2));
                    hold on
                    plot(time(1:2:length(time)),averagedOdd(:,i),'b');
                    plot(time(2:2:length(time)),averagedEven(:,i),'g');
                    title(['+/- Average of Baseline of FET Recordings for the Channel ', num2str(i)]);
                    xlabel('Time (S)');
                    ylabel('V (mV)');
                    hold off
                end
                axis('tight');
            elseif(strcmp(plotTitle,'Mean Square Average of Baseline of FET Recordings'))
                time = getappdata(handles, 'averaged_time_bl');
                data = getappdata(handles, 'averaged_data_bl');      
                meanSquaredData = getappdata(handles, 'ms_averaged_data_bl');
                figure('Name','SigMate: Mean Square Average of Baseline of FET Recordings','NumberTitle','off');
                for i=1:1:length(checkedColumns)-1
                    subplot((length(checkedColumns)-1)*2,1,(i*2)-1);
                    plot(time,data(:,i),color{i});          
                    title(['Plot of Averaged Baseline Signal for FET Recordings for Channel', num2str(i)]);
                    xlabel('Time (S)');
                    ylabel('V (mV)');
                    subplot((length(checkedColumns)-1)*2,1,(i*2));
                    plot(time,meanSquaredData(:,i),color{i});
                    title(['Mean Square Average of Baseline FET Recordings for Channel ', num2str(i)]);
                    xlabel('Time (S)');
                    ylabel('V (mV)');            
                end
                axis('tight');
            elseif(strcmp(plotTitle,'Root Mean Square Average of FET Recordings'))
                time = getappdata(handles, 'averaged_time_bl');
                data = getappdata(handles, 'averaged_data_bl');      
                rootmeanSquaredData = getappdata(handles, 'rms_averaged_data_bl');
                figure('Name','SigMate: Root Mean Square Average of Baseline of FET Recording','NumberTitle','off');
                for i=1:1:length(checkedColumns)-1
                    subplot((length(checkedColumns)-1)*2,1,(i*2)-1);
                    plot(time,data(:,i),color{i});          
                    title(['Plot of Averaged Baseline Signal for FET Recordings for Channel', num2str(i)]);
                    xlabel('Time (S)');
                    ylabel('V (mV)');
                    subplot((length(checkedColumns)-1)*2,1,(i*2));
                    plot(time,rootmeanSquaredData(:,i),color{i});
                    title(['Root Mean Square Average of Baseline of FET Recordings for Channel ', num2str(i)]);
                    xlabel('Time (S)');
                    ylabel('V (mV)');            
                end
                axis('tight');          

            end
            
    end



%%

% --- Executes on button press in btnNoiseEstimation.
function btnNoiseEstimation_Callback(hObject, eventdata, handles)
% hObject    handle to btnNoiseEstimation (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

    fh = findobj('Tag', 'figArtifactRemoval');
        
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
    datafile=[]; %#ok
    dataFile = [averagedTime, averagedData]; %#ok
    save('NoiselessAveragedData.txt', 'dataFile','-ASCII','-tabs');
    cd(oldPath);
    
    plotData(findobj('Tag','axarMain'),'Estimated Noise in the Recordings', fh);

%%

% --- Executes on button press in btnInvertedAverage.
function btnInvertedAverage_Callback(hObject, eventdata, handles)
% hObject    handle to btnInvertedAverage (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
   
    fh = findobj('Tag','figArtifactRemoval');    
    
    if((~isappdata(fh,'averaged_odd_data'))&&(~isappdata(fh,'averaged_even_data')))
        time = getappdata(fh, 'fet_time');    
        data = getappdata(fh, 'fet_data');        
        processData(time, data, 'Average');
    end
    
    plotData(findobj('Tag','axarMain'), '+/- Average of FET Recordings', fh);


%%

% --- Executes on button press in btnMeanSquare.
function btnMeanSquare_Callback(hObject, eventdata, handles)
% hObject    handle to btnMeanSquare (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

    fh=findobj('Tag', 'figArtifactRemoval');
    if(~isappdata(fh,'ms_averaged_data'))
        time = getappdata(fh, 'fet_time');    
        data = getappdata(fh, 'fet_data');        
        processData(time, data, 'MeanSquare');
    end
%     hold on;
    plotData(findobj('Tag','axarMain'), 'Mean Square Average of FET Recordings', fh);

%%

% --- Executes on button press in btnRootMeanSquare.
function btnRootMeanSquare_Callback(hObject, eventdata, handles)
% hObject    handle to btnRootMeanSquare (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

    fh=findobj('Tag', 'figArtifactRemoval');
    if(~isappdata(fh,'rms_averaged_data'))
        time = getappdata(fh, 'fet_time');    
        data = getappdata(fh, 'fet_data');        
        processData(time, data, 'MeanSquare');
    end
%     hold on;
    plotData(findobj('Tag','axarMain'), 'Root Mean Square Average of FET Recordings', fh);

%%

% --- Executes on button press in btnarLoad.
function btnarLoad_Callback(hObject, eventdata, handles)
% hObject    handle to btnarLoad (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

    figure_handle = findobj('Tag', 'figArtifactRemoval');
    
    listbox_contents = get(findobj('Tag', 'lstboxarContent'), 'String');
    listbox_contents_bl = get(findobj('Tag','lstboxarblContent'),'String');
    
    [checkedColumns, flag]=selectedColumns();
    
    if(flag) %if proper signal source and channels are selected

        [fet_time, fet_data, samplingFreq, dataPoints] = loadData(listbox_contents, getappdata(figure_handle,'directoryPath'),checkedColumns);
        [fet_time_bl, fet_data_bl, samplingFreq_bl, dataPoints_bl] = loadData(listbox_contents_bl, getappdata(figure_handle,'directoryPathBaseline'),checkedColumns);

        setappdata(figure_handle, 'fet_time', fet_time);
        setappdata(figure_handle, 'fet_data', fet_data);        
        setappdata(figure_handle, 'samplingFreq', samplingFreq);
        setappdata(figure_handle, 'dataPoints', dataPoints);

        setappdata(figure_handle, 'fet_time_bl', fet_time_bl);
        setappdata(figure_handle, 'fet_data_bl', fet_data_bl);        
        setappdata(figure_handle, 'samplingFreq_bl', samplingFreq_bl);
        setappdata(figure_handle, 'dataPoints_bl', dataPoints_bl);         

        set(findobj('Tag','btnarLoad'),'String', 'Data Files Loaded');
        set(findobj('Tag','btnarLoad'),'Enable', 'Off');
        set(findobj('Tag','btnarMoveUp'),'Enable', 'Off');
        set(findobj('Tag','btnarMoveDown'),'Enable', 'Off');
        set(findobj('Tag','btnRemoveArtifact'),'Enable', 'On');        
        set(findobj('Tag','btnarAverage'),'Enable', 'On');
        set(findobj('Tag','btnNoiseEstimation'),'Enable', 'On');    
        set(findobj('Tag','btnInvertedAverage'),'Enable', 'On');    
        set(findobj('Tag','btnMeanSquare'),'Enable', 'On');   
        set(findobj('Tag','btnRootMeanSquare'),'Enable', 'On'); 
        set(findobj('Tag','btnarRemoveFile'),'Enable', 'Off');
        set(findobj('Tag','btnarRemoveBaselineFiles'),'Enable', 'Off');        
        set(findobj('Tag','chkboxarIm'),'Enable', 'Off');
        set(findobj('Tag','chkboxarVm'),'Enable', 'Off');
        set(findobj('Tag','chkboxarStimulus'),'Enable', 'Off');
        set(findobj('Tag','chkboxarVj'),'Enable', 'Off');
        set(findobj('Tag','chkboxarVavg'),'Enable', 'Off');     
    end    
    
    
    
%%

function [checkedColumns, flag] = selectedColumns()
%%
    
    figure_handle = findobj('Tag', 'figArtifactRemoval');
      
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

% function [processed_time, processed_data] = processData(time, data, flagString)

% --- Executes on button press in btnarRemoveFile.
function btnarRemoveFile_Callback(hObject, eventdata, handles)
    %%
% hObject    handle to btnarRemoveFile (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

    fh=findobj('Tag','lstboxarContent');
    selected = get(fh,'Value'); 
    prev_str = get(fh, 'String'); 
    if ~isempty(prev_str) 
        prev_str(get(fh,'Value')) = []; 
        set(fh, 'String', prev_str, ... 
            'Value', min(selected,length(prev_str))); 
        setappdata(findobj('Tag','figArtifactRemoval'),'fileNames',prev_str);
    end



function processData(time, data, flagString, flagData)
    
    fh = findobj('Tag','figArtifactRemoval');
    
    switch lower(flagData)
        case 'signal'
            fileCount=length(getappdata(findobj('Tag','figArtifactRemoval'),'fileNames'));    

            dataPoints = getappdata(fh,'dataPoints'); 
            columns = getappdata(fh, 'checkedColumns');

            processed_data=[];


            switch lower(flagString)
                case 'average'
                    reshapedData = reshape(data,dataPoints,fileCount,length(columns)-1); % reshape and transpose the data matrix for averaging

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

                    fh = findobj('Tag', 'figArtifactRemoval');

                    setappdata(fh, 'averaged_time', processed_time);
                    setappdata(fh, 'averaged_data', processed_data);                     

                    setappdata(fh, 'averaged_odd_data', averaged_odd_data);
                    setappdata(fh, 'averaged_even_data', averaged_even_data);

                    directoryPath=getappdata(fh,'directoryPath');
                    oldPath=pwd;
                    cd(directoryPath);
                    datafile=[];%#ok
                    dataFile = [processed_time, processed_data];%#ok
                    save('AveragedData.txt', 'dataFile','-ASCII','-tabs');
                    datafile=[];%#ok
                    dataFile = [processed_time(1:2:length(processed_time)), averaged_odd_data];%#ok
                    save('OddAveragedData.txt', 'dataFile','-ASCII','-tabs');
                    datafile=[];            %#ok
                    dataFile = [processed_time(2:2:length(processed_time)), averaged_even_data];   %#ok         
                    save('EvenAveragedData.txt', 'dataFile','-ASCII','-tabs')            
                    cd(oldPath);

                case 'meansquare'            
                    reshapedData = reshape(data,dataPoints,fileCount,length(columns)-1); % reshape and transpose the data matrix for averaging

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

                    fh = findobj('Tag', 'figArtifactRemoval');

                    setappdata(fh, 'averaged_time', processed_time);
                    setappdata(fh, 'averaged_data', processed_data);            
                    setappdata(fh, 'ms_averaged_data', ms_processed_data);
                    setappdata(fh, 'rms_averaged_data', rms_processed_data);

                    directoryPath=getappdata(fh,'directoryPath');
                    oldPath=pwd;
                    cd(directoryPath);
                    if(~isappdata(fh,'averaged_data'))
                        datafile=[];%#ok
                        dataFile = [processed_time, processed_data];%#ok
                        save('AveragedData.txt', 'dataFile','-ASCII','-tabs');
                    end
                    datafile=[];%#ok
                    dataFile = [processed_time, ms_processed_data];%#ok
                    save('MeanSquareAveragedData.txt', 'dataFile','-ASCII','-tabs');            
                    datafile=[];%#ok
                    dataFile = [processed_time, rms_processed_data];%#ok
                    save('RootMeanSquareAveragedData.txt', 'dataFile','-ASCII','-tabs');
                    cd(oldPath);            

            end
            
        case 'baseline'
            fileCount=length(getappdata(findobj('Tag','figArtifactRemoval'),'fileNamesBaseline'));    

            dataPoints = getappdata(fh,'dataPoints_bl'); 
            columns = getappdata(fh, 'checkedColumns');

            processed_data=[];


            switch lower(flagString)
                case 'average'
                    reshapedData = reshape(data,dataPoints,fileCount,length(columns)-1); % reshape and transpose the data matrix for averaging

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

                    fh = findobj('Tag', 'figArtifactRemoval');

                    setappdata(fh, 'averaged_time_bl', processed_time);
                    setappdata(fh, 'averaged_data_bl', processed_data);                     

                    setappdata(fh, 'averaged_odd_data_bl', averaged_odd_data);
                    setappdata(fh, 'averaged_even_data_bl', averaged_even_data);

                    directoryPath=getappdata(fh,'directoryPathBaseline');
                    oldPath=pwd;
                    cd(directoryPath);
                    datafile=[];%#ok
                    dataFile = [processed_time, processed_data];%#ok
                    save('AveragedData.txt', 'dataFile','-ASCII','-tabs');
                    datafile=[];%#ok
                    dataFile = [processed_time(1:2:length(processed_time)), averaged_odd_data];%#ok
                    save('OddAveragedData.txt', 'dataFile','-ASCII','-tabs');
                    datafile=[];     %#ok       
                    dataFile = [processed_time(2:2:length(processed_time)), averaged_even_data];  %#ok          
                    save('EvenAveragedData.txt', 'dataFile','-ASCII','-tabs')            
                    cd(oldPath);

                case 'meansquare'            
                    reshapedData = reshape(data,dataPoints,fileCount,length(columns)-1); % reshape and transpose the data matrix for averaging

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

                    fh = findobj('Tag', 'figArtifactRemoval');

                    setappdata(fh, 'averaged_time_bl', processed_time);
                    setappdata(fh, 'averaged_data_bl', processed_data);            
                    setappdata(fh, 'ms_averaged_data_bl', ms_processed_data);
                    setappdata(fh, 'rms_averaged_data_bl', rms_processed_data);

                    directoryPath=getappdata(fh,'directoryPathBaseline');
                    oldPath=pwd;
                    cd(directoryPath);
                    if(~isappdata(fh,'averaged_data_bl'))
                        datafile=[];%#ok
                        dataFile = [processed_time, processed_data];%#ok
                        save('AveragedData.txt', 'dataFile','-ASCII','-tabs');
                    end
                    datafile=[];%#ok
                    dataFile = [processed_time, ms_processed_data];%#ok
                    save('MeanSquareAveragedData.txt', 'dataFile','-ASCII','-tabs');            
                    datafile=[];%#ok
                    dataFile = [processed_time, rms_processed_data];%#ok
                    save('RootMeanSquareAveragedData.txt', 'dataFile','-ASCII','-tabs');
                    cd(oldPath);            

            end            
    end
    

    %%

% --- Executes on selection change in pumarRecType.
function pumarRecType_Callback(hObject, eventdata, handles)
    %%
% hObject    handle to pumarRecType (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = get(hObject,'String') returns pumarRecType contents as cell array
%        contents{get(hObject,'Value')} returns selected item from pumarRecType

% selectedString = get(handles.pumarRecType, 'String');
    selectedValue = get(hObject, 'Value');

    setappdata(findobj('Tag','figArtifactRemoval'),'signalType',selectedValue);

    switch selectedValue
        case 2 % if the In-Vivo recording is selected
            set(findobj('Tag', 'btnarBrowse'), 'Enable', 'On');

            set(findobj('Tag', 'chkboxarVm'), 'Visible', 'On');
            set(findobj('Tag', 'chkboxarVm'), 'String', 'VmDC');        
            set(findobj('Tag', 'chkboxarIm'), 'Visible', 'On');    
            set(findobj('Tag', 'chkboxarStimulus'), 'Visible', 'On');        
            set(findobj('Tag', 'chkboxarIm'), 'String', 'VmAC');        
            set(findobj('Tag', 'chkboxarVj'), 'Visible', 'Off');  
            set(findobj('Tag', 'chkboxarVavg'), 'Visible', 'Off');          

        case 3 % if the Transistor recording is selected
            set(findobj('Tag', 'chkboxarIm'), 'Visible', 'On');  
            set(findobj('Tag', 'chkboxarIm'), 'String', 'Im');                
            set(findobj('Tag', 'chkboxarVm'), 'Visible', 'On');  
            set(findobj('Tag', 'chkboxarVm'), 'String', 'Vm');                
            set(findobj('Tag', 'chkboxarVj'), 'Visible', 'On');  
            set(findobj('Tag', 'chkboxarVavg'), 'Visible', 'On');  
            set(findobj('Tag', 'chkboxarStimulus'), 'Visible', 'Off');         

            set(findobj('Tag', 'btnarBrowse'), 'Enable', 'On');        
        otherwise % if nothing is selected
            msgbox('Please Select a Signal Source', 'Signal Source Not Selected','Error');
            set(findobj('Tag', 'btnarBrowse'), 'Enable', 'Off');
            set(findobj('Tag', 'chkboxarIm'), 'Visible', 'Off');  
            set(findobj('Tag', 'chkboxarVm'), 'Visible', 'Off');  
            set(findobj('Tag', 'chkboxarVj'), 'Visible', 'Off');  
            set(findobj('Tag', 'chkboxarVavg'), 'Visible', 'Off'); 
            set(findobj('Tag', 'chkboxarStimulus'), 'Visible', 'Off');         
    end


% --- Executes during object creation, after setting all properties.
function pumarRecType_CreateFcn(hObject, eventdata, handles)
% hObject    handle to pumarRecType (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

%%



% --- Executes on button press in chkboxarIm.
function chkboxarIm_Callback(hObject, eventdata, handles)
% hObject    handle to chkboxarIm (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of chkboxarIm

    if (get(hObject,'Value') == get(hObject,'Max'))
        % Checkbox is checked
        setappdata(findobj('Tag','figArtifactRemoval'),'Im',1);
    else
        % Checkbox is not checked
        setappdata(findobj('Tag','figArtifactRemoval'),'Im',0);        
    end    



%%

% --- Executes on button press in chkboxarVm.
function chkboxarVm_Callback(hObject, eventdata, handles)
% hObject    handle to chkboxarVm (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of chkboxarVm

    if (get(hObject,'Value') == get(hObject,'Max'))
        % Checkbox is checked
        setappdata(findobj('Tag','figArtifactRemoval'),'Vm',1);
    else
        % Checkbox is not checked
        setappdata(findobj('Tag','figArtifactRemoval'),'Vm',0);        
    end    

%%


% --- Executes on button press in chkboxarVj.
function chkboxarVj_Callback(hObject, eventdata, handles)
% hObject    handle to chkboxarVj (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of chkboxarVj

    if (get(hObject,'Value') == get(hObject,'Max'))
        % Checkbox is checked
        setappdata(findobj('Tag','figArtifactRemoval'),'Vj',1);
    else
        % Checkbox is not checked
        setappdata(findobj('Tag','figArtifactRemoval'),'Vj',0);        
    end    

%%

% --- Executes on button press in chkboxarVavg.
function chkboxarVavg_Callback(hObject, eventdata, handles)
%%
% hObject    handle to chkboxarVavg (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of chkboxarVavg

    if (get(hObject,'Value') == get(hObject,'Max'))
        % Checkbox is checked
        setappdata(findobj('Tag','figArtifactRemoval'),'Vavg',1);
    else
        % Checkbox is not checked
        setappdata(findobj('Tag','figArtifactRemoval'),'Vavg',0);        
    end    



% --- Executes on button press in chkboxarStimulus.
function chkboxarStimulus_Callback(hObject, eventdata, handles)
%%
% hObject    handle to chkboxarStimulus (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of chkboxarStimulus


    if (get(hObject,'Value') == get(hObject,'Max'))
        % Checkbox is checked
        setappdata(findobj('Tag','figArtifactRemoval'),'Stim',1);
    else
        % Checkbox is not checked
        setappdata(findobj('Tag','figArtifactRemoval'),'Stim',0);        
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

    fh = findobj('Tag', 'figArtifactRemoval');    
    if(isappdata(fh,'averaged_time'))
        rmappdata(fh,'averaged_time');
    end
    if(isappdata(fh,'averaged_data'))
        rmappdata(fh,'averaged_data');
    end  
    
    path = uigetdir('D:\MatlabWorks','Select a Directory'); %Select the directory and store the path at folder 
    
    if(path) % if a directory is selected
        
        setappdata(fh, 'directoryPath', strcat(path,'\'));
        handle_lblarPath = findobj('Tag', 'lblarPath'); % find the object with the Tag lblarPath and store the reference handle

        if (handle_lblarPath ~= 0) % if the above searched object found
            text = get(handle_lblarPath,'String');  % get the text of the object
            if(~(strcmp(text,'Selected Directory Path')))
                text = 'Selected Directory Path';
            end
            newtext = strcat(text, ': ', path); % append the folder path to the content
            set(handle_lblarPath,'String',newtext); % set the new text to the control
        end

        newpath = strcat(regexprep(path,'\','/'),'/*.txt'); %replace the path with a forward slash '/'instead of a backward slash and add the file type

        dir_struct = dir(newpath);
        [file_names,file_index] = sortrows({dir_struct.name}');
        handles.file_names = file_names;
        handles.is_dir = [dir_struct.isdir];
        handles.file_index = file_index;
        guidata(hObject,handles);
        setappdata(fh,'fileNames',file_names);
        set(findobj('Tag','lstboxarContent'),'String',handles.file_names,...
            'Value',1);
    
        set(findobj('Tag','btnarLoad'),'Visible', 'Off');
        set(findobj('Tag','btnarRemoveFile'),'Enable', 'On');
        set(findobj('Tag','btnarAverage'),'Visible', 'Off');
        set(findobj('Tag','btnNoiseEstimation'),'Visible', 'Off');
        set(findobj('Tag','btnInvertedAverage'),'Visible', 'Off');
        set(findobj('Tag','btnMeanSquare'),'Visible', 'Off');
        set(findobj('Tag','btnRootMeanSquare'),'Visible', 'Off');
        set(findobj('Tag','chkboxarIm'),'Enable', 'On');
        set(findobj('Tag','chkboxarVm'),'Enable', 'On');
        set(findobj('Tag','chkboxarStimulus'),'Enable', 'On');
        set(findobj('Tag','chkboxarVj'),'Enable', 'On');
        set(findobj('Tag','chkboxarVavg'),'Enable', 'On');
    else %if the directory selection dialog is cancelled
        
        msgbox('Please Select a Directory for Analysis', 'Directory Not Selected','Error');
    end



    
function rearrangeData(fileList, path, checkedColumns)
    %%
        
    
    h=waitbar(0,'Please wait... Rearranging Data Columns and Saving...');
    
%     fet_time = [];

%     fet_data=[];
    
%     t=0;    
%     m=0;

    columns = length(checkedColumns);
    
    oldPath = pwd;  
    cd(path);
    
    for i = 1 : length(fileList)
        filePath = strcat(path,fileList{i});

        loaded_file = load (filePath); % load the file into loaded_file from the filename provided as an array of strings
               
        [m,n]=size(loaded_file);
        
%         dataPoints=length(loaded_file);
        
        if(n>m)
            msgbox('Consider Transposing Your Data File',['Data File Format Error in ',filePath],'Error');
        else
%             combinedFile=[];
            time_fet = loaded_file(:,1);
            t=time_fet(2)-time_fet(1);
            if(t>=0.05)
                time_fet=(0:t:t*length(time_fet)-t)'*0.001;%#ok
            else
                time_fet=(0:t:t*length(time_fet)-t)';%#ok
            end

            k=2;
            for j = 1:1:columns-1

                    tempData = loaded_file(:,checkedColumns(k));
                    data_fet(:,j) = tempData; %#ok

                    k=k+1;                 
            end
            
            combinedFile = [time_fet, data_fet];%#ok
            newFileName = strcat('Rearranged-',fileList{i});
            save(newFileName, 'combinedFile', '-ASCII', '-tabs');
                
            waitbar(i/length(fileList));
        end
    end
    
    cd(oldPath);

    close(h);
    



% --- Executes on button press in btnarMoveUp.
function btnarMoveUp_Callback(hObject, eventdata, handles)
    %%
% hObject    handle to btnarMoveUp (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

    fh = findobj('Tag', 'lstboxarContent');
    listbox_contents = get(fh, 'String');
    selected_index = get(fh, 'Value');    
    
    if (~isempty(listbox_contents) && (selected_index > 1)&&(selected_index <= length(listbox_contents)))
        index = get(fh,'Value');
        tempFile=listbox_contents{index};
        listbox_contents{index}=listbox_contents{index-1};
        listbox_contents{index-1}=tempFile;
        set(fh, 'String', listbox_contents, ... 
            'Value', min(index,length(listbox_contents))); 
        setappdata(findobj('Tag','figArtifactRemoval'),'fileNames',listbox_contents);
        set(fh,'Value',index-1)
    end

    if(selected_index == 1)
        set(findobj('Tag','btnarMoveUp'),'Enable', 'Off');
        set(findobj('Tag','btnarMoveDown'),'Enable', 'On');        
    else
        set(findobj('Tag','btnarMoveUp'),'Enable', 'On');        
    end    

    if(selected_index == length(listbox_contents))
        set(findobj('Tag','btnarMoveDown'),'Enable', 'Off');
        set(findobj('Tag','btnarMoveUp'),'Enable', 'On');
    else
        set(findobj('Tag','btnarMoveDown'),'Enable', 'On');        
    end

    fh_relate=findobj('Tag','chkboxarRelate');
    
    if(get(fh_relate,'Value')==get(fh_relate,'Max')) % if the relate check box is checked
        fh_bl = findobj('Tag', 'lstboxarblContent');
        listbox_contents_bl = get(fh_bl, 'String');
        selected_index_bl = selected_index;

        if (~isempty(listbox_contents_bl) && (selected_index_bl > 1)&&(selected_index_bl <= length(listbox_contents_bl)))
            index = get(fh_bl,'Value');
            tempFile=listbox_contents_bl{index};
            listbox_contents_bl{index}=listbox_contents_bl{index-1};
            listbox_contents_bl{index-1}=tempFile;
            set(fh_bl, 'String', listbox_contents_bl, ... 
                'Value', min(index,length(listbox_contents_bl))); 
            setappdata(findobj('Tag','figArtifactRemoval'),'fileNamesBaseline',listbox_contents_bl);
            set(fh_bl,'Value',index-1)
        end

        if(selected_index_bl == 1)
            set(findobj('Tag','btnarMoveUp'),'Enable', 'Off');
            set(findobj('Tag','btnarMoveDown'),'Enable', 'On');        
        else
            set(findobj('Tag','btnarMoveUp'),'Enable', 'On');        
        end    

        if(selected_index_bl == length(listbox_contents_bl))
            set(findobj('Tag','btnarMoveDown'),'Enable', 'Off');
            set(findobj('Tag','btnarMoveUp'),'Enable', 'On');
        else
            set(findobj('Tag','btnarMoveDown'),'Enable', 'On');        
        end        
    end

% --- Executes on button press in btnarMoveDown.
function btnarMoveDown_Callback(hObject, eventdata, handles)
    %%
% hObject    handle to btnarMoveDown (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

    fh = findobj('Tag', 'lstboxarContent');    
    listbox_contents = get(fh, 'String');
    selected_index = get(fh, 'Value');
    

    if (~isempty(listbox_contents) && (selected_index >= 1)&&(selected_index < length(listbox_contents)))
        index = get(fh,'Value');
        tempFile=listbox_contents{index};
        listbox_contents{index}=listbox_contents{index+1};
        listbox_contents{index+1}=tempFile;
        set(fh, 'String', listbox_contents, ... 
            'Value', min(index,length(listbox_contents))); 
        setappdata(findobj('Tag','figArtifactRemoval'),'fileNames',listbox_contents);
        set(fh,'Value',index+1)        
    end     

    if(selected_index == 1)
        set(findobj('Tag','btnarMoveUp'),'Enable', 'Off');
        set(findobj('Tag','btnarMoveDown'),'Enable', 'On');        
    else
        set(findobj('Tag','btnarMoveUp'),'Enable', 'On');        
    end    

    if(selected_index == length(listbox_contents))
        set(findobj('Tag','btnarMoveDown'),'Enable', 'Off');
        set(findobj('Tag','btnarMoveUp'),'Enable', 'On');
    else
        set(findobj('Tag','btnarMoveDown'),'Enable', 'On');        
    end
    
    fh_relate=findobj('Tag','chkboxarRelate');
    
    if(get(fh_relate,'Value')==get(fh_relate,'Max')) % if the relate check box is checked
        fh_bl = findobj('Tag', 'lstboxarblContent');
        listbox_contents_bl = get(fh_bl, 'String');
        selected_index_bl = selected_index;

        if (~isempty(listbox_contents_bl) && (selected_index_bl >= 1)&&(selected_index_bl < length(listbox_contents_bl)))
            index = get(fh_bl,'Value');
            tempFile=listbox_contents_bl{index};
            listbox_contents_bl{index}=listbox_contents_bl{index+1};
            listbox_contents_bl{index+1}=tempFile;
            set(fh_bl, 'String', listbox_contents_bl, ... 
                'Value', min(index,length(listbox_contents_bl))); 
            setappdata(findobj('Tag','figArtifactRemoval'),'fileNamesBaseline',listbox_contents_bl);
            set(fh_bl,'Value',index+1)
        end

        if(selected_index_bl == 1)
            set(findobj('Tag','btnarMoveUp'),'Enable', 'Off');
            set(findobj('Tag','btnarMoveDown'),'Enable', 'On');        
        else
            set(findobj('Tag','btnarMoveUp'),'Enable', 'On');        
        end    

        if(selected_index_bl == length(listbox_contents_bl))
            set(findobj('Tag','btnarMoveDown'),'Enable', 'Off');
            set(findobj('Tag','btnarMoveUp'),'Enable', 'On');
        else
            set(findobj('Tag','btnarMoveDown'),'Enable', 'On');        
        end        
    end    
    
% --- Executes on button press in btnPlot3D.
function btnPlot3D_Callback(hObject, eventdata, handles)
    %%
% hObject    handle to btnPlot3D (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%     set(findobj('Tag','btnarMoveUp'),'Enable', 'Off');
%     set(findobj('Tag','btnarMoveDown'),'Enable', 'Off');

    [checkedColumns, flag]=selectedColumns();
    if(flag && length(checkedColumns)==2)
        fh = findobj('Tag','figArtifactRemoval');        
        fileList = getappdata(fh,'fileNames');
        directoryPath = getappdata(fh,'directoryPath');
        threeDPlot(directoryPath, fileList,checkedColumns);
    else%if(length(checkedColumns)>2)
        errordlg('To View 3D Mapping, Please Select Only One Channel at a Time');     
    end



% --------------------------------------------------------------------
function baselineCorrectorMenu_Callback(hObject, eventdata, handles)
    %%
% hObject    handle to baselineCorrectorMenu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

    run baselineCorrector;


%--------------------------------------------------------------------
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
       set(findobj('Tag','lstboxarContent'),'String',fileList,...
            'Value',1);
       set(findobj('Tag','lblarPath'),'String',pathName);
       setappdata(findobj('Tag','figArtifactRemoval'),'directoryPath',pathName);
       set(findobj('Tag','btnarLoad'),'Enable','On');
    end




% --------------------------------------------------------------------
function artifactRemoval_Callback(hObject, eventdata, handles)
    %%
% hObject    handle to artifactRemoval (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on selection change in lstboxarblContent.
function lstboxarblContent_Callback(hObject, eventdata, handles)
    %%
  
% hObject    handle to lstboxarblContent (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = get(hObject,'String') returns lstboxarblContent contents as cell array
%        contents{get(hObject,'Value')} returns selected item from lstboxarblContent

    listbox_contents = get(findobj('Tag', 'lstboxarblContent'), 'String');
    selected_index = get(findobj('Tag', 'lstboxarblContent'), 'Value');
    fh = findobj('Tag','figArtifactRemoval');
    
    if(selected_index == 1)
        set(findobj('Tag','btnarMoveUp'),'Enable', 'Off');
        set(findobj('Tag','btnarMoveDown'),'Enable', 'On');        
    else
        set(findobj('Tag','btnarMoveUp'),'Enable', 'On');        
    end    

    if(selected_index == length(listbox_contents))
        set(findobj('Tag','btnarMoveDown'),'Enable', 'Off');
        set(findobj('Tag','btnarMoveUp'),'Enable', 'On');
    else
        set(findobj('Tag','btnarMoveDown'),'Enable', 'On');        
    end
    
    [checkedColumns, flag] = selectedColumns();
%     checkedColumns = getappdata(fh, 'checkedColumns');
    
    if(flag)       
        filePath = getappdata(fh, 'directoryPathBaseline');
        [fet_time, fet_data] = readData(filePath, listbox_contents{selected_index}, checkedColumns);
        color = {'r','g','b','c','m','y','k'};        
        cla(findobj('Tag','axarMain'));
%         axes(findobj('Tag','axarMain'));
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

% --- Executes during object creation, after setting all properties.
function lstboxarblContent_CreateFcn(hObject, eventdata, handles)
    %%
% hObject    handle to lstboxarblContent (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end




% --- Executes on button press in btnarRemoveBaselineFiles.
function btnarRemoveBaselineFiles_Callback(hObject, eventdata, handles)
    %%
% hObject    handle to btnarRemoveBaselineFiles (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

    fh=findobj('Tag','lstboxarblContent');
    selected = get(fh,'Value'); 
    prev_str = get(fh, 'String'); 
    if ~isempty(prev_str) 
        prev_str(get(fh,'Value')) = []; 
        set(fh, 'String', prev_str, ... 
            'Value', min(selected,length(prev_str))); 
        setappdata(findobj('Tag','figArtifactRemoval'),'fileNamesBaseline',prev_str);
    end



% --- Executes on button press in btnRemoveArtifact.
function btnRemoveArtifact_Callback(hObject, eventdata, handles)
    %%
% hObject    handle to btnRemoveArtifact (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

    [checkedColumns, flagColumns]=selectedColumns();        
    
    if(flagColumns)
        if(get(findobj('Tag','radiobtnarSingle'),'Value')==0) %if the multiple sweep averaging based removal is selected
            selected=questdlg('Do You Want to Perform Baseline Correction?','Baseline Correction Confirmation','Yes','No','Yes');

            fh=findobj('Tag','figArtifactRemoval');

            baselinePath = getappdata(fh,'directoryPathBaseline');
            signalPath = getappdata(fh,'directoryPath');

            flag = 0;

            switch lower(selected)
                case 'yes'
                    flag=1;
                    fullData=load([baselinePath,'AveragedData.txt']);
                    data=fullData(:,2);
                    time=fullData(:,1);
                    threshold=std(data)*0.7;
                    [mintab, maxtab]=peakdet(data,threshold,time);

                    extPeak=extendPeaks(mintab(:,2),mintab(:,1),time);
                    extVally=extendPeaks(maxtab(:,2),maxtab(:,1),time);
                    for i=1:length(time)
                        avg(i)=(extPeak(i)+extVally(i))/2; 
                    end
                    peakAvg=sum(avg)/length(avg);
                    dataAvg=data - peakAvg;

                    figure('Name','SigMate: Baseline Corrected Signal (Control)','NumberTitle','off');        
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

                    oldPath=pwd;
                    cd(baselinePath);
                    datafile=[]; %#ok
                    dataFile = [time, dataAvg]; %#ok
                    fileName = 'bc-AveragedData.txt';
                    save(fileName, 'dataFile','-ASCII','-tabs');    
                    cd(oldPath);

                    fullData=load([signalPath,'AveragedData.txt']);
                    data=fullData(:,2);
                    time=fullData(:,1);
                    threshold=std(data)*0.7;
                    [mintab, maxtab]=peakdet(data,threshold,time);

                    extPeak=extendPeaks(mintab(:,2),mintab(:,1),time);
                    extVally=extendPeaks(maxtab(:,2),maxtab(:,1),time);
                    for i=1:length(time)
                        avg(i)=(extPeak(i)+extVally(i))/2; 
                    end
                    peakAvg=sum(avg)/length(avg);
                    dataAvg=data - peakAvg;

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

                    oldPath=pwd;
                    cd(signalPath);
                    datafile=[]; %#ok
                    dataFile = [time, dataAvg]; %#ok
                    fileName = 'bc-AveragedData.txt';
                    save(fileName, 'dataFile','-ASCII','-tabs');    
                    cd(oldPath);            
                case 'no'
                    msg=['You Have Selected Not to Perform Baseline Correction! ',...
                        'Now It is Assumed that the Baseline Corrected Data Already ',...
                        'Exist in the Same Directory with a Filename bc-AveragedData.txt, '...
                        'Do You Wish to Continue with the Artifact Removal?'];
                    choice=questdlg(msg,'Baseline Not Corrected','Yes','No');
                    if isequal(choice,'Yes')
                        flag=1;                
                    end
            end

            if(flag)
                removeArtifact('bc-AveragedData.txt', 'bc-AveragedData.txt', signalPath, baselinePath, checkedColumns);
            else
                errordlg('Artifact Removal was Aborted by User.','Operation Aborted');
            end

        else % if the single file based correction is selected

            %perform baseline correction
            fh=findobj('Tag','figArtifactRemoval');

            baselinePath = getappdata(fh,'directoryPathBaseline');
            signalPath = getappdata(fh,'directoryPath');

            fh_contents=findobj('Tag','lstboxarContent');
            filesSignal = get(fh_contents, 'String');

            fh_contentsBaseline=findobj('Tag','lstboxarContent');        
            filesArtifact = get(fh_contentsBaseline,'String');

            selected_index=get(fh_contents,'Value');

            fileNameSignal=filesSignal{selected_index};
            fileNameArtifact=filesArtifact{selected_index};

            if (length(checkedColumns)==2)
                fullData=load([baselinePath,fileNameArtifact]);            
                data=fullData(:,checkedColumns(2));
                time=fullData(:,1);
                threshold=std(data)*0.7;
                [mintab, maxtab]=peakdet(data,threshold,time);

                extPeak=extendPeaks(mintab(:,2),mintab(:,1),time);
                extVally=extendPeaks(maxtab(:,2),maxtab(:,1),time);
                for i=1:length(time)
                    avg(i)=(extPeak(i)+extVally(i))/2; 
                end
                peakAvg=sum(avg)/length(avg);
                dataAvg=data - peakAvg;

                figure('Name','SigMate: Baseline Corrected Signal (Control)','NumberTitle','off');        
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

%                 oldPath=pwd;
%                 cd(baselinePath);
%                 datafile=[]; %#ok
%                 dataFile = [time, dataAvg]; %#ok
%                 fileName = 'bc-AveragedData.txt';
%                 save(fileName, 'dataFile','-ASCII','-tabs');    
%                 cd(oldPath);

                oldPath=pwd;
                cd(baselinePath);
                datafile=[]; %#ok
                dataFile = [time, dataAvg]; %#ok                
                fileNameS = ['bc-',fileNameSignal];
                save(fileNameS, 'dataFile','-ASCII','-tabs');    
                cd(oldPath);

                fullData=load([signalPath,fileNameSignal]);
                data=fullData(:,checkedColumns(2));
                time=fullData(:,1);
                threshold=std(data)*0.7;
                [mintab, maxtab]=peakdet(data,threshold,time);

                extPeak=extendPeaks(mintab(:,2),mintab(:,1),time);
                extVally=extendPeaks(maxtab(:,2),maxtab(:,1),time);
                for i=1:length(time)
                    avg(i)=(extPeak(i)+extVally(i))/2; 
                end
                peakAvg=sum(avg)/length(avg);
                dataAvg=data - peakAvg;

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



                oldPath=pwd;
                cd(signalPath);
                datafile=[]; %#ok
                dataFile = [time, dataAvg]; %#ok
                fileNameA = ['bc-',fileNameArtifact];
                save(fileNameA, 'dataFile','-ASCII','-tabs');    
                cd(oldPath);
                
                removeArtifact(fileNameS, fileNameA, signalPath, baselinePath, checkedColumns);

            elseif(length(checkedColumns)>2)
                fullDataArti=load([baselinePath,fileNameArtifact]);
                fullData=load([signalPath,fileNameSignal]);            
                combinedFile=fullData(:,1);
                combinedFile_bl=fullDataArti(:,1);
                for j=2:length(checkedColumns)
                    data=fullDataArti(:,j);
                    time=fullDataArti(:,1);

                    threshold=std(data)*0.7;
                    [mintab, maxtab]=peakdet(data,threshold,time);

                    extPeak=extendPeaks(mintab(:,2),mintab(:,1),time);
                    extVally=extendPeaks(maxtab(:,2),maxtab(:,1),time);
                    for i=1:length(time)
                        avg(i)=(extPeak(i)+extVally(i))/2; 
                    end
                    peakAvg=sum(avg)/length(avg);
                    dataAvg=data - peakAvg;

                    figure('Name','SigMate: Baseline Corrected Signal (Control)','NumberTitle','off');        
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

                    combinedFile_bl=[combinedFile_bl,dataAvg];

                    data=fullData(:,j);
                    time=fullData(:,1);
                    threshold=std(data)*0.7;
                    [mintab, maxtab]=peakdet(data,threshold,time);

                    extPeak=extendPeaks(mintab(:,2),mintab(:,1),time);
                    extVally=extendPeaks(maxtab(:,2),maxtab(:,1),time);
                    for i=1:length(time)
                        avg(i)=(extPeak(i)+extVally(i))/2; 
                    end
                    peakAvg=sum(avg)/length(avg);
                    dataAvg=data - peakAvg;

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

                    combinedFile=[combinedFile,dataAvg];              
                end
                oldPath=pwd;
                cd(baselinePath);
                fileNameS = ['bc-',fileNameSignal];
                save(fileNameS, 'combinedFile_bl','-ASCII','-tabs');    
                cd(oldPath);

                oldPath=pwd;
                cd(signalPath);
                datafile=[]; %#ok
                dataFile = [time, dataAvg]; %#ok
                fileNameA = ['bc-',fileNameArtifact];
                save(fileNameA, 'dataFile','-ASCII','-tabs');    
                cd(oldPath);
                
                removeArtifact(fileNameS, fileNameA, signalPath, baselinePath, checkedColumns);
            end     
        end
    end

% --- Executes on button press in radiobtnarSingle.
function radiobtnarSingle_Callback(hObject, eventdata, handles)
    %%
% hObject    handle to radiobtnarSingle (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of radiobtnarSingle

    fh = findobj('Tag','radiobtnarMultiple');
    
    if(get(fh,'Value') == 1 && get(findobj('Tag','radiobtnarSingle'),'Value') == 0)
        set(findobj('Tag','radiobtnarMultiple'),'Value',0);
        set(findobj('Tag','radiobtnarSingle'),'Value',1);
    else
        set(findobj('Tag','radiobtnarSingle'),'Value',1);  
        set(findobj('Tag','radiobtnarMultiple'),'Value',0);        
    end
       
    guidata(fh,handles);
    
%     set(findobj('Tag','btnRemoveArtifact'),'Enable', 'On');
    if (strcmpi(get(findobj('Tag','btnarAverage'),'Enable'),'On'))
        set(findobj('Tag','btnarAverage'),'Enable', 'Off');
    end
    
    set(findobj('Tag','chkboxarRelate'),'Value',1);
    
    file_names=getappdata(findobj('Tag','figArtifactRemoval'),'fileNames');
    file_namesbl=getappdata(findobj('Tag','figArtifactRemoval'),'fileNamesBaseline');
    
    if (length(file_names)~=length(file_namesbl))
        errorString='There is not a one-to-one correspondence between the recording and baseline files. Can not continue with the Artifact Removal';
        errordlg(errorString,'One-to-One Correspondence Error');
        set(findobj('Tag','btnRemoveArtifact'),'Enable','Off');
    end
    
    
    set(findobj('Tag','btnarAverage'),'Enable', 'Off');
    set(findobj('Tag','btnNoiseEstimation'),'Enable', 'Off');    
    set(findobj('Tag','btnInvertedAverage'),'Enable', 'Off');    
    set(findobj('Tag','btnMeanSquare'),'Enable', 'Off');   
    set(findobj('Tag','btnRootMeanSquare'),'Enable', 'Off');     

    set(findobj('Tag','btnRemoveArtifact'),'Enable','On');    
    

% --- Executes on button press in radiobtnarMultiple.
function radiobtnarMultiple_Callback(hObject, eventdata, handles)
    %%
% hObject    handle to radiobtnarMultiple (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of radiobtnarMultiple


    fh = findobj('Tag','radiobtnarSingle');
    
    if(get(fh,'Value')==1 && get(findobj('Tag','radiobtnarMultiple'),'Value')==0)
        set(fh,'Value',0);
        set(findobj('Tag','radiobtnarMultiple'),'Value',1);
    else
        set(findobj('Tag','radiobtnarMultiple'),'Value',1);        
        set(fh,'Value',0);        
    end

    guidata(fh,handles);
    
    set(findobj('Tag','btnarAverage'),'Enable', 'On');
    if (strcmpi(get(findobj('Tag','btnRemoveArtifact'),'Enable'),'On'))
        set(findobj('Tag','btnRemoveArtifact'),'Enable', 'Off');
    end
    
    if(get(findobj('Tag','chkboxarRelate'),'Value')==1)
        set(findobj('Tag','chkboxarRelate'),'Value',0);        
    end

    set(findobj('Tag','btnarAverage'),'Enable', 'On');
    set(findobj('Tag','btnNoiseEstimation'),'Enable', 'On');    
    set(findobj('Tag','btnInvertedAverage'),'Enable', 'On');    
    set(findobj('Tag','btnMeanSquare'),'Enable', 'On');   
    set(findobj('Tag','btnRootMeanSquare'),'Enable', 'On'); 
    
    set(findobj('Tag','btnRemoveArtifact'),'Enable','Off');
    
% --- Executes on button press in chkboxarRelate.


function chkboxarRelate_Callback(hObject, eventdata, handles)
    %%
% hObject    handle to chkboxarRelate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of chkboxarRelate



% --- Executes on button press in tbarZoom.
function tbarZoom_Callback(hObject, eventdata, handles)
%%
% hObject    handle to tbarZoom (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of tbarZoom


    button_state = get(hObject,'Value');
    if button_state == get(hObject,'Max')
	% Toggle button is pressed, take appropriate action
        zoom on;
        fh = findobj('Tag','tbarDataCursor');
        if (get(fh, 'Value')== get(fh,'Max'))
            set(fh,'Value',0);
        end
        fh = findobj('Tag','tbarPan');
        if (get(fh, 'Value')== get(fh,'Max'))
            set(fh,'Value',0);
        end         
        
    elseif button_state == get(hObject,'Min')
	% Toggle button is not pressed, take appropriate action
        zoom off;
    end

% --- Executes on button press in tbarDataCursor.
function tbarDataCursor_Callback(hObject, eventdata, handles)
%%
% hObject    handle to tbarDataCursor (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of tbarDataCursor


    button_state = get(hObject,'Value');
    if button_state == get(hObject,'Max')
	% Toggle button is pressed, take appropriate action
        datacursormode on;
        dcm_obj=datacursormode(findobj('Tag','figArtifactRemoval'));
        set(dcm_obj,'UpdateFcn',@myarupdatefcn);
        
        fh = findobj('Tag','tbarZoom');
        if (get(fh, 'Value')== get(fh,'Max'))
            set(fh,'Value',0);
        end
        fh = findobj('Tag','tbarPan');
        if (get(fh, 'Value')== get(fh,'Max'))
            set(fh,'Value',0);
        end         
    elseif button_state == get(hObject,'Min')
	% Toggle button is not pressed, take appropriate action
        datacursormode off;
    end
    
    
function txt = myarupdatefcn(empt,event_obj)
%%
%This function is for updating the data cursor text
    pos = get(event_obj,'Position');
    txt = {['Time: ',num2str(pos(1)),' ms'],...
        ['Amplitude: ',num2str(pos(2))],' mV'};    

% --- Executes on button press in btnarResetGraph.
function btnarResetGraph_Callback(hObject, eventdata, handles)
%%
% hObject    handle to btnarResetGraph (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

    fh = findobj('Tag','tbarZoom');
    if (get(fh, 'Value')== get(fh,'Max'))
        set(fh,'Value',0);
    end
    
    fh = findobj('Tag','tbarDataCursor');
    if (get(fh, 'Value')== get(fh,'Max'))
        set(fh,'Value',0);
    end    
    
    fh = findobj('Tag','tbarPan');
    if (get(fh, 'Value')== get(fh,'Max'))
        set(fh,'Value',0);
    end     
    
    datacursormode off;
    
    zoom off;
    
    pan off;
    
    axis('tight');


% --- Executes on button press in tbarPan.
function tbarPan_Callback(hObject, eventdata, handles)
% hObject    handle to tbarPan (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of tbarPan

    button_state = get(hObject,'Value');
    if button_state == get(hObject,'Max')
	% Toggle button is pressed, take appropriate action
        pan on;

        
        fh = findobj('Tag','tbarZoom');
        if (get(fh, 'Value')== get(fh,'Max'))
            set(fh,'Value',0);
        end
        fh = findobj('Tag','tbarDataCursor');
        if (get(fh, 'Value')== get(fh,'Max'))
            set(fh,'Value',0);
        end        
    elseif button_state == get(hObject,'Min')
	% Toggle button is not pressed, take appropriate action
        pan off;
    end


% --- Executes during object creation, after setting all properties.
function axsarSigMate_CreateFcn(hObject, eventdata, handles)
% hObject    handle to axsarSigMate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: place code in OpeningFcn to populate axsarSigMate
    axes(hObject)
    pathLogo = which('SigMate-Logo');
    imshow([pathLogo '\' 'SigMate-Logo.gif'])