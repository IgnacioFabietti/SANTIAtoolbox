function varargout = csdAnalyzer(varargin)
% CSDANALYZER M-file for csdAnalyzer.fig
%      CSDANALYZER, by itself, creates a new CSDANALYZER or raises the existing
%      singleton*.
%
%      H = CSDANALYZER returns the handle to a new CSDANALYZER or the handle to
%      the existing singleton*.
%
%      CSDANALYZER('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in CSDANALYZER.M with the given input arguments.
%
%      CSDANALYZER('Property','Value',...) creates a new CSDANALYZER or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before FirstGUI_OpeningFunction gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to csdAnalyzer_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help csdAnalyzer

% Last Modified by GUIDE v2.5 15-May-2012 16:19:39

% Begin initialization code - DO NOT EDIT


gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @csdAnalyzer_OpeningFcn, ...
                   'gui_OutputFcn',  @csdAnalyzer_OutputFcn, ...
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

% --- Executes just before csdAnalyzer is made visible.
function csdAnalyzer_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to csdAnalyzer (see VARARGIN)

% Choose default command line output for csdAnalyzer
handles.output = hObject;

pathToAdd = which('csdAnalyzer');
pathToAdd = [pathToAdd(1:end-(length('csdAnalyzer.m')+1)) '\singleSweeps' ];

addpath(pathToAdd);

fh = findobj('Tag', 'figcsdMain');
setappdata(fh, 'addedPath',pathToAdd);

set(handles.figcsdMain, 'CloseRequestFcn', 'closeGUI');

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes csdAnalyzer wait for user response (see UIRESUME)
% uiwait(handles.figcsdMain);

%%

% --- Outputs from this function are returned to the command line.
function varargout = csdAnalyzer_OutputFcn(hObject, eventdata, handles) 
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

    fh = findobj('Tag', 'figcsdMain');
    fullPath=getappdata(fh, 'addedPath');
    
    closeGUI(); % Call the function from the CloseGUI.m file
    
    rmpath(fullPath)    

%%


% --- Executes on button press in btncsdBrowse.
function btncsdBrowse_Callback(hObject, eventdata, handles)
% hObject    handle to btncsdBrowse (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
    
%     global filelist, filenames
    
    %clear if any application data exists
    
    fh = findobj('Tag', 'figcsdMain');    
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
        handle_lblcsdPath = findobj('Tag', 'lblcsdPath'); % find the object with the Tag lblcsdPath and store the reference handle

        if (handle_lblcsdPath ~= 0) % if the above searched object found
            text = get(handle_lblcsdPath,'String');  % get the text of the object
            if(~(strcmp(text,'Selected Directory Path')))
                text = 'Selected Directory Path';
            end
            newtext = strcat(text, ': ', path); % append the folder path to the content
            set(handle_lblcsdPath,'String',newtext); % set the new text to the control
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
        set(findobj('Tag','lstboxcsdContent'),'String',handles.file_names,...
            'Value',1);
        set(findobj('Tag','btncsdLoad'),'Enable', 'On');
        set(findobj('Tag','btncsdLoad'),'String', 'Load Data Files');        
        set(findobj('Tag','btncsdRemoveFile'),'Enable', 'On');
        set(findobj('Tag','btncsdMoveUp'),'Enable', 'On');
        set(findobj('Tag','btncsdMoveDown'),'Enable', 'On');        
        set(findobj('Tag','channel1'),'Enable', 'On');
        set(findobj('Tag','channel2'),'Enable', 'On');
        set(findobj('Tag','channel3'),'Enable', 'On');
        set(findobj('Tag','channel4'),'Enable', 'On');
        set(findobj('Tag','channel5'),'Enable', 'On');
        if(strcmpi(get(findobj('Tag','btncsdCalculate'),'Enable'),'On'))
            set(findobj('Tag','btncsdCalculate'),'Enable', 'Off');
        end
        set(findobj('Tag','rbcsdStandard'),'Value', 1);
        set(findobj('Tag','rbcsdDeltaInverse'),'Value', 0);
        set(findobj('Tag','rbcsdStepInverse'),'Value', 0);
        set(findobj('Tag','rbcsdSplineInverse'),'Value', 0); 
        
        selectedCSDMethod=1;
        setappdata(fh,'selectedCSDMethod',selectedCSDMethod);
              
    else %if the directory selection dialog is cancelled
        
        msgbox('Please Select a Directory for Analysis', 'Directory Not Selected','Error');
    end

    listbox_contents = get(findobj('Tag', 'lstboxcsdContent'), 'String');
    selected_index = get(findobj('Tag', 'lstboxcsdContent'), 'Value');    
    if(selected_index == 1)
        set(findobj('Tag','btncsdMoveUp'),'Enable', 'Off');
    elseif(selected_index == length(listbox_contents))
        set(findobj('Tag','btncsdMoveDown'),'Enable', 'Off');        
    end


%%
% --- Executes on selection change in lstboxcsdContent.
function lstboxcsdContent_Callback(hObject, eventdata, handles)
% hObject    handle to lstboxcsdContent (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = get(hObject,'String') returns lstboxcsdContent contents as cell array
%        contents{get(hObject,'Value')} returns selected item from lstboxcsdContent

    listbox_contents = get(findobj('Tag', 'lstboxcsdContent'), 'String');
    selected_index = get(findobj('Tag', 'lstboxcsdContent'), 'Value');
    fh = findobj('Tag','figcsdMain');
    
    directoryPath=getappdata(fh,'directoryPath');
    
    [checkedColumns, flag] = selectedColumns();   
    
    if(selected_index == 1)
        set(findobj('Tag','btncsdMoveUp'),'Enable', 'Off');
        set(findobj('Tag','btncsdMoveDown'),'Enable', 'On');
        errordlg('The CSD analysis can''t be performed for the first recording site','File Selection Error');
        flag=0;
    else
        set(findobj('Tag','btncsdMoveUp'),'Enable', 'On');        
    end    

    if(selected_index == length(listbox_contents))
        set(findobj('Tag','btncsdMoveDown'),'Enable', 'Off');
        set(findobj('Tag','btncsdMoveUp'),'Enable', 'On');
        errordlg('The CSD analysis can''t be performed for the last recording site','File Selection Error');        
        flag=0;
    else
        set(findobj('Tag','btncsdMoveDown'),'Enable', 'On');        
    end
    

    
    if(flag)       
%         filePath = getappdata(fh, 'directoryPath');
%         [fet_time, fet_data] = readData(filePath, listbox_contents{selected_index}, checkedColumns);
%         color = {'r','g','b','c','m','y','k'};        
%         cla(findobj('Tag','axcsdMain'));
%         columns = length(checkedColumns);
%         hold on
%         for i=1:1:columns-1
%             plot(fet_time, fet_data(:,i),color{i});
%             title(['Plot of Selected Column: ',num2str(i)]);
%         end
%         axis('tight');
%         hold off

        fileNames{1}=listbox_contents{selected_index-1};
        fileNames{2}=listbox_contents{selected_index};
        fileNames{3}=listbox_contents{selected_index+1};
        
        selectedCSDMethod=getappdata(fh,'selectedCSDMethod');
        
        fhDepth = findobj('Tag','txtcsdInitialDepth'); 
        initialDepth=str2double(get(fhDepth,'String'));

        fhDepth = findobj('Tag','txtcsdRecordingPitch');    
        recordingPitch=str2double(get(fhDepth,'String'));

        endingDepth=initialDepth+(recordingPitch*length(listbox_contents)-1);
        recordingDepths=(initialDepth:recordingPitch:endingDepth)';
        selectedDepths=recordingDepths(selected_index-1:selected_index+1);

        sigma = str2double(get(findobj('Tag','txtcsdSigma'),'String'));

        sourceDiameter=str2double(get(findobj('Tag','txtcsdSourceDiameter'),'String'));   
        
        fhStimOnset = findobj('Tag','txtcsdStimOnset');    
        stimOnset=str2double(get(fhStimOnset,'String'));  
        
        switch selectedCSDMethod
            case 1 % the standard CSD Method
                [sigmaReturned, csdValues, lfp, t]=standardCSDSS (directoryPath, fileNames, selectedDepths, sigma, checkedColumns, stimOnset);
                if isnan(sigma)
                    set(findobj('Tag','txtcsdSigma'),'String',sigmaReturned);
                end
                normalizeAndPlot(lfp,csdValues,t);
            case 2 % the delta inverse CSD Method
                [sigmaReturned, sourceDiameterReturned, csdValues, lfp, t]=deltaInverseCSDSS (directoryPath, fileNames, selectedDepths, sigma, sourceDiameter, checkedColumns, stimOnset);
                if isnan(sigma)
                    set(findobj('Tag','txtcsdSigma'),'String',sigmaReturned);
                end
                if isnan(sourceDiameter)
                    set(findobj('Tag','txtcsdSourceDiameter'),'String',sourceDiameterReturned);
                end
                normalizeAndPlot(lfp,csdValues,t);
            case 3 % the step inverse CSD Method
                [sigmaReturned, sourceDiameterReturned, csdValues, lfp, t]=stepInverseCSDSS (directoryPath, fileNames, selectedDepths, sigma, sourceDiameter, checkedColumns);
                if isnan(sigma)
                    set(findobj('Tag','txtcsdSigma'),'String',sigmaReturned);
                end
                if isnan(sourceDiameter)
                    set(findobj('Tag','txtcsdSourceDiameter'),'String',sourceDiameterReturned);
                end
                normalizeAndPlot(lfp,csdValues,t);                
            case 4 % the spline inverse CSD Method
                [sigmaReturned, sourceDiameterReturned, csdValues, lfp, t]=splineInverseCSDSS (directoryPath, fileNames, selectedDepths, sigma, sourceDiameter, checkedColumns);
                if isnan(sigma)
                    set(findobj('Tag','txtcsdSigma'),'String',sigmaReturned);
                end
                if isnan(sourceDiameter)
                    set(findobj('Tag','txtcsdSourceDiameter'),'String',sourceDiameterReturned);
                end
                normalizeAndPlot(lfp,csdValues,t);                 
        end

    end


    function normalizeAndPlot(lfp, csdValues, t)
        fhAxis=findobj('Tag','axcsdMain');
        lfpAvg=abs(min(lfp));
        if abs(min(csdValues))>abs(max(csdValues))
            csdAvg=abs(min(csdValues));
        else
            csdAvg=abs(max(csdValues));
        end
        ratio=lfpAvg/csdAvg;
        normCSD=csdValues.*ratio;
        cla(fhAxis)
        plot(t, lfp, 'b', t, normCSD, 'r')
        legend(gca,'LFP [mv]',['CSD [uA/mm^3]/', num2str(1/ratio)])
%%

% --- Executes during object creation, after setting all properties.
function lstboxcsdContent_CreateFcn(hObject, eventdata, handles)
% hObject    handle to lstboxcsdContent (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



%%

% --- Executes on button press in btncsdCalculate.
function btncsdCalculate_Callback(hObject, eventdata, handles)
% hObject    handle to btncsdCalculate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

    fh = findobj('Tag', 'figcsdMain');
    
    directoryPath = getappdata(fh, 'directoryPath');
    fileNames = get(findobj('Tag','lstboxcsdContent'),'String');
    
    selectedCSDMethod=getappdata(fh,'selectedCSDMethod');
    
    [checkedColumns, flag] = selectedColumns();
    
    fhDepth = findobj('Tag','txtcsdInitialDepth'); 
    initialDepth=str2double(get(fhDepth,'String'));

    fhDepth = findobj('Tag','txtcsdRecordingPitch');    
    recordingPitch=str2double(get(fhDepth,'String'));
    
    fhStimOnset = findobj('Tag','txtcsdStimOnset');    
    stimOnset=str2double(get(fhStimOnset,'String'));    
    
    if isnan(initialDepth)
        errordlg('Please enter a valid entry to the Initial Depth text box (only numbers)', 'Initial Depth Entry Error');
    elseif isnan(recordingPitch)
        errordlg('Please enter a valid entry to the Recording Pitch text box (only numbers)', 'Recording Pitch Entry Error');        
    elseif isnan(stimOnset)
        errordlg('Please enter a valid entry to the Stimulus Onset text box (only numbers)', 'Stimulus Onset Entry Error');
    else   
        endingDepth=initialDepth+(recordingPitch*length(fileNames)-1);
        recordingDepths=(initialDepth:recordingPitch:endingDepth)';

        sigma = str2double(get(findobj('Tag','txtcsdSigma'),'String'));

        sourceDiameter=str2double(get(findobj('Tag','txtcsdSourceDiameter'),'String'));
        
        switch (selectedCSDMethod)
            case 1 % this is for the standard csd method
                [sigmaReturned, newDepth, csdValues, t]=standardCSD (directoryPath, fileNames, recordingDepths, sigma, checkedColumns);

                if isnan(sigma)
                    set(findobj('Tag','txtcsdSigma'),'String',sigmaReturned);
                end
                
                latMat = calculateLatenciesInCSD(newDepth, csdValues, stimOnset, t);
                layerActivationOrderByCSD(latMat);
                
            case 2 % this is for the delta inverse csd method
                [sigmaReturned, sourceDiameterReturned, newDepth, csdValues, t]=deltaInverseCSD(directoryPath, fileNames, recordingDepths, sigma, sourceDiameter, checkedColumns, stimOnset);
                
                toSave=[t'; csdValues'];
                
                tmpStr=strrep(datestr(clock),':','');
                tmpStr=strrep(tmpStr,'-','');
                tmpStr=strrep(tmpStr,' ','-');
                saveFileName=[tmpStr,'-','CSD-Results-with-Time-Column.txt'];
                
                save(saveFileName, 'toSave', '-ascii', '-tabs');
                
                if isnan(sigma)
                    set(findobj('Tag','txtcsdSigma'),'String',sigmaReturned);
                end
                if isnan(sourceDiameter)
                    set(findobj('Tag','txtcsdSourceDiameter'),'String',sourceDiameterReturned);
                end

                latMat = calculateLatenciesInCSD(newDepth, csdValues, stimOnset, t);
                layerActivationOrderByCSD(latMat);
%                 layerActivationOrder(latMat(:,2),latMat(:,1));
                data=[];
                currDir=pwd;
                cd(directoryPath);                
                save('latMatrix.xls','latMat', '-ascii', '-tabs');
                cd(currDir);
                
            case 3 % this is for the step inverse csd method
                [sigmaReturned, sourceDiameterReturned, newDepth, csdValues, t]=stepInverseCSD(directoryPath, fileNames, recordingDepths, sigma, sourceDiameter, checkedColumns);
                if isnan(sigma)
                    set(findobj('Tag','txtcsdSigma'),'String',sigmaReturned);
                end
                if isnan(sourceDiameter)
                    set(findobj('Tag','txtcsdSourceDiameter'),'String',sourceDiameterReturned);
                end
                
                latMat = calculateLatenciesInCSD(newDepth, csdValues, stimOnset, t);
                layerActivationOrderByCSD(latMat);
                
            case 4 % this is for the spline inverse csd method
                [sigmaReturned, sourceDiameterReturned, newDepth, csdValues, t]=splineInverseCSD(directoryPath, fileNames, recordingDepths, sigma, sourceDiameter, checkedColumns, stimOnset);
                if isnan(sigma)
                    set(findobj('Tag','txtcsdSigma'),'String',sigmaReturned);
                end
                if isnan(sourceDiameter)
                    set(findobj('Tag','txtcsdSourceDiameter'),'String',sourceDiameterReturned);
                end
                
                latMat = calculateLatenciesInCSD(newDepth, csdValues, stimOnset, t);
                layerActivationOrderByCSD(latMat);                
        end

%% this code is for performing the multiple analysis and should be deleted

%         folderNameFormat='DataSet%05d';
%         path='E:\In-Vivo Recordings\ClusteredLFPs-DataSets\';
%         figureNameFormat='Figure-%s.jpeg';
%         foldersToSelect=sort(randi([1 4532], 100, 1)); %(1:1:100);
%         for i=1:length(foldersToSelect)
%             folderName=sprintf(folderNameFormat, foldersToSelect(i));
%             directoryPath=[path folderName '\'];
%             
%             fileNames=getDirContents(directoryPath,'*.txt');
% 
%             switch (selectedCSDMethod)
%                 case 1 % this is for the standard csd method
%                     [sigmaReturned, newDepth, csdValues, t]=standardCSD (directoryPath, fileNames, recordingDepths, sigma, checkedColumns);
% 
%                     if isnan(sigma)
%                         set(findobj('Tag','txtcsdSigma'),'String',sigmaReturned);
%                     end
% 
%                     latMat = calculateLatenciesInCSD(newDepth, csdValues, stimOnset, t);
%                     layerActivationOrderByCSD(latMat);
% 
%                 case 2 % this is for the delta inverse csd method
%                     [sigmaReturned, sourceDiameterReturned, newDepth, csdValues, t]=deltaInverseCSD(directoryPath, fileNames, recordingDepths, sigma, sourceDiameter, checkedColumns, stimOnset);
%                     if isnan(sigma)
%                         set(findobj('Tag','txtcsdSigma'),'String',sigmaReturned);
%                     end
%                     if isnan(sourceDiameter)
%                         set(findobj('Tag','txtcsdSourceDiameter'),'String',sourceDiameterReturned);
%                     end
% 
%                     latMat = calculateLatenciesInCSD(newDepth, csdValues, stimOnset, t);
%                     layerActivationOrderByCSD(latMat);
%                     data=[];
%                     currDir=pwd;
%                     cd(directoryPath);                
%                     save('latMatrix.xls','latMat', '-ascii', '-tabs');
%                     cd('E:\In-Vivo Recordings\ClusteredLFPs-DataSets\aaFigures\')
%                     figureName=sprintf(figureNameFormat,folderName);
%                     print(gcf,'-djpeg',figureName);
%                     cd(currDir);
%                     close(gcf);
% 
%                 case 3 % this is for the step inverse csd method
%                     [sigmaReturned, sourceDiameterReturned, newDepth, csdValues, t]=stepInverseCSD(directoryPath, fileNames, recordingDepths, sigma, sourceDiameter, checkedColumns);
%                     if isnan(sigma)
%                         set(findobj('Tag','txtcsdSigma'),'String',sigmaReturned);
%                     end
%                     if isnan(sourceDiameter)
%                         set(findobj('Tag','txtcsdSourceDiameter'),'String',sourceDiameterReturned);
%                     end
% 
%                     latMat = calculateLatenciesInCSD(newDepth, csdValues, stimOnset, t);
%                     layerActivationOrderByCSD(latMat);
% 
%                 case 4 % this is for the spline inverse csd method
%                     [sigmaReturned, sourceDiameterReturned, newDepth, csdValues, t]=splineInverseCSD(directoryPath, fileNames, recordingDepths, sigma, sourceDiameter, checkedColumns, stimOnset);
%                     if isnan(sigma)
%                         set(findobj('Tag','txtcsdSigma'),'String',sigmaReturned);
%                     end
%                     if isnan(sourceDiameter)
%                         set(findobj('Tag','txtcsdSourceDiameter'),'String',sourceDiameterReturned);
%                     end
% 
%                     latMat = calculateLatenciesInCSD(newDepth, csdValues, stimOnset, t);
%                     layerActivationOrderByCSD(latMat);                
%             end
%         end

    end
    
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
                    title('Plot for channel1');
                    xlabel('Time (S)');
                    ylabel('I (mA)');                    
                elseif(checkedColumns(i+1)==3)
                    subplot(length(checkedColumns)-1,1,i);
                    plot(time,data(:,i),color{i});
                    title('Plot for channel2');
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
                    title('Plot for channel5');
                    xlabel('Time (S)');
                    ylabel('V (mV)');                    
                end
            end            
        end
        axis('tight');
        grid on;               
    end




%%

% --- Executes on button press in btncsdLoad.
function btncsdLoad_Callback(hObject, eventdata, handles)
% hObject    handle to btncsdLoad (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

    figure_handle = findobj('Tag', 'figcsdMain');
    
    listbox_contents = get(findobj('Tag', 'lstboxcsdContent'), 'String');    
    
    [checkedColumns, flag]=selectedColumns();
    
    if(flag) %if proper signal source and channels are selected

        [fet_time, fet_data, samplingFreq, dataPoints] = loadData(listbox_contents, getappdata(figure_handle,'directoryPath'),checkedColumns);

        setappdata(figure_handle, 'fet_time', fet_time);
        setappdata(figure_handle, 'fet_data', fet_data);        
        setappdata(figure_handle, 'samplingFreq', samplingFreq);
        setappdata(figure_handle, 'dataPoints', dataPoints);        

        set(findobj('Tag','btncsdLoad'),'String', 'Data Files Loaded');
        set(findobj('Tag','btncsdLoad'),'Enable', 'Off');
        set(findobj('Tag','btncsdMoveUp'),'Enable', 'Off');
        set(findobj('Tag','btncsdMoveDown'),'Enable', 'Off');           
        set(findobj('Tag','btncsdCalculate'),'Enable', 'On');
        set(findobj('Tag','btncsdRemoveFile'),'Enable', 'Off');
        set(findobj('Tag','channel1'),'Enable', 'Off');
        set(findobj('Tag','channel2'),'Enable', 'Off');
        set(findobj('Tag','channel3'),'Enable', 'Off');
        set(findobj('Tag','channel4'),'Enable', 'Off');
        set(findobj('Tag','channel5'),'Enable', 'Off');
        
    end
    
    if (isappdata(figure_handle,'averaged_data'))
        rmappdata(figure_handle,'averaged_data');
    end
    
%%

function [checkedColumns, flag] = selectedColumns()
%%
    
    figure_handle = findobj('Tag', 'figcsdMain');
      
    flag=0;
    
    checkedColumns=[1]; %#ok<NBRAK>
    if(isequal(getappdata(figure_handle,'signalType'),2)) %if signal source is In-vivo recording    
        if(isequal(getappdata(figure_handle,'channel1'),1))%if VmAC channel is checked
            checkedColumns = [checkedColumns,2];
        end
        if(isequal(getappdata(figure_handle,'channel2'),1))%if VmDC channel is checked
            checkedColumns = [checkedColumns,3];
        end
        if(isequal(getappdata(figure_handle,'channel3'),1))%if Stimulus channel is checked
            checkedColumns = [checkedColumns,4];
        end
        flag=1;
        setappdata(figure_handle,'checkedColumns',checkedColumns);
    elseif(isequal(getappdata(figure_handle,'signalType'),3)) %if signal source is Transistor recording
        if(isequal(getappdata(figure_handle,'channel1'),1))%if channel1 channel is checked
            checkedColumns = [checkedColumns,2];
        end
        if(isequal(getappdata(figure_handle,'channel2'),1))%if channel2 channel is checked
            checkedColumns = [checkedColumns,3];
        end
        if(isequal(getappdata(figure_handle,'channel4'),1))%if channel4 channel is checked
            checkedColumns = [checkedColumns,4];
        end
        if(isequal(getappdata(figure_handle,'channel5'),1))%if channel5 channel is checked
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
%%
% --- Executes on button press in btncsdRemoveFile.
function btncsdRemoveFile_Callback(hObject, eventdata, handles)
    %%
% hObject    handle to btncsdRemoveFile (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

    fh=findobj('Tag','lstboxcsdContent');
    selected = get(fh,'Value'); 
    prev_str = get(fh, 'String'); 
    if ~isempty(prev_str) 
        prev_str(get(fh,'Value')) = []; 
        set(fh, 'String', prev_str, ... 
            'Value', min(selected,length(prev_str))); 
        setappdata(findobj('Tag','figcsdMain'),'fileNames',prev_str);
    end

function processData(time, data, flagString)
    
    fh = findobj('Tag','figcsdMain');
    
    fileCount=length(getappdata(findobj('Tag','figcsdMain'),'fileNames'));    
    
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
 
            fh = findobj('Tag', 'figcsdMain');

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
 
            fh = findobj('Tag', 'figcsdMain');

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

% --- Executes on selection change in pumcsdRecType.
function pumcsdRecType_Callback(hObject, eventdata, handles)
    %%
% hObject    handle to pumcsdRecType (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = get(hObject,'String') returns pumcsdRecType contents as cell array
%        contents{get(hObject,'Value')} returns selected item from pumcsdRecType

selectedString = get(handles.pumcsdRecType, 'String');
    selectedValue = get(hObject, 'Value');

    setappdata(findobj('Tag','figcsdMain'),'signalType',selectedValue);

    switch selectedValue
        case 2 % if the In-Vivo recording is selected
            set(findobj('Tag', 'btncsdBrowse'), 'Enable', 'On');

            set(findobj('Tag', 'channel2'), 'Visible', 'Off');
%             set(findobj('Tag', 'channel2'), 'String', 'Channel2');        
            set(findobj('Tag', 'channel1'), 'Visible', 'On');    
            set(findobj('Tag', 'channel3'), 'Visible', 'Off');        
%             set(findobj('Tag', 'channel1'), 'String', 'Channel1');        
            set(findobj('Tag', 'channel4'), 'Visible', 'Off');  
            set(findobj('Tag', 'channel5'), 'Visible', 'Off');          

        case 3 % if the Transistor recording is selected
            set(findobj('Tag', 'channel1'), 'Visible', 'On');  
%             set(findobj('Tag', 'channel1'), 'String', 'Channel1');                
            set(findobj('Tag', 'channel2'), 'Visible', 'On');  
            set(findobj('Tag', 'channel3'), 'Visible', 'On');  
%             set(findobj('Tag', 'channel2'), 'String', 'Channel2');                
            set(findobj('Tag', 'channel4'), 'Visible', 'On');  
            set(findobj('Tag', 'channel5'), 'Visible', 'On');  
%             set(findobj('Tag', 'channel3'), 'Visible', 'Off');         

            set(findobj('Tag', 'btncsdBrowse'), 'Enable', 'On');        
        otherwise % if nothing is selected
            msgbox('Please Select a Signal Source', 'Signal Source Not Selected','Error');
            set(findobj('Tag', 'btncsdBrowse'), 'Enable', 'Off');
            set(findobj('Tag', 'channel1'), 'Visible', 'Off');  
            set(findobj('Tag', 'channel2'), 'Visible', 'Off');  
            set(findobj('Tag', 'channel4'), 'Visible', 'Off');  
            set(findobj('Tag', 'channel5'), 'Visible', 'Off'); 
            set(findobj('Tag', 'channel3'), 'Visible', 'Off');         
    end


% --- Executes during object creation, after setting all properties.
function pumcsdRecType_CreateFcn(hObject, eventdata, handles)
% hObject    handle to pumcsdRecType (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

%%



% --- Executes on button press in channel1.
function channel1_Callback(hObject, eventdata, handles)
% hObject    handle to channel1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of channel1

    if (get(hObject,'Value') == get(hObject,'Max'))
        % Checkbox is checked
        setappdata(findobj('Tag','figcsdMain'),'channel1',1);
    else
        % Checkbox is not checked
        setappdata(findobj('Tag','figcsdMain'),'channel1',0);        
    end    



%%

% --- Executes on button press in channel2.
function channel2_Callback(hObject, eventdata, handles)
% hObject    handle to channel2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of channel2

    if (get(hObject,'Value') == get(hObject,'Max'))
        % Checkbox is checked
        setappdata(findobj('Tag','figcsdMain'),'channel2',1);
    else
        % Checkbox is not checked
        setappdata(findobj('Tag','figcsdMain'),'channel2',0);        
    end    

%%


% --- Executes on button press in channel4.
function channel4_Callback(hObject, eventdata, handles)
% hObject    handle to channel4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of channel4

    if (get(hObject,'Value') == get(hObject,'Max'))
        % Checkbox is checked
        setappdata(findobj('Tag','figcsdMain'),'channel4',1);
    else
        % Checkbox is not checked
        setappdata(findobj('Tag','figcsdMain'),'channel4',0);        
    end    

%%

% --- Executes on button press in channel5.
function channel5_Callback(hObject, eventdata, handles)
%%
% hObject    handle to channel5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of channel5

    if (get(hObject,'Value') == get(hObject,'Max'))
        % Checkbox is checked
        setappdata(findobj('Tag','figcsdMain'),'channel5',1);
    else
        % Checkbox is not checked
        setappdata(findobj('Tag','figcsdMain'),'channel5',0);        
    end    



% --- Executes on button press in channel3.
function channel3_Callback(hObject, eventdata, handles)
%%
% hObject    handle to channel3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of channel3


    if (get(hObject,'Value') == get(hObject,'Max'))
        % Checkbox is checked
        setappdata(findobj('Tag','figcsdMain'),'channel3',1);
    else
        % Checkbox is not checked
        setappdata(findobj('Tag','figcsdMain'),'channel3',0);        
    end    
%%
% --- Executes on button press in btncsdMoveUp.
function btncsdMoveUp_Callback(hObject, eventdata, handles)
    %%
% hObject    handle to btncsdMoveUp (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%     fh = findobj('Tag', 'lstboxcsdContent');
%     listbox_contents = get(fh, 'String');
%     selected_index = get(fh, 'Value');    
%     
%     if (~isempty(listbox_contents) && (selected_index > 1)&&(selected_index <= length(listbox_contents)))
%         index = get(fh,'Value');
%         tempFile=listbox_contents{index};
%         listbox_contents{index}=listbox_contents{index-1};
%         listbox_contents{index-1}=tempFile;
%         set(fh, 'String', listbox_contents, ... 
%             'Value', min(index,length(listbox_contents))); 
%         setappdata(findobj('Tag','figcsdMain'),'fileNames',listbox_contents);
%         set(fh,'Value',index-1)
%     end
% 
%     if(selected_index == 1)
%         set(findobj('Tag','btncsdMoveUp'),'Enable', 'Off');
%         set(findobj('Tag','btncsdMoveDown'),'Enable', 'On');        
%     else
%         set(findobj('Tag','btncsdMoveUp'),'Enable', 'On');        
%     end    
% 
%     if(selected_index == length(listbox_contents))
%         set(findobj('Tag','btncsdMoveDown'),'Enable', 'Off');
%         set(findobj('Tag','btncsdMoveUp'),'Enable', 'On');
%     else
%         set(findobj('Tag','btncsdMoveDown'),'Enable', 'On');        
%     end  

    fh = findobj('Tag', 'lstboxcsdContent');
    listbox_contents = get(fh, 'String');
    selected_index = get(fh, 'Value');    
    
    if length(selected_index)>1
        newIndex=[];
        for i=1:length(selected_index)
            if (~isempty(listbox_contents) && (selected_index(i) > 1)&&(selected_index(i) <= length(listbox_contents)))
                index = selected_index(i);
                tempFile=listbox_contents{index};
                listbox_contents{index}=listbox_contents{index-1};
                listbox_contents{index-1}=tempFile;
                set(fh, 'String', listbox_contents, ... 
                    'Value', min(index,length(listbox_contents))); 
                setappdata(findobj('Tag','figcsdMain'),'fileNames',listbox_contents);
                set(fh,'Value',index-1)
                newIndex(i)=selected_index(i)-1;
            end
        end
        set(fh,'Value',newIndex)
    elseif length(selected_index)==1
        if (~isempty(listbox_contents) && (selected_index > 1)&&(selected_index <= length(listbox_contents)))
            index = get(fh,'Value');
            tempFile=listbox_contents{index};
            listbox_contents{index}=listbox_contents{index-1};
            listbox_contents{index-1}=tempFile;
            set(fh, 'String', listbox_contents, ... 
                'Value', min(index,length(listbox_contents))); 
            setappdata(findobj('Tag','figcsdMain'),'fileNames',listbox_contents);
            set(fh,'Value',index-1)
            newIndex=index-1;
        end
    end

    if(newIndex(1) == 1)
        set(findobj('Tag','btncsdMoveUp'),'Enable', 'Off');
        set(findobj('Tag','btncsdMoveDown'),'Enable', 'On');        
    else
        set(findobj('Tag','btncsdMoveUp'),'Enable', 'On');        
    end    

    if(newIndex(end) == length(listbox_contents))
        set(findobj('Tag','btncsdMoveDown'),'Enable', 'Off');
        set(findobj('Tag','btncsdMoveUp'),'Enable', 'On');
    else
        set(findobj('Tag','btncsdMoveDown'),'Enable', 'On');        
    end  

% --- Executes on button press in btncsdMoveDown.
function btncsdMoveDown_Callback(hObject, eventdata, handles)
    %%
% hObject    handle to btncsdMoveDown (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%     fh = findobj('Tag', 'lstboxcsdContent');    
%     listbox_contents = get(fh, 'String');
%     selected_index = get(fh, 'Value');
%     
% 
%     if (~isempty(listbox_contents) && (selected_index >= 1)&&(selected_index < length(listbox_contents)))
%         index = get(fh,'Value');
%         tempFile=listbox_contents{index};
%         listbox_contents{index}=listbox_contents{index+1};
%         listbox_contents{index+1}=tempFile;
%         set(fh, 'String', listbox_contents, ... 
%             'Value', min(index,length(listbox_contents))); 
%         setappdata(findobj('Tag','figcsdMain'),'fileNames',listbox_contents);
%         set(fh,'Value',index+1)        
%     end     
% 
%     if(selected_index == 1)
%         set(findobj('Tag','btncsdMoveUp'),'Enable', 'Off');
%         set(findobj('Tag','btncsdMoveDown'),'Enable', 'On');        
%     else
%         set(findobj('Tag','btncsdMoveUp'),'Enable', 'On');        
%     end    
% 
%     if(selected_index == length(listbox_contents))
%         set(findobj('Tag','btncsdMoveDown'),'Enable', 'Off');
%         set(findobj('Tag','btncsdMoveUp'),'Enable', 'On');
%     else
%         set(findobj('Tag','btncsdMoveDown'),'Enable', 'On');        
%     end

    fh = findobj('Tag', 'lstboxcsdContent');    
    listbox_contents = get(fh, 'String');
    selected_index = get(fh, 'Value');
    
    if length(selected_index)>1
        newIndex=[];
        for i=length(selected_index):-1:1
            if (~isempty(listbox_contents) && (selected_index(i) >= 1)&&(selected_index(i) < length(listbox_contents)))
                index = selected_index(i);
                tempFile=listbox_contents{index};
                listbox_contents{index}=listbox_contents{index+1};
                listbox_contents{index+1}=tempFile;
                set(fh, 'String', listbox_contents, ... 
                    'Value', max(index,length(listbox_contents))); 
                setappdata(findobj('Tag','figcsdMain'),'fileNames',listbox_contents);
                set(fh,'Value',index+1)
                newIndex(i)=selected_index(i)+1;
            end
        end
        set(fh,'Value',newIndex)
    elseif length(selected_index)==1
        if (~isempty(listbox_contents) && (selected_index >= 1)&&(selected_index < length(listbox_contents)))
            index = get(fh,'Value');
            tempFile=listbox_contents{index};
            listbox_contents{index}=listbox_contents{index+1};
            listbox_contents{index+1}=tempFile;
            set(fh, 'String', listbox_contents, ... 
                'Value', min(index,length(listbox_contents))); 
            setappdata(findobj('Tag','figcsdMain'),'fileNames',listbox_contents);
            set(fh,'Value',index+1)
            newIndex=index+1;
        end
    end
    
%     if (~isempty(listbox_contents) && (selected_index >= 1)&&(selected_index < length(listbox_contents)))
%         index = get(fh,'Value');
%         tempFile=listbox_contents{index};
%         listbox_contents{index}=listbox_contents{index+1};
%         listbox_contents{index+1}=tempFile;
%         set(fh, 'String', listbox_contents, ... 
%             'Value', min(index,length(listbox_contents))); 
%         setappdata(findobj('Tag','figcsdMain'),'fileNames',listbox_contents);
%         set(fh,'Value',index+1)        
%     end     

    if(newIndex(1) == 1)
        set(findobj('Tag','btncsdMoveUp'),'Enable', 'Off');
        set(findobj('Tag','btncsdMoveDown'),'Enable', 'On');        
    else
        set(findobj('Tag','btncsdMoveUp'),'Enable', 'On');        
    end    

    if(newIndex(end) == length(listbox_contents))
        set(findobj('Tag','btncsdMoveDown'),'Enable', 'Off');
        set(findobj('Tag','btncsdMoveUp'),'Enable', 'On');
    else
        set(findobj('Tag','btncsdMoveDown'),'Enable', 'On');        
    end
    

% --- Executes on button press in tbcsdZoom.
function tbcsdZoom_Callback(hObject, eventdata, handles)
    %%
% hObject    handle to tbcsdZoom (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of tbcsdZoom

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

% --- Executes on button press in tbcsdDataCursor.
function tbcsdDataCursor_Callback(hObject, eventdata, handles)
    %%
% hObject    handle to tbcsdDataCursor (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of tbcsdDataCursor

    button_state = get(hObject,'Value');
    if button_state == get(hObject,'Max')
	% Toggle button is pressed, take appropriate action
        datacursormode on;
        dcm_obj=datacursormode(findobj('Tag','figcsdMain'));
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
    txt = {['Time: ',num2str(pos(1)),' s'],...
        ['Amplitude: ',num2str(pos(2))]};%,' mV'};    


% --- Executes on button press in btncsdResetGraph.
function btncsdResetGraph_Callback(hObject, eventdata, handles)
    %%
% hObject    handle to btncsdResetGraph (see GCBO)
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


% --- Executes on button press in tbcsdPan.
function tbcsdPan_Callback(hObject, eventdata, handles)
%%
% hObject    handle to tbcsdPan (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of tbcsdPan


    button_state = get(hObject,'Value');
    if button_state == get(hObject,'Max')
	% Toggle button is pressed, take appropriate action
        pan on;
%         dcm_obj=datacursormode(findobj('Tag','figcsdMain'));
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


% --- Executes on button press in rbcsdStandard.
function rbcsdStandard_Callback(hObject, eventdata, handles)
%%
% hObject    handle to rbcsdStandard (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of rbcsdStandard

%     if (get(findobj('Tag','rbcsdStandard'),'Value')==1)
    fh=findobj('Tag','figcsdMain');
    set(findobj('Tag','rbcsdStandard'),'Value', 1);
    set(findobj('Tag','rbcsdDeltaInverse'),'Value', 0);
    set(findobj('Tag','rbcsdStepInverse'),'Value', 0);
    set(findobj('Tag','rbcsdSplineInverse'),'Value', 0);
    selectedCSDMethod=1;
    setappdata(fh,'selectedCSDMethod',selectedCSDMethod);
%     else
%     end

%%
% --- Executes on button press in rbcsdDeltaInverse.
function rbcsdDeltaInverse_Callback(hObject, eventdata, handles)
%%
% hObject    handle to rbcsdDeltaInverse (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of rbcsdDeltaInverse

    fh=findobj('Tag','figcsdMain');
    set(findobj('Tag','rbcsdStandard'),'Value', 0);
    set(findobj('Tag','rbcsdDeltaInverse'),'Value', 1);
    set(findobj('Tag','rbcsdStepInverse'),'Value', 0);
    set(findobj('Tag','rbcsdSplineInverse'),'Value', 0);
    selectedCSDMethod=2;
    setappdata(fh,'selectedCSDMethod',selectedCSDMethod);

%%
% --- Executes on button press in rbcsdStepInverse.
function rbcsdStepInverse_Callback(hObject, eventdata, handles)
%%
% hObject    handle to rbcsdStepInverse (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of rbcsdStepInverse

    fh=findobj('Tag','figcsdMain');
    set(findobj('Tag','rbcsdStandard'),'Value', 0);
    set(findobj('Tag','rbcsdDeltaInverse'),'Value', 0);
    set(findobj('Tag','rbcsdStepInverse'),'Value', 1);
    set(findobj('Tag','rbcsdSplineInverse'),'Value', 0);
    selectedCSDMethod=3;
    setappdata(fh,'selectedCSDMethod',selectedCSDMethod);

%%
% --- Executes on button press in rbcsdSplineInverse.
function rbcsdSplineInverse_Callback(hObject, eventdata, handles)
%%
% hObject    handle to rbcsdSplineInverse (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of rbcsdSplineInverse

    fh=findobj('Tag','figcsdMain');
    set(findobj('Tag','rbcsdStandard'),'Value', 0);
    set(findobj('Tag','rbcsdDeltaInverse'),'Value', 0);
    set(findobj('Tag','rbcsdStepInverse'),'Value', 0);
    set(findobj('Tag','rbcsdSplineInverse'),'Value', 1);
    selectedCSDMethod=4;
    setappdata(fh,'selectedCSDMethod',selectedCSDMethod);
%%



function txtcsdInitialDepth_Callback(hObject, eventdata, handles)
% hObject    handle to txtcsdInitialDepth (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of txtcsdInitialDepth as text
%        str2double(get(hObject,'String')) returns contents of txtcsdInitialDepth as a double


% --- Executes during object creation, after setting all properties.
function txtcsdInitialDepth_CreateFcn(hObject, eventdata, handles)
% hObject    handle to txtcsdInitialDepth (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function txtcsdRecordingPitch_Callback(hObject, eventdata, handles)
% hObject    handle to txtcsdRecordingPitch (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of txtcsdRecordingPitch as text
%        str2double(get(hObject,'String')) returns contents of txtcsdRecordingPitch as a double


% --- Executes during object creation, after setting all properties.
function txtcsdRecordingPitch_CreateFcn(hObject, eventdata, handles)
% hObject    handle to txtcsdRecordingPitch (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function txtcsdSourceDiameter_Callback(hObject, eventdata, handles)
% hObject    handle to txtcsdSourceDiameter (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of txtcsdSourceDiameter as text
%        str2double(get(hObject,'String')) returns contents of txtcsdSourceDiameter as a double


% --- Executes during object creation, after setting all properties.
function txtcsdSourceDiameter_CreateFcn(hObject, eventdata, handles)
% hObject    handle to txtcsdSourceDiameter (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function txtcsdSigma_Callback(hObject, eventdata, handles)
% hObject    handle to txtcsdSigma (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of txtcsdSigma as text
%        str2double(get(hObject,'String')) returns contents of txtcsdSigma as a double


% --- Executes during object creation, after setting all properties.
function txtcsdSigma_CreateFcn(hObject, eventdata, handles)
% hObject    handle to txtcsdSigma (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function txtcsdStimOnset_Callback(hObject, eventdata, handles)
% hObject    handle to txtcsdStimOnset (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of txtcsdStimOnset as text
%        str2double(get(hObject,'String')) returns contents of txtcsdStimOnset as a double


% --- Executes during object creation, after setting all properties.
function txtcsdStimOnset_CreateFcn(hObject, eventdata, handles)
% hObject    handle to txtcsdStimOnset (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in chkboxcsdSplineInterpolate.
function chkboxcsdSplineInterpolate_Callback(hObject, eventdata, handles)
% hObject    handle to chkboxcsdSplineInterpolate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of chkboxcsdSplineInterpolate



% --- Executes during object creation, after setting all properties.
function axscsdSigMate_CreateFcn(hObject, eventdata, handles)
% hObject    handle to axscsdSigMate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: place code in OpeningFcn to populate axscsdSigMate
    axes(hObject)
    pathLogo = which('SigMate-Logo');
    imshow([pathLogo '\' 'SigMate-Logo.gif'])
