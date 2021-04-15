classdef SANTIA_toolbox < matlab.apps.AppBase

    % Properties that correspond to app components
    properties (Access = public)
        UIFigure                        matlab.ui.Figure
        Image                           matlab.ui.control.Image
        SigMateAdvancedaNeuronalToolforIdentificationofArtifactsLabel  matlab.ui.control.Label
        Label                           matlab.ui.control.Label
        TabGroup                        matlab.ui.container.TabGroup
        DataLabellingTab                matlab.ui.container.Tab
        HistogramTheshButton            matlab.ui.control.Button
        OpenSigMateButton               matlab.ui.control.Button
        FormatforSigMateButton          matlab.ui.control.Button
        SaveUnlabelledDataButton        matlab.ui.control.Button
        ProgressPanel                   matlab.ui.container.Panel
        Label_2                         matlab.ui.control.Label
        ThresTableButton                matlab.ui.control.Button
        UITable                         matlab.ui.control.Table
        SelectChannelDropDown           matlab.ui.control.DropDown
        SelectChannelDropDownLabel      matlab.ui.control.Label
        SaveButton                      matlab.ui.control.Button
        SelectedThresholdValuesLabel    matlab.ui.control.Label
        ScaleButtonGroup                matlab.ui.container.ButtonGroup
        uVButton_2                      matlab.ui.control.RadioButton
        mVButton_2                      matlab.ui.control.RadioButton
        VButton_2                       matlab.ui.control.RadioButton
        WindowLengthEditField_2         matlab.ui.control.NumericEditField
        WindowLength                    matlab.ui.control.Label
        LabelTableButton                matlab.ui.control.Button
        UnitofRecordingsButtonGroup     matlab.ui.container.ButtonGroup
        uVButton                        matlab.ui.control.RadioButton
        mVButton                        matlab.ui.control.RadioButton
        VButton                         matlab.ui.control.RadioButton
        SamplingFrequencyEditField      matlab.ui.control.NumericEditField
        SamplingFrequencyEditFieldLabel  matlab.ui.control.Label
        GenerateAnalysisMatrixButton    matlab.ui.control.Button
        LoadSignalsButton               matlab.ui.control.StateButton
        NeuralNetworkTrainingTab        matlab.ui.container.Tab
        ProgressPanel_2                 matlab.ui.container.Panel
        Label_3                         matlab.ui.control.Label
        TrainingDataPanel_2             matlab.ui.container.Panel
        BalanceDataCheckBox             matlab.ui.control.CheckBox
        SplitButton                     matlab.ui.control.Button
        TestEditField                   matlab.ui.control.NumericEditField
        TestEditFieldLabel              matlab.ui.control.Label
        ValidationEditField             matlab.ui.control.NumericEditField
        ValidationEditFieldLabel        matlab.ui.control.Label
        TrainingEditField               matlab.ui.control.NumericEditField
        TrainingEditFieldLabel          matlab.ui.control.Label
        LoadTrainingDataButton          matlab.ui.control.Button
        NetworkTrainingPanel            matlab.ui.container.Panel
        TestSetResultsPlotDropDown      matlab.ui.control.DropDown
        TestSetResultsPlotLabel         matlab.ui.control.Label
        TestSetResultsButton            matlab.ui.control.Button
        CreateNetworkButton             matlab.ui.control.Button
        ChooseNetworkDropDown_3         matlab.ui.control.DropDown
        ChooseNetworkDropDown_3Label    matlab.ui.control.Label
        TrainNetworkButton              matlab.ui.control.Button
        TrainingoptionsPanel            matlab.ui.container.Panel
        TabGroup2                       matlab.ui.container.TabGroup
        BasicTab                        matlab.ui.container.Tab
        VerboseFrequencySpinner         matlab.ui.control.Spinner
        VerboseFrequencySpinnerLabel    matlab.ui.control.Label
        VerboseCheckBox                 matlab.ui.control.CheckBox
        MiniBatchSizeSpinner            matlab.ui.control.Spinner
        MiniBatchSizeSpinnerLabel       matlab.ui.control.Label
        MaxEpochsSpinner                matlab.ui.control.Spinner
        MaxEpochsSpinnerLabel           matlab.ui.control.Label
        ValidationFrequencySpinner      matlab.ui.control.Spinner
        ValidationFrequencySpinnerLabel  matlab.ui.control.Label
        InitialLearnRateSpinner         matlab.ui.control.Spinner
        InitialLearnRateSpinnerLabel    matlab.ui.control.Label
        SolverDropDown                  matlab.ui.control.DropDown
        SolverDropDownLabel             matlab.ui.control.Label
        ExecutionEnviromentDropDown     matlab.ui.control.DropDown
        ExecutionEnviromentDropDownLabel  matlab.ui.control.Label
        PlotCheckBox                    matlab.ui.control.CheckBox
        AdvancedoptionalTab             matlab.ui.container.Tab
        MomentumSpinner                 matlab.ui.control.Spinner
        MomentumSpinnerLabel            matlab.ui.control.Label
        LearnRateDropPeriodSpinner      matlab.ui.control.Spinner
        LearnRateDropPeriodSpinnerLabel  matlab.ui.control.Label
        LearnRateDropFactorSpinner      matlab.ui.control.Spinner
        LearnRateDropFactorSpinnerLabel  matlab.ui.control.Label
        LearnRateScheduleDropDown       matlab.ui.control.DropDown
        LearnRateScheduleDropDownLabel  matlab.ui.control.Label
        ShuffleDropDown                 matlab.ui.control.DropDown
        ShuffleDropDownLabel            matlab.ui.control.Label
        ValidationPatienceSpinner       matlab.ui.control.Spinner
        ValidationPatienceLabel         matlab.ui.control.Label
        GradientThresholdSpinner        matlab.ui.control.Spinner
        GradientThresholdSpinnerLabel   matlab.ui.control.Label
        ResetInputNormalizationCheckBox  matlab.ui.control.CheckBox
        GradientThresholdMethodDropDown  matlab.ui.control.DropDown
        GradientThresholdMethodDropDownLabel  matlab.ui.control.Label
        L2RegularizationSpinner         matlab.ui.control.Spinner
        L2RegularizationSpinnerLabel    matlab.ui.control.Label
        SaveResultsButton               matlab.ui.control.Button
        ClassifyNewUnlabelledDataTab    matlab.ui.container.Tab
        SelectWindowListBoxLabel        matlab.ui.control.Label
        ClassifyButton_3                matlab.ui.control.StateButton
        LoadUnlabelledDataButton_3      matlab.ui.control.Button
        LoadTrainedNetButton            matlab.ui.control.Button
        SaveButton_2                    matlab.ui.control.Button
        NormalLabel                     matlab.ui.control.Label
        ProgressPanel_3                 matlab.ui.container.Panel
        Label_4                         matlab.ui.control.Label
        PlotandShowClassButton          matlab.ui.control.Button
        SelectWindowListBox             matlab.ui.control.ListBox
        ClassificationResultLabel       matlab.ui.control.Label
        UIAxes                          matlab.ui.control.UIAxes
        ArtifactRemovalTab              matlab.ui.container.Tab
        SelectChannelDropDown_2         matlab.ui.control.DropDown
        SelectChannelDropDown_2Label    matlab.ui.control.Label
        ProgressPanel_4                 matlab.ui.container.Panel
        Label_5                         matlab.ui.control.Label
        TrainingDataPanel_3             matlab.ui.container.Panel
        SegmentLengthmSEditField        matlab.ui.control.NumericEditField
        SegmentLengthmSEditFieldLabel   matlab.ui.control.Label
        ExtractArtifactfreeSegmentsButton  matlab.ui.control.Button
        LoadTrainingDataButton_2        matlab.ui.control.Button
        NetworkTrainingPanel_2          matlab.ui.container.Panel
        SequenceLengthPanel             matlab.ui.container.Panel
        DataforModelTestingEditField    matlab.ui.control.NumericEditField
        DataforModelTestingLabel        matlab.ui.control.Label
        UnitButtonGroup                 matlab.ui.container.ButtonGroup
        DatapointsButton                matlab.ui.control.RadioButton
        mSButton                        matlab.ui.control.RadioButton
        NNOutputEditField               matlab.ui.control.NumericEditField
        NNOutputEditFieldLabel          matlab.ui.control.Label
        NNInputEditField                matlab.ui.control.NumericEditField
        NNInputEditFieldLabel           matlab.ui.control.Label
        PlotchannelButton               matlab.ui.control.Button
        ReplaceSegmentsButton           matlab.ui.control.Button
        TestEditField_2                 matlab.ui.control.NumericEditField
        TestEditField_2Label            matlab.ui.control.Label
        ValidationEditField_2           matlab.ui.control.NumericEditField
        ValidationEditField_2Label      matlab.ui.control.Label
        TrainingEditField_2             matlab.ui.control.NumericEditField
        TrainingEditField_2Label        matlab.ui.control.Label
        ViewTestResultsButton           matlab.ui.control.Button
        TrainNetworkButton_2            matlab.ui.control.Button
        TrainingoptionsPanel_2          matlab.ui.container.Panel
        TabGroup2_2                     matlab.ui.container.TabGroup
        BasicTab_2                      matlab.ui.container.Tab
        VerboseFrequencySpinner_2       matlab.ui.control.Spinner
        VerboseFrequencySpinner_2Label  matlab.ui.control.Label
        VerboseCheckBox_2               matlab.ui.control.CheckBox
        MiniBatchSizeSpinner_2          matlab.ui.control.Spinner
        MiniBatchSizeSpinner_2Label     matlab.ui.control.Label
        MaxEpochsSpinner_2              matlab.ui.control.Spinner
        MaxEpochsSpinner_2Label         matlab.ui.control.Label
        ValidationFrequencySpinner_2    matlab.ui.control.Spinner
        ValidationFrequencySpinner_2Label  matlab.ui.control.Label
        InitialLearnRateSpinner_2       matlab.ui.control.Spinner
        InitialLearnRateSpinner_2Label  matlab.ui.control.Label
        SolverDropDown_2                matlab.ui.control.DropDown
        SolverDropDown_2Label           matlab.ui.control.Label
        ExecutionEnviromentDropDown_2   matlab.ui.control.DropDown
        ExecutionEnviromentDropDown_2Label  matlab.ui.control.Label
        PlotCheckBox_2                  matlab.ui.control.CheckBox
        AdvancedoptionalTab_2           matlab.ui.container.Tab
        MomentumSpinner_2               matlab.ui.control.Spinner
        MomentumSpinner_2Label          matlab.ui.control.Label
        LearnRateDropPeriodSpinner_2    matlab.ui.control.Spinner
        LearnRateDropPeriodSpinner_2Label  matlab.ui.control.Label
        LearnRateDropFactorSpinner_2    matlab.ui.control.Spinner
        LearnRateDropFactorSpinner_2Label  matlab.ui.control.Label
        LearnRateScheduleDropDown_2     matlab.ui.control.DropDown
        LearnRateScheduleDropDown_2Label  matlab.ui.control.Label
        ShuffleDropDown_2               matlab.ui.control.DropDown
        ShuffleDropDown_2Label          matlab.ui.control.Label
        ValidationPatienceSpinner_2     matlab.ui.control.Spinner
        ValidationPatienceSpinner_2Label  matlab.ui.control.Label
        GradientThresholdSpinner_2      matlab.ui.control.Spinner
        GradientThresholdSpinner_2Label  matlab.ui.control.Label
        ResetInputNormalizationCheckBox_2  matlab.ui.control.CheckBox
        GradientThresholdMethodDropDown_2  matlab.ui.control.DropDown
        GradientThresholdMethodDropDown_2Label  matlab.ui.control.Label
        L2RegularizationSpinner_2       matlab.ui.control.Spinner
        L2RegularizationSpinner_2Label  matlab.ui.control.Label
        SaveResultsButton_2             matlab.ui.control.Button
    end

    % Callbacks that handle component events
    methods (Access = private)

        % Code that executes after component creation
        function startupFcn(app)
            warning off;
            appdata = get(0,'ApplicationData');
            fns = fieldnames(appdata);
            for ii = 1:numel(fns)
              rmappdata(0,fns{ii});
            end
        end

        % Value changed function: LoadSignalsButton
        function LoadSignalsButtonValueChanged(app, event)

             %%%CLEAR ALL VARS
            app.Label_2.Visible=0;
            appdata = get(0,'ApplicationData');
            fns = fieldnames(appdata);
            for ii = 1:numel(fns)
              rmappdata(0,fns{ii});
            end
            %%%%%LOAD
            RawDataInput =uiimport('-file');
            if isempty(RawDataInput)==1
            msgbox('Load Cancelled','Warning','warn');
            return
            end
            filename_rawmat=char(fieldnames(RawDataInput));
            RawDataInput =cell2mat( struct2cell(  RawDataInput ) );
            time_limit=size(RawDataInput,2); %%recording length
            number_of_channels=size(RawDataInput,1);
            
            %%%%NUMBER OF CHANNELS FOR TABLE AND DROP DOWN ITEMS
            channellist=strings;
            for p=1:number_of_channels
                p_st=num2str(p); 
                channellist(p)=strcat('channel_',p_st);
                chval(p)=p;
            end
            app.SelectChannelDropDown.Items=channellist;
            app.SelectChannelDropDown.ItemsData=chval;
            
            rowsforthresholddisplay=strings;
            if rem(number_of_channels,10)==0
               maxrowsdisplay=floor(number_of_channels/10); 
            else
               maxrowsdisplay=floor(number_of_channels/10)+1;
            end    
            app.UITable.Data=zeros(maxrowsdisplay,10);
            for counter=1:maxrowsdisplay
                sc=num2str(counter-1); 
                ec=num2str(10*counter); 
                rowsforthresholddisplay(counter)=strcat(sc,'1','_to_',ec);
            end
            app.UITable.RowName=rowsforthresholddisplay;
            
            %SET UP DATA
            setappdata(0,'time_limit',time_limit);
            setappdata(0,'RawDataInput_g',RawDataInput);
            setappdata(0,'filename_rawmat',filename_rawmat);
            app.LoadSignalsButton.Value=0;
            app.Label_2.Visible=1;
            app.Label_2.Text='Signals Loaded';
        end

        % Value changed function: WindowLengthEditField_2
        function WindowLengthEditField_2ValueChanged(app, event)
           time_limit_t=getappdata(0,'time_limit');
           if  app.WindowLengthEditField_2.Value*app.SamplingFrequencyEditField.Value<1
           errordlg('Sampling Frequency multiplied by Window Length must be equal to or bigger than 1','Length Error');
           end
           if  app.WindowLengthEditField_2.Value*app.SamplingFrequencyEditField.Value> time_limit_t
           errordlg('Window Length exceeds recording length','Length Error');
           end
        end

        % Button pushed function: FormatforSigMateButton
        function FormatforSigMateButtonPushed(app, event)
            %%%FAILSAFE #1
            RawDataInput_sigmate=getappdata(0,'RawDataInput_g');
            if isempty(RawDataInput_sigmate)==1
            errordlg('Nothing Loaded','Error');
            return
            end
            %%%%%%%%%%%%%
            RawDataInput_sigmate=RawDataInput_sigmate';
            length=size(RawDataInput_sigmate,1);
            time=linspace(1,length,length)/app.SamplingFrequencyEditField.Value;
            time=time';
            channelnumbers=size(RawDataInput_sigmate,2);
            filename_rawmat=getappdata(0,'filename_rawmat');
            if rem(channelnumbers,5)==0
                numfiles=round(channelnumbers/5,0);
            else
                numfiles=round(channelnumbers/5,0)+1;
            end
            msgbox('Select Directory to Save Files','Notice','help');
            dname = uigetdir('C:\');
            values=[];
            for j=1:numfiles
                if j==numfiles
                    values=RawDataInput_sigmate(:,1+5*(j-1):end);
                else
                    values=RawDataInput_sigmate(:,1+5*(j-1):5*j);
                end
                values=[time values];
                count=num2str(j);
                name=strcat(dname,'\',filename_rawmat,'_file_',count,'.txt');
                writematrix(values,name)
            end
        app.Label_2.Text='Saved in SigMate Format';
        end

        % Button pushed function: GenerateAnalysisMatrixButton
        function GenerateAnalysisMatrixButtonPushed(app, event)
            %%%FAILSAFE #1
            RawDataInput_g=getappdata(0,'RawDataInput_g');
            if isempty(RawDataInput_g)==1
            errordlg('Nothing Loaded','Error');
            return
            end
            %%%FAILSAFE #2
            time_limit_t=getappdata(0,'time_limit');
            if  app.WindowLengthEditField_2.Value*app.SamplingFrequencyEditField.Value<1
            errordlg('Sampling Frequency multiplied by Window Length must be equal to or bigger than 1','Length Error');
            return
            end
            if  app.WindowLengthEditField_2.Value*app.SamplingFrequencyEditField.Value> time_limit_t
           errordlg('Window Length exceeds recording length','Length Error');
           return
           end
            %%%%IMPORT PROCESS/MAIN
            if app.VButton.Value == true && app.mVButton_2.Value== true %%SCALING
               RawDataInput_g =RawDataInput_g/10^3;
            elseif app.VButton.Value == true && app.uVButton_2.Value== true%%SCALING
                RawDataInput_g =RawDataInput_g/10^6;
            elseif app.mVButton.Value == true && app.VButton_2.Value== true%%SCALING
                RawDataInput_g =RawDataInput_g*10^3;
            elseif app.mVButton.Value == true && app.uVButton_2.Value== true%%SCALING
                RawDataInput_g =RawDataInput_g/10^3;               
            elseif app.uVButton.Value == true && app.VButton_2.Value== true%%SCALING
                RawDataInput_g =RawDataInput_g*10^6;
            elseif app.uVButton.Value == true && app.mVButton_2.Value== true%%SCALING
                RawDataInput_g =RawDataInput_g/10^3;    
            end
            filename_rawmat=getappdata(0,'filename_rawmat');
            channels_or=size(RawDataInput_g,1); %%Number of channels
            width_m=round(app.WindowLengthEditField_2.Value*app.SamplingFrequencyEditField.Value,0);     %%window size
            tope=floor(size(RawDataInput_g,2)/width_m); %%know the amount of window per channel
            r = rem(size(RawDataInput_g,2),width_m); %%leftover not included
            RawDataInput_g=RawDataInput_g(:,1:end-r); %%remove leftover
            RawDataInput_g=reshape(RawDataInput_g',width_m,[])'; %%reshape
                        
            %%%%%%%%%%%MEMORYCHECK
            maxMemFrac = 0.8; %# I want to use at most 80% of the available memory
            numElements = channels_or*tope;
            numBytesNeeded = numElements * (8+56); %# I use double plus a string for rowname           
            %# read available memory
            [~,memStats] = memory;            
            if numBytesNeeded > memStats.PhysicalMemory.Available * maxMemFrac
               error('MYSIM:OUTOFMEMORY','too much memory would be needed')
            return
            end
            %%%%%%%%%%%%%%%%%%%%%%%
            Row_name = strings;
            Power_window=zeros(channels_or*tope,1);

            for i=1:channels_or
                i_st=num2str(i); 
                for j=1:tope
                j_st=num2str(j);  
                Row_name((i-1)*tope+j,1)=strcat(filename_rawmat,'_channel_',i_st,'_window_',j_st);
                Power_window((i-1)*tope+j,1)=sum(RawDataInput_g((i-1)*tope+j,:).^2);
                end
            end
            VariableNamesTble= strings;
            for m=1:size(RawDataInput_g,2)
                m_st=num2str(m);
            VariableNamesTble(m)=strcat('t_',m_st);
            end
            RawDataInput_g=array2table(RawDataInput_g, 'RowNames', Row_name,'VariableNames', VariableNamesTble);
            Power_window=array2table(Power_window, 'VariableNames', {'Window_Power'});
            RawDataInput_t=[Power_window,RawDataInput_g];
            setappdata(0,'tope',tope);   
            setappdata(0,'RawDataInput_t',RawDataInput_t);   
            setappdata(0,'RawDataInput_um',RawDataInput_g);   
            app.Label_2.Text='Analysis Matrix Generated';
        end

        % Button pushed function: SaveUnlabelledDataButton
        function SaveUnlabelledDataButtonPushed(app, event)
            %%%%%%%%%%failsafe
            RawDataInput_um=getappdata(0,'RawDataInput_um');
            if isempty(RawDataInput_um)==1
            errordlg('Nothing Generated','Error');
            return
            end
            filename_rawmat=getappdata(0,'filename_rawmat');
            structured_data.filename=filename_rawmat;
            structured_data.Data = RawDataInput_um;
            structured_data.SamplingFrequency=app.SamplingFrequencyEditField.Value;
            structured_data.WindowLength=app.WindowLengthEditField_2.Value;           
            if app.VButton_2.Value==1              
                    structured_data.Scale = 'Volts';
            elseif app.mVButton_2.Value==1
                    structured_data.Scale = 'Millivolts';
            elseif app.uVButton_2.Value==1
                    structured_data.Scale = 'Microvolts';                       
            end  
            uisave('structured_data','structured_data.mat');
        end

        % Button pushed function: ThresTableButton
        function ThresTableButtonPushed(app, event)
            %%%FAILSAFE #1
            RawDataInput_ts=getappdata(0,'RawDataInput_t');
            if isempty(RawDataInput_ts)==1
            errordlg('Nothing Generated','Error');
            return
            end
            tope=getappdata(0,'tope');
            selectchannel=app.SelectChannelDropDown.Value;
            from=(selectchannel-1)*tope+1;
            to=(selectchannel)*tope;
            RawDataInput_ts=RawDataInput_ts(from:to,:);
            setappdata(0,'row_names_1',RawDataInput_ts.Properties.RowNames);
            
            fig = uifigure('Position',[100, 100, 1300, 530]); %OPEN FIGURE
           %%%ADD TITLE
            lbl = uilabel(fig);
            lbl.Text = 'Click on a row to select a threshold level';
            lbl.FontSize=18;
            lbl.Position = [500 460 2000 60];

            %%%% ADD TABLE
            uit = uitable(fig,'Data',RawDataInput_ts,'Position',[50, 70, 1200, 400],'ColumnSortable',true); %ADD TABLE AND PROPERTIES
            uit.ColumnName=RawDataInput_ts.Properties.VariableNames;
            uit.RowName=RawDataInput_ts.Properties.RowNames;
            uit.CellSelectionCallback=@seleccion;
            
                                 
            %%%COLOR  ARTIFACT ROWS
            function seleccion(uit, event)
            s1 = uistyle('BackgroundColor',[0.94 0.94 0.94]); %RESTORE GREY
            addStyle(uit,s1) 
            
            %%%% ADD PLOT BUTTON ONCE SELECTED VALUE
            plot_sig = uibutton(fig);
            plot_sig.ButtonPushedFcn = createCallbackFcn(app, @plot_sigButtonPushed, true);
            plot_sig.Position = [650 15 200 46];
            plot_sig.Text = 'Plot selected window';            
                        
            %%%% ADD SELECTION BUTTON ONCE SELECTED VALUE
            SELECT_TH= uibutton(fig);
            SELECT_TH.ButtonPushedFcn = createCallbackFcn(app, @SELECT_THButtonPushed, true);
            SELECT_TH.Position = [400 15 200 46];
            SELECT_TH.Text = 'Select Threshold value';
            
            %%%%%%%%SELECT AND ADD COLOR
            data    = get(uit, 'Data');
            index   = event.Indices;
            index_val=data{index(1), 1}; %FIND CLICKED VALUE and refer to the power
            setappdata(0,'index_val',index_val);  
            row_art = find(data{:,1}>=index_val); %HIGHLIGHT ALL BIGGER THAN IT
            s1 = uistyle('BackgroundColor','red');
            addStyle(uit,s1,'row',row_art)         
            row_norm = find(data{:,1}<index_val);
            s2= uistyle('BackgroundColor','green');
            addStyle(uit,s2,'row',row_norm)
            signal_for_plot=data{index(1), 2:end};
            name_for_plot=getappdata(0,'row_names_1');
            name_for_plot = name_for_plot(index(1));
            setappdata(0,'signal_for_plot',signal_for_plot);  
            setappdata(0,'name_for_plot',name_for_plot);
            
            %%%SEND THRESHOLD TO TABLE
            function SELECT_THButtonPushed(app, event)
            index_val=getappdata(0,'index_val');
            selectchannel=app.SelectChannelDropDown.Value;
                 if selectchannel<11
                 app.UITable.Data(1,selectchannel)=index_val;
                 else
                 rowfortabledisplay=floor(selectchannel/10)+1;
                 columnfortabledisplay=rem(selectchannel,10);
                 app.UITable.Data(rowfortabledisplay,columnfortabledisplay)=index_val;            
                 end
            dirIm=which('done.png');
            SELECT_TH.Icon=dirIm;   
            end
            
            %%%%PLOT SIGNAL
            function plot_sigButtonPushed(app, event)
            signal_for_plot=getappdata(0,'signal_for_plot');
            name_for_plot=getappdata(0,'name_for_plot');
            fig_signalplot = uifigure('Position',[550, 100, 400, 400]); %OPEN FIGURE
            pltlbl = uilabel(fig_signalplot,'Position',[50, 350, 350, 30]);
            pltlbl.Text = name_for_plot; 
            pltlbl.FontSize=18;
            axisPanel= uiaxes(fig_signalplot,'Position',[50, 50, 300, 300]);
            signallength=size(signal_for_plot,2);%%%%%ADD SCALES
            x1=linspace(1,signallength,signallength);
            x1=x1/app.SamplingFrequencyEditField.Value;
            plot(axisPanel,x1,signal_for_plot);
            drawnow
            axisPanel.XLabel.String = 'Time (s)';
                if app.VButton_2.Value==1              
                    axisPanel.YLabel.String = 'Amplitude (V)';
                elseif app.mVButton_2.Value==1
                    axisPanel.YLabel.String = 'Amplitude (mV)';
                elseif app.uVButton_2.Value==1
                    axisPanel.YLabel.String = 'Amplitude (uV)';                       
                end
            end
        end
        end

        % Button pushed function: HistogramTheshButton
        function HistogramTheshButtonPushed(app, event)
        %%%FAILSAFE #1
        RawDataInput_ts=getappdata(0,'RawDataInput_t');
        if isempty(RawDataInput_ts)==1
        errordlg('Nothing Generated','Error');
        return
        end
        %%%%%%%%%%%%%LOAD DATA
        tope=getappdata(0,'tope');
        selectchannel=app.SelectChannelDropDown.Value;
        from=(selectchannel-1)*tope+1;
        to=(selectchannel)*tope;
        RawDataInput_ts=RawDataInput_ts(from:to,:);
        setappdata(0,'row_names_hist',RawDataInput_ts.Properties.RowNames);
        %%%%%%%%%%%%%CREATE  FIGURE
        fig_histogram = uifigure('Position',[100 100 459 736],'Name','Histogram Threshold Selection'); %OPEN FIGURE
        dataforhist=table2array(RawDataInput_ts);
        dataforhist=dataforhist(:,1);
        %%%%%%HIDDEN ITEMS
        % Create PowerDistributionLabel
        PowerDistributionLabel = uilabel(fig_histogram);
        PowerDistributionLabel.FontSize = 14;
        PowerDistributionLabel.FontWeight = 'bold';
        PowerDistributionLabel.Position = [183 694 130 33];
        PowerDistributionLabel.Text = 'Power Distribution';
        
        % Create ListBoxLabel
        ListBoxLabel = uilabel(fig_histogram);
        ListBoxLabel.HorizontalAlignment = 'right';
        ListBoxLabel.Position = [37 269 89 23];
        ListBoxLabel.Text = 'Select Window';
        ListBoxLabel.Visible=0;
        
        % Create ListBox
        ListBox = uilistbox(fig_histogram);
        ListBox.Multiselect = 'on';
        ListBox.Position = [32 67 100 200];
        ListBox.Items=RawDataInput_ts.Properties.RowNames;  
        ListBox.ItemsData=linspace(1,size(dataforhist,1),size(dataforhist,1));
        ListBox.Visible=0;
        
        % Create UIAxes_2
        UIAxes_2 = uiaxes(fig_histogram);
        UIAxes_2.Position = [151 67 286 225];
        UIAxes_2.Visible=0;
       
        % Create PlotWindowButton
        PlotWindowButton = uibutton(fig_histogram, 'push');
        PlotWindowButton.Position = [165 9 123 41];
        PlotWindowButton.Text = 'Plot Window';
        PlotWindowButton.Visible=0;
        PlotWindowButton.ButtonPushedFcn = createCallbackFcn(app, @Plot_Hist_Pushed, true);
        
        %%%%%%vISIBLE ITEMS        
        % Create  HISTOGRAM UIAxes
        Histplot = uiaxes(fig_histogram);
        Histplot.Position = [18 428 419 267];
        histogram(Histplot,dataforhist)
                
        % Create PowerThresholdSliderLabel
        PowerThresholdSliderLabel = uilabel(fig_histogram);
        PowerThresholdSliderLabel.HorizontalAlignment = 'right';
        PowerThresholdSliderLabel.Position = [184 397 96 22];
        PowerThresholdSliderLabel.Text = 'Power Threshold';
        
        % Create PowerThresholdSlider
        PowerThresholdSlider = uislider(fig_histogram);
        PowerThresholdSlider.Position = [32 385 394 3];
        minhist=min(dataforhist);
        maxhist=max(dataforhist);
        PowerThresholdSlider.Limits=[minhist,maxhist];
        PowerThresholdSlider.MajorTicksMode='auto';
        PowerThresholdSlider.MinorTicksMode='auto';
        PowerThresholdSlider.ValueChangedFcn = createCallbackFcn(app, @Slidermoved, true);
        hist_index_val=PowerThresholdSlider.Value;
        linea=xline(Histplot,hist_index_val,'--r','Threshold');
        
        % Create SetThresholdButton
        SetThresholdButton = uibutton(fig_histogram, 'push');
        SetThresholdButton.Position = [165 304 123 41];
        SetThresholdButton.Text = 'Set Threshold';
        SetThresholdButton.ButtonPushedFcn = createCallbackFcn(app, @SetThresholdButtonButtonPushed, true);
        
        function Slidermoved(app, ~)
        delete(linea)
        hist_index_val=PowerThresholdSlider.Value;
        linea=xline(Histplot,hist_index_val,'--r','Threshold');
        end
                
        function SetThresholdButtonButtonPushed(app, ~)
        hist_index_val_def=PowerThresholdSlider.Value;
        selectchannel=app.SelectChannelDropDown.Value;
             if selectchannel<11
             app.UITable.Data(1,selectchannel)=hist_index_val_def;
             else
             rowfortabledisplay=floor(selectchannel/10)+1;
             columnfortabledisplay=rem(selectchannel,10);
             app.UITable.Data(rowfortabledisplay,columnfortabledisplay)=hist_index_val_def;            
             end
        ListBoxLabel.Visible=1;
        ListBox.Visible=1;
        PlotWindowButton.Visible=1;
        dirIm=which('done.png');
        SetThresholdButton.Icon=dirIm;    
        setappdata(0,'hist_index_val_def',hist_index_val_def);
        end
        
        function Plot_Hist_Pushed(app, ~)
        freq=getappdata(0,'freq');        
        hist_index_val_def=getappdata(0,'hist_index_val_def');
        selectedwindowforplot=ListBox.Value;    
        selectedwindow=table2array(RawDataInput_ts(selectedwindowforplot,2:end));
        if dataforhist(selectedwindowforplot)<=hist_index_val_def
        color_4_plot='g';
        else
        color_4_plot='r';  
        end
        signallength=size(selectedwindow,2);%%%%%ADD SCALES
        x1=linspace(1,signallength,signallength);
        x1=x1/app.SamplingFrequencyEditField.Value;
        plot(UIAxes_2,x1,selectedwindow,'Color',color_4_plot)
        if app.VButton_2.Value==1              
            UIAxes_2.YLabel.String = 'Amplitude (V)';
        elseif app.mVButton_2.Value==1
            UIAxes_2.YLabel.String = 'Amplitude (mV)';
        elseif app.uVButton_2.Value==1
            UIAxes_2.YLabel.String = 'Amplitude (uV)';                       
        end
        UIAxes_2.XLabel.String = 'Time (s)';
        drawnow    
        UIAxes_2.Visible=1;
        end


        end

        % Cell selection callback: UITable
        function UITableCellSelection(app, event)
            indices = event.Indices;
            seleccionado=10*(indices(1)-1)+indices(2);
            if seleccionado>max(app.SelectChannelDropDown.ItemsData)
              seleccionado=max(app.SelectChannelDropDown.ItemsData);  
            end           
            app.SelectChannelDropDown.Value=app.SelectChannelDropDown.ItemsData(seleccionado);
        end

        % Button pushed function: LabelTableButton
        function LabelTableButtonPushed(app, event)
            RawDataInput_l=getappdata(0,'RawDataInput_t');
            %%%FAILSAFE #1
            if isempty(RawDataInput_l)==1
            errordlg('Nothing Imported','Error');
            return
            end
            %%%FAILSAFE #2
            listofchannels=max(app.SelectChannelDropDown.ItemsData);
            truncatedtable=app.UITable.Data';%%%BECAUSE FIND LOOKS VERTICALLY, SCREWING INDICES
            unfilledthresh=find(truncatedtable==0);
            unfilledthreshnan=find(isnan(truncatedtable));
            unfilledthresh=[unfilledthresh;unfilledthreshnan];
            unfilledthresh=sort(unfilledthresh);
            unfilledthresh=unfilledthresh(unfilledthresh<=listofchannels);             
            if isempty(unfilledthresh)==0  | sum(isnan(unfilledthresh))>0
                messagealert= num2str(reshape(unfilledthresh, 1, []));
                messagealert=strcat('Incomplete thresholds for channels: ',messagealert);
             errordlg(messagealert,'Error');    
            return
            end
            
            %%%%%%%%%%%%%%%%%%%%%CREATE LABELS 
            tope=getappdata(0,'tope');
            RawDataInput_l_mat= table2array(RawDataInput_l);
            collector=[];
            for contador=1:listofchannels
            labels_defined=zeros(tope,1);            
            from=(contador-1)*tope+1;
            to=(contador)*tope;
            labelligindex=find(RawDataInput_l_mat(from:to,1)>=truncatedtable(contador));           
            labels_defined(labelligindex)=1;
            collector=[collector;labels_defined];
            end
            labels_defined=array2table(collector, 'VariableNames', {'Labels'});
            RawDataInput_l.Window_Power = [];
            RawDataInput_l=[RawDataInput_l,labels_defined];
            setappdata(0,'Matrix_completed',RawDataInput_l);
            app.Label_2.Text='Matrix Labelled';
        end

        % Button pushed function: SaveButton
        function SaveButtonPushed(app, event)
            %%%FAILSAFE #1
            Matrix_completed=getappdata(0,'Matrix_completed');
            if isempty(Matrix_completed)==1
            errordlg('Matrix not Created','Error');
            return
            end
            ThresholdperChannel=reshape(app.UITable.Data,1,[]);
            ThresholdperChannel=ThresholdperChannel(:,1:max(app.SelectChannelDropDown.ItemsData)); 
            filename_rawmat=getappdata(0,'filename_rawmat');
            structured_data.filename=filename_rawmat;
            structured_data.Data = Matrix_completed;
            structured_data.SamplingFrequency=app.SamplingFrequencyEditField.Value;
            structured_data.WindowLength=app.WindowLengthEditField_2.Value;           
            structured_data.ThresholdperChannel= ThresholdperChannel;
            if app.VButton_2.Value==1              
                    structured_data.Scale = 'Volts';
            elseif app.mVButton_2.Value==1
                    structured_data.Scale = 'Millivolts';
            elseif app.uVButton_2.Value==1
                    structured_data.Scale = 'Microvolts';                       
            end  
            uisave('structured_data','structured_data.mat');
            app.Label_2.Text='Matrix Saved';
        end

        % Button pushed function: LoadTrainingDataButton
        function LoadTrainingDataButtonPushed(app, event)
            %%%CLEAR ALL VARS
            app.Label_3.Visible=0;
            appdata = get(0,'ApplicationData');
            fns = fieldnames(appdata);
            for ii = 1:numel(fns)
              rmappdata(0,fns{ii});
            end
            %%%%%LOAD
            
            [filename,pathname,filterindex] = uigetfile('*.mat');
            % if the user presses CANCEL then zero is returned so ensure character 
            % filename
            % if the user selects a filter other than the one we set (index==1) then
            % ignore the selected file
            if ischar(filename) && filterindex==1
            datInMat = whos('-file',fullfile(pathname,filename));
                if  strcmp(datInMat(1).name,'structured_data')==1
                NNTrainingInput_D=load(fullfile(pathname,filename),datInMat(1).name);
                FILE_NAME_L= NNTrainingInput_D.(datInMat(1).name).filename;                   
                NNTrainingInput_D= NNTrainingInput_D.(datInMat(1).name).Data;                   
                setappdata(0,'NNTrainingInput',NNTrainingInput_D);
                setappdata(0,'filename_rawmat',FILE_NAME_L);
                app.Label_3.Visible=1;
                app.Label_3.Text='Training Data Loaded';
                else
                msgbox('Please select a file with data structured for traning','Warning','warn');
                end
            else
                msgbox('Load Cancelled','Warning','warn');
            return
            end
        end

        % Button pushed function: SplitButton
        function SplitButtonPushed(app, event)
        NNTrainingInput=getappdata(0,'NNTrainingInput');
        %%%FAILSAFE #1
        if isempty(NNTrainingInput)==1
            errordlg('Nothing Loaded','Error');
            return
        end
        %%%FAILSAFE #2
        sumasplit=app.TrainingEditField.Value+app.ValidationEditField.Value+app.TestEditField.Value;    
            if sumasplit~=1
                errordlg('Sum of values of Train,Validation and Test split must be equal to 1 ','Error');
                return
            end  
        %%%BALANCE OF DATA
        if    app.BalanceDataCheckBox.Value==1        
            artrows=find(NNTrainingInput.Labels==1); %#OF ARTS
            len=size(artrows,1);
            normrows=find(NNTrainingInput.Labels==0);%#OF NORMAL
            rng('default')
            normrows=datasample(normrows,len,'Replace',false);%#SAMPLE NORMALS TO MATCH ARTS
            newset=sort([artrows;normrows]);
            trainingDataset= NNTrainingInput(newset, :);%#KEEP ONLY SAME NUMBER
        else
            trainingDataset=NNTrainingInput;
        end  
       setappdata(0,'MLPDATA',trainingDataset);
        %%%%%%%SPLITTING TEST            
        p =app.TrainingEditField.Value+app.ValidationEditField.Value;     % proportion of rows to select for training
        N = size(trainingDataset,1);  % total number of rows 
        tf = false(N,1);    % create logical index vector
        tf(1:round(p*N)) = true;    
        rng('default')
        tf = tf(randperm(N));  % randomise order
        dataTrainingValidation = trainingDataset(tf,:) ;
        dataTesting = trainingDataset(~tf,:) ;    
        %%%%%%%SPLITTING VALIDATION        
        p =app.TrainingEditField.Value;     % proportion of rows to select for training
        N2 = size(dataTrainingValidation,1);  % total number of leftoverrows 
        tf = false(N2,1);    % create logical index vector
        tf(1:round(p*N)) = true;    
        rng('default')
        tf = tf(randperm(N2));  % randomise order
        dataTraining = dataTrainingValidation(tf,:) ;
        dataValidation = dataTrainingValidation(~tf,:) ;      
        app.Label_3.Text='Data Split and Ready for Training';
            setappdata(0,'dataValidation',dataValidation);
            setappdata(0,'dataTraining',dataTraining);
            setappdata(0,'dataTesting',dataTesting);
        end

        % Button pushed function: CreateNetworkButton
        function CreateNetworkButtonPushed(app, event)
        dataTraining=getappdata(0,'dataTraining');
        %%%FAILSAFE #1
        if isempty(dataTraining)==1
            errordlg('Data not Split!','Error');
            return
        end
        %%%%%CHOOSE NETWORK OPTIONS
        value = str2num(app.ChooseNetworkDropDown_3.Value);
        trainingcols=size(dataTraining,2)-1;
        if value==1
            layers = [
                imageInputLayer([1  trainingcols 1],"Name","imageinput")%,"Normalization","zscore",'NormalizationDimension','all')
                convolution2dLayer([1 11],32,"Name","conv_1","Padding","same")
                reluLayer("Name","relu1")
                crossChannelNormalizationLayer(5,"Name","norm1","K",1)
                maxPooling2dLayer([1 3],"Name","pool1","Stride",[1 2])
                convolution2dLayer([1 5],64,"Name","conv_2","Padding","same")
                reluLayer("Name","relu2")
                crossChannelNormalizationLayer(5,"Name","norm2","K",1)
                maxPooling2dLayer([1 3],"Name","pool2","Stride",[1 2])
                convolution2dLayer([1 3],128,"Name","conv_3","Padding","same")
                reluLayer("Name","relu3")
                maxPooling2dLayer([1 3],"Name","pool5","Stride",[1 2])
                fullyConnectedLayer(1024,"Name","fc_1")
                reluLayer("Name","relu6")
                dropoutLayer(0.5,"Name","drop6")
                fullyConnectedLayer(512,"Name","fc_2")
                reluLayer("Name","relu7")
                dropoutLayer(0.5,"Name","drop7")
                fullyConnectedLayer(2,"Name","fc_3")
                softmaxLayer("Name","prob")
                classificationLayer("Name","classoutput")];
        elseif  value==2
            HL=round(trainingcols/10,0);
            net_1=patternnet(HL);
            net_1.trainFcn='trainscg';
            net_1.divideParam.trainRatio=app.TrainingEditField.Value;
            net_1.divideParam.valRatio=app.ValidationEditField.Value;
            net_1.divideParam.testRatio=app.TestEditField.Value;
            layers='created';%RAISE FLAG
            setappdata(0,'untrainednet',net_1)
        elseif  value==3
            [filename,pathname,filterindex] = uigetfile('*.mat');
            % if the user presses CANCEL then zero is returned so ensure character 
            % filename
            % if the user selects a filter other than the one we set (index==1) then
            % ignore the selected file
            datInMat = whos('-file',fullfile(pathname,filename));
            if ischar(filename) & filterindex==1 & strcmp(datInMat.class,'nnet.cnn.layer.Layer')==1
            Loadedthing=load(fullfile(pathname,filename),datInMat(1).name);
            layers= Loadedthing.(datInMat(1).name);
            else
            msgbox('Please select a file with a layers variable','Warning','warn');
            return
            end
       end
       app.Label_3.Text='Network Created';    
       setappdata(0,'layers',layers)
        end

        % Button pushed function: TrainNetworkButton
        function TrainNetworkButtonPushed(app, event)
        Layers=getappdata(0,'layers');
         %%%FAILSAFE #1
        if isempty(Layers)==1
            errordlg('Network was not created!','Error');
            return
        end
        value = str2num(app.ChooseNetworkDropDown_3.Value);
        if value==2%%%%%%MLP TRAINING
            dataTraining=getappdata(0,'MLPDATA');
            dataTraining=table2array(dataTraining);
            predictors=dataTraining(:,1:(end-1));
            response=dataTraining(:,end);
            predictors=normalize(predictors,'center','mean');
            UNTRAINED_NET=getappdata(0,'untrainednet');
            predictors=predictors';
            response=response';
            [net,info]=train(UNTRAINED_NET,predictors,response,'useGPU','yes');            
            scores= net(predictors(:,info.testInd));
            YPred=scores;
            YPred(YPred >= 0.5) = 1;
            YPred(YPred < 0.5) = 0;
            tTst = response(:,info.testInd);
            setappdata(0,'testTRUElabels',tTst)
            else    
            dataTraining=getappdata(0,'dataTraining');
            dataValidation=getappdata(0,'dataValidation');
            %%%%RESHAPE TRAINS FOR TRAINING
            X=table2array(dataTraining(:,1:end-1))';
            X=reshape(X, [1 size(X,1) 1 size(X,2)]);
            Y=categorical(dataTraining.Labels);
            %%%%RESHAPE VALS FOR TRAINING
            X_v=table2array(dataValidation(:,1:end-1))';
            X_v=reshape(X_v, [1 size(X_v,1) 1 size(X_v,2)]);
            Y_v=categorical(dataValidation.Labels)';    %%%%%%%%%%TRANSPOSE TO FIT TABLE
            Valtab=table(X_v,Y_v);
            Valtab=table2cell(Valtab);
            %%%%%%%LOAD OPTIONS
            if app.PlotCheckBox.Value==1
                plotoption='training-progress';
            else
                plotoption='none';
            end
            options = trainingOptions(app.SolverDropDown.Value , ...
                'InitialLearnRate',app.InitialLearnRateSpinner.Value,...
                'MaxEpochs',app.MaxEpochsSpinner.Value, ...
                'MiniBatchSize',app.MiniBatchSizeSpinner.Value, ...
                'ValidationFrequency',app.ValidationFrequencySpinner.Value,...
                'ValidationData',Valtab,...
                'InitialLearnRate',app.InitialLearnRateSpinner.Value, ...
                'ExecutionEnvironment',app.ExecutionEnviromentDropDown.Value,...
                'plots',plotoption, ...
                'Verbose',app.VerboseCheckBox.Value,...
                'VerboseFrequency', app.VerboseFrequencySpinner.Value, ...
                'L2Regularization',app.L2RegularizationSpinner.Value,...
                'GradientThresholdMethod',app.GradientThresholdMethodDropDown.Value,...
                'ResetInputNormalization',app.ResetInputNormalizationCheckBox.Value,...
                'GradientThreshold', app.GradientThresholdSpinner.Value,...
                'ValidationPatience',app.ValidationPatienceSpinner.Value,...
                'Shuffle',app.ShuffleDropDown.Value,...
                'LearnRateSchedule',app.LearnRateScheduleDropDown.Value,...
                'LearnRateDropFactor',app.LearnRateDropFactorSpinner.Value,...
                'LearnRateDropPeriod',app.LearnRateDropPeriodSpinner.Value);
            
            %%%%%%%%%%TRAIN
            [net,info] = trainNetwork(X,Y,Layers,options);
            %%%%%%%%%%%TEST SET
            dataTesting=getappdata(0,'dataTesting');
            X_t=table2array(dataTesting(:,1:end-1))';
            X_t=reshape(X_t, [1 size(X_t,1) 1 size(X_t,2)]);
            Y_t=categorical(dataTesting.Labels);
            [YPred,scores] = classify(net,X_t,...
                'ExecutionEnvironment',app.ExecutionEnviromentDropDown.Value,...
                'MiniBatchSize',app.MiniBatchSizeSpinner.Value);
            setappdata(0,'testTRUElabels',Y_t)
            scores=scores(:,2);
        end
            app.Label_3.Text='Training Finished';
            setappdata(0,'trainednet',net)
            setappdata(0,'trainednetinfo',info)
            setappdata(0,'testpredlabels',YPred)
            setappdata(0,'testpredscores',scores)
        end

        % Button pushed function: TestSetResultsButton
        function TestSetResultsButtonPushed(app, event)
        YPredn=getappdata(0,'testpredlabels');
        scores=getappdata(0,'testpredscores');
        Y_t=getappdata(0,'testTRUElabels');  
        %%%FAILSAFE #1
        if isempty(YPredn)==1
            errordlg('Network was not trained!','Error');
            return
        end
        %%%%%%VALUES FOR PLOTS
        value = str2num(app.TestSetResultsPlotDropDown.Value);
        confusion_mat=confusionmat(Y_t,YPredn);
        TN=confusion_mat(1,1);
        FP=confusion_mat(1,2);
        FN=confusion_mat(2,1);
        TP=confusion_mat(2,2);
        f1score=2*TP/(2*TP+FN+FP);
        acc=(TP+TN)/(TN+TP+FP+FN);
        thresh=0.5;
        [Xval,Yval,~,auc] = perfcurve(Y_t,scores,1) ;
        setappdata(0,'testsetf1',f1score)
        setappdata(0,'testsetacc',acc)
        setappdata(0,'confusion_mat',confusion_mat)
        setappdata(0,'nnclassthreshvalue',thresh)
        setappdata(0,'auroc',auc)
       if value==1 %%%%%%CM
        plotconfusion(Y_t,YPredn)    
       elseif value==2 %%%%%AUROC
            fig_signalplot = uifigure('Position',[550, 100, 400, 400]); %OPEN FIGURE
            pltlbl = uilabel(fig_signalplot,'Position',[100, 350, 350, 30]);
            strauc=num2str(auc);
            strtit=strcat('Test Set ROC, AUC= ',strauc);
            pltlbl.Text = strtit;
            pltlbl.FontSize=18;
            axisPanel= uiaxes(fig_signalplot,'Position',[50, 50, 300, 300]);
            plot(axisPanel,Xval,Yval);
            axisPanel.XLabel.String = 'False positive rate';
            axisPanel.YLabel.String = 'True positive rate';
       else   
            %%%%TRESH SELECT FIG
            fig_mconfmat= uifigure('Position',[550, 100, 400, 600]); %OPEN FIGURE
            cnfmat=confusionchart(fig_mconfmat,Y_t,YPredn,'Title','Test Confusion Matrix','Position',[0.25 0.4 0.5 0.5]);        
            %%%%TEXT        
            pltlbl2 = uilabel(fig_mconfmat,'Position',[40, 165, 440, 30]);
            acc2num=num2str(acc);
            f1sc2num=num2str(f1score);
            str = strcat('Accuracy:',acc2num,' and F1 score:',f1sc2num); 
            pltlbl2.Text = str; 
            pltlbl2.FontSize=18;
            pltlbl2.FontWeight ='bold';
            %%%%%SPINNER
            pltlbl3 = uilabel(fig_mconfmat,'Position',[130, 120, 200, 30]);
            pltlbl3.Text = 'Classification Threshold'; 
            sld = uispinner(fig_mconfmat,'Position',[150, 90, 100, 22]);
            sld.Limits = [0 1];
            sld.Value = 0.5;
            sld.Step=0.1;
            %%%%%BUTTON
            SELECT_TH2= uibutton(fig_mconfmat);
            SELECT_TH2.ButtonPushedFcn = createCallbackFcn(app, @(btn,event) updateTable(sld,Y_t,scores,pltlbl2), true);
            SELECT_TH2.Position = [120, 25, 150, 50];
            SELECT_TH2.Text = 'Select Threshold value';                  
       end
            function updateTable(sld,Y_t,scores,pltlbl2)
                setappdata(0,'nnclassthreshvalue',sld.Value)
                dirIm=which('done.png');
                SELECT_TH2.Icon=dirIm;   
                %%%%DEF LABELS
                YPred2=scores;
                YPred2(YPred2>=sld.Value)=1;
                YPred2(YPred2<sld.Value)=0;
                if iscategorical(Y_t)==1
                    YPred2=categorical(YPred2);
                end
                %%%%C MATRIX
                delete(cnfmat)
                cnfmat=confusionchart(fig_mconfmat,Y_t,YPred2,'Title','Test Confusion Matrix','Position',[0.25 0.4 0.5 0.5]);
                drawnow
                %%%%VALUES
                confusion_mat=confusionmat(Y_t,YPred2);
                TN=confusion_mat(1,1);
                FP=confusion_mat(1,2);
                FN=confusion_mat(2,1);
                TP=confusion_mat(2,2);
                f1score=2*TP/(2*TP+FN+FP);
                acc=(TP+TN)/(TN+TP+FP+FN);
                setappdata(0,'testsetf1',f1score)
                setappdata(0,'testsetacc',acc)
                setappdata(0,'nnclassthreshvalue',sld.Value)
                setappdata(0,'confusion_mat',confusion_mat)
                %%%%%%%%%%%%%%%TEXT
                acc2num=num2str(acc);
                f1sc2num=num2str(f1score);
                str = strcat('Accuracy:',acc2num,' and F1 score:',f1sc2num);
                pltlbl2.Text = str;
            end
        app.Label_3.Text='Test Set Classified';
        end

        % Button pushed function: SaveResultsButton
        function SaveResultsButtonPushed(app, event)
             %%FAILSAFE #1
            nnclassthreshvalue=getappdata(0,'nnclassthreshvalue');
            if isempty(nnclassthreshvalue)==1
            errordlg('Test set not classified','Error');
            return
            end
            trainednet=getappdata(0,'trainednet');
            info=getappdata(0,'trainednetinfo');
            testsetacc=getappdata(0,'testsetacc');    
            confusion_mat=getappdata(0,'confusion_mat');   
            filename_rawmat=getappdata(0,'filename_rawmat');
            f1score=getappdata(0,'testsetf1');
            AUROC=getappdata(0,'auroc');
            trainednetandresult.filename=filename_rawmat;
            trainednetandresult.trained_net=trainednet;
            trainednetandresult.info=info;
            trainednetandresult.threshold_value=nnclassthreshvalue;
            trainednetandresult.test_set_confusion_mat=confusion_mat;
            trainednetandresult.test_set_acc=testsetacc;
            trainednetandresult.test_set_f1score=f1score;
            trainednetandresult.test_set_AUROC=AUROC;
            uisave('trainednetandresult','trainednetandresult.mat');
            app.Label_3.Text='Matrix Saved';
        end

        % Button pushed function: OpenSigMateButton
        function OpenSigMateButtonPushed(app, event)
        wkdir='SigMate';
        fname='FirstGUI.m';
        if isfile(fullfile(wkdir,fname))
            run(fullfile(wkdir,fname))
        else
            msgbox('Change Path to SANTIA','Warning','warn');
            return
        end
%         dirSIG=which('FirstGUI.m');
%         %%%%control
%         if isempty(dirSIG)==1
%         msgbox('Change Path to SANTIA','Warning','warn');
%         return
%         else
%         run(dirSIG)
%         end
        end

        % Button pushed function: LoadTrainedNetButton
        function LoadTrainedNetButtonPushed(app, event)
            app.Label_4.Visible='off';
            [filename,pathname,filterindex] = uigetfile('*.mat');
            % if the user presses CANCEL then zero is returned so ensure character 
            % filename
            % if the user selects a filter other than the one we set (index==1) then
            % ignore the selected file
            if ischar(filename) && filterindex==1
            datInMat = whos('-file',fullfile(pathname,filename));
                if  strcmp(datInMat(1).name,'trainednetandresult')==1
                NNtrained_n=load(fullfile(pathname,filename),datInMat(1).name);
                NNtrained= NNtrained_n.(datInMat(1).name).trained_net;                   
                setappdata(0,'NNtrained',NNtrained);
                class_thresh= NNtrained_n.(datInMat(1).name).threshold_value;                   
                setappdata(0,'class_thresh',class_thresh);
                app.Label_4.Visible='on';
                app.Label_4.Text='Trained Network Loaded';
                else
                msgbox('Please select a file with a trained network saved from the app','Warning','warn');
                end
            else
                msgbox('Load Cancelled','Warning','warn');
            return
            end         
        end

        % Value changed function: ChooseNetworkDropDown_3
        function ChooseNetworkDropDown_3ValueChanged(app, event)
            value = str2num(app.ChooseNetworkDropDown_3.Value);
            if value==2
                app.TrainingoptionsPanel.Visible='off';
            else
                app.TrainingoptionsPanel.Visible='on';
            end
        end

        % Button pushed function: LoadUnlabelledDataButton_3
        function LoadUnlabelledDataButtonPushed(app, event)
            [filename,pathname,filterindex] = uigetfile('*.mat');
            % if the user presses CANCEL then zero is returned so ensure character 
            % filename
            % if the user selects a filter other than the one we set (index==1) then
            % ignore the selected file
            if ischar(filename) && filterindex==1
            datInMat = whos('-file',fullfile(pathname,filename));
                if  strcmp(datInMat(1).name,'structured_data')==1
                NNnewtestdata=load(fullfile(pathname,filename),datInMat(1).name);
                freq=NNnewtestdata.(datInMat(1).name).SamplingFrequency;
                amp=NNnewtestdata.(datInMat(1).name).Scale;
                FILE_NAME_UL= NNnewtestdata.(datInMat(1).name).filename;                   
                setappdata(0,'filename_rawmat',FILE_NAME_UL);
                setappdata(0,'freq', freq);
                setappdata(0,'amp',amp);                
                NNnewtestdata= NNnewtestdata.(datInMat(1).name).Data;
                namesforsaving=NNnewtestdata.Properties.RowNames;
                setappdata(0,'namesforsaving', namesforsaving);
                setappdata(0,'NNnewtestdata',NNnewtestdata);
                app.Label_4.Text='New Test Data Loaded';
                app.SelectWindowListBox.Items=namesforsaving;
                tot_name=size(namesforsaving,1);
                app.SelectWindowListBox.ItemsData=linspace(1,tot_name,tot_name);
                app.SelectWindowListBox.Value=1;
                else
                msgbox('Please select a file with data structured for traning','Warning','warn');
                end
            else
                msgbox('Load Cancelled','Warning','warn');
            return
            end            
        end

        % Value changed function: ClassifyButton_3
        function ClassifyButtonValueChanged(app, event)
        Trainednet=getappdata(0,'NNtrained');
        %%%FAILSAFE #1
        if isempty(Trainednet)==1
            errordlg('Trained network has not been loaded!','Error');
            return
        end
        %%%FAILSAFE #2
        NNnewtestdata=getappdata(0,'NNnewtestdata');
        if isempty(NNnewtestdata)==1
            errordlg('New test data has not been loaded!','Error');
            return
        end
        %%%FAILSAFE #3       
        if isa(Trainednet,'SeriesNetwork')==1
             if Trainednet.Layers(1, 1).InputSize(2) ~=  size(NNnewtestdata,2)
             errordlg('New test data doesnt match input size of network!','Error');
             return
             else
             X_Nte=table2array(NNnewtestdata)';
             X_Nte=reshape(X_Nte, [1 size(X_Nte,1) 1 size(X_Nte,2)]);
             [~,scores_te] = classify(Trainednet,X_Nte,...
                 'ExecutionEnvironment',app.ExecutionEnviromentDropDown.Value,...
                 'MiniBatchSize',app.MiniBatchSizeSpinner.Value);  
             predLabel_nte=scores_te(:,2);
             end
        elseif  isa(Trainednet,'network')==1
            if cell2mat(Trainednet.inputs.size) ~=  size(NNnewtestdata,2)
            errordlg('New test data doesnt match input size of network!','Error');
            return
            else
            predictors=table2array(NNnewtestdata);
            predictors=normalize(predictors,'center','mean');
            predictors=predictors';
            predLabel_nte= Trainednet(predictors);              
            end
        end
        nnclassthreshvalue=getappdata(0,'class_thresh');  
        predLabel_nte(predLabel_nte>=nnclassthreshvalue)=1;
        predLabel_nte(predLabel_nte<nnclassthreshvalue)=0;   
        predLabel_nte=categorical(predLabel_nte);
        setappdata(0,'predLabel_nte',predLabel_nte)
        app.Label_4.Text='New Test Set Classified';
        %%%SHOW
        app.ClassifyButton_3.Value=0;
        app.ClassificationResultLabel.Visible='on';
        app.PlotandShowClassButton.Visible='on';
        app.SelectWindowListBox.Visible='on';
        app.SelectWindowListBoxLabel.Visible='on';
        end

        % Button pushed function: PlotandShowClassButton
        function PlotandShowClassButtonPushed(app, event)
            NNnewtestdata=getappdata(0,'NNnewtestdata');
            selectedwindow=table2array(NNnewtestdata(app.SelectWindowListBox.Value,:));
            predLabel_nte=getappdata(0,'predLabel_nte');
            selectedlabel=str2num(char(predLabel_nte(app.SelectWindowListBox.Value)));            
            app.NormalLabel.Visible='on';
            if selectedlabel ==1 
            app.NormalLabel.Text='Artifact';
            else
            app.NormalLabel.Text='Normal';
            end
            freq=getappdata(0,'freq');
            signallength=size(selectedwindow,2);%%%%%ADD SCALES
            x1=linspace(1,signallength,signallength);
            x1=x1/freq;
            plot(app.UIAxes,x1,selectedwindow)
            amp=getappdata(0,'amp');
            app.UIAxes.YLabel.String = strcat('Amplitude','(',amp,')');
            app.UIAxes.XLabel.String = 'Time (s)';
            drawnow
            app.UIAxes.Visible=1;
        end

        % Button pushed function: SaveButton_2
        function SaveButton_2Pushed(app, event)
            predLabel_nte=getappdata(0,'predLabel_nte');
            if isempty(predLabel_nte)==1
            errordlg('New test set not classified','Error');
            return
            end
            namesforsaving=getappdata(0,'namesforsaving');
            predicted_labels=table(predLabel_nte,'RowNames',namesforsaving,'VariableNames',{'Label'});
            filename_rawmat=getappdata(0,'filename_rawmat');
            NEWDATAclassificationresults.filename=filename_rawmat;
            NEWDATAclassificationresults.labels=predicted_labels;
            uisave('NEWDATAclassificationresults','NEWDATAclassificationresults');
            app.Label_4.Text='Classification results saved';
        end

        % Button pushed function: LoadTrainingDataButton_2
        function LoadTrainingDataButton_2Pushed(app, event)
            %%%CLEAR ALL VARS
            app.Label_5.Visible=0;
            appdata = get(0,'ApplicationData');
            fns = fieldnames(appdata);
            for ii = 1:numel(fns)
            rmappdata(0,fns{ii});
            end
            %%%%%LOAD            
            [filename,pathname,filterindex] = uigetfile('*.mat');
            % if the user presses CANCEL then zero is returned so ensure character 
            % filename
            % if the user selects a filter other than the one we set (index==1) then
            % ignore the selected file
            if ischar(filename) && filterindex==1
            datInMat = whos('-file',fullfile(pathname,filename));
            if  strcmp(datInMat(1).name,'structured_data')==1
            NNTrainingInput_D=load(fullfile(pathname,filename),datInMat(1).name);
            loaded_file_name= NNTrainingInput_D.(datInMat(1).name).filename;                   
            loaded_labelled_data= NNTrainingInput_D.(datInMat(1).name).Data;   
            loaded_thresh=NNTrainingInput_D.structured_data.ThresholdperChannel;
            loaded_wl=NNTrainingInput_D.(datInMat(1).name).WindowLength;
            loaded_sf=NNTrainingInput_D.(datInMat(1).name).SamplingFrequency;
            loaded_scale=NNTrainingInput_D.(datInMat(1).name).Scale;
            wind_dat_point=loaded_wl*loaded_sf;
            %%%%save them as var for later
            setappdata(0,'loaded_labelled_data',loaded_labelled_data);
            setappdata(0,'loaded_file_name',loaded_file_name);
            setappdata(0,'loaded_thresh',loaded_thresh);
            setappdata(0,'loaded_wl',loaded_wl);
            setappdata(0,'loaded_sf',loaded_sf);
            setappdata(0,'loaded_scale', loaded_scale);
            setappdata(0,'wind_dat_point',wind_dat_point);
            app.Label_5.Visible=1;
            app.Label_5.Text='Training Data Loaded';
            
            %%%%NUMBER OF CHANNELS FOR TABLE AND DROP DOWN ITEMS
            number_of_channels=size(loaded_thresh,2); 
            channellist=strings;
            for p=1:number_of_channels
                p_st=num2str(p); 
                channellist(p)=strcat('channel_',p_st);
                chval(p)=p;
            end
            app.SelectChannelDropDown_2.Items=channellist;
            app.SelectChannelDropDown_2.ItemsData=chval;
            
            else
            msgbox('Please select a file with data structured for traning','Warning','warn');
            end
            else
            msgbox('Load Cancelled','Warning','warn');
            return
            end
                        
        end

        % Button pushed function: ExtractArtifactfreeSegmentsButton
        function ExtractArtifactfreeSegmentsButtonPushed(app, event)
            labelled_table=getappdata(0,'loaded_labelled_data');%load table
            %%%FAILSAFE #1
            if isempty(labelled_table)==1
                errordlg('Data not loaded','Error');
                return
            end
            %%%failsafe 2
            value = app.SegmentLengthmSEditField.Value;                       
            wl=getappdata(0,'loaded_wl')*1000;
            r= rem(value,wl);
            if r~=0
                errordlg('Must be multiple of the window length used for labelling','Error');
                return
            end
            %%%%%%%
            threshold_per_bin_per_ch=labelled_table(:,end);            
            threshold_per_bin_per_ch=table2array(threshold_per_bin_per_ch); %get labels
            ThresholdperChannel=getappdata(0,'loaded_thresh');                
            row_channel_indx=size(ThresholdperChannel,2); 
            threshold_per_bin_per_ch=reshape(threshold_per_bin_per_ch',[],row_channel_indx)';%reshape
            labelled_signals=table2array(labelled_table(:,1:end-1)); %get signal
            labelled_signals=reshape(labelled_signals',[], row_channel_indx)'; %reshape
            window_length=getappdata(0,'loaded_wl');
            labelrows=size(threshold_per_bin_per_ch,1);
            labelcols=size(threshold_per_bin_per_ch,2);
            storage=[];
            numberofwindows=app.SegmentLengthmSEditField.Value/(window_length*1000);
            h = waitbar(0,'Extracting Segments');
                for j=1:labelrows
                    NORMCOUNT=0;
                    for k=1:labelcols
                        if   threshold_per_bin_per_ch(j,k)==0
                            NORMCOUNT=NORMCOUNT+1;
                            if NORMCOUNT==numberofwindows
                                storage=[storage; labelled_signals(j, k*100-NORMCOUNT*100+1 : k*100)];
                                NORMCOUNT=0;
                            end
                        else
                            NORMCOUNT=0;
                        end
                       percentage= (k+(labelcols*(j-1))) / (labelcols*labelrows);
                       waitbar(percentage,h,'Extracting Segments');
                    end
                end
                close(h);
        amount_segments=size(storage,1);
        message= ['Amount of normal segments extracted are: ' num2str(amount_segments) ];
        helpdlg(message, 'Notice')
        setappdata(0,'normal_segments_struct',storage); 
        app.Label_5.Text='Normal segments extracted';
        end

        % Button pushed function: TrainNetworkButton_2
        function TrainNetworkButton_2Pushed(app, event)
        Normal_seg_TrainingInput=getappdata(0,'normal_segments_struct');
        %%%FAILSAFE #1
        if isempty(Normal_seg_TrainingInput)==1
            errordlg('Normal segments not extracted','Error');
            return
        end
        %%%FAILSAFE #2
        sumasplit=app.TrainingEditField_2.Value+app.ValidationEditField_2.Value+app.TestEditField_2.Value;    
            if sumasplit~=1
                errordlg('Sum of values of Train,Validation and Test split must be equal to 1 ','Error');
                return
            end  
        %%%FAILSAFE #3
        sumasplit=   app.NNInputEditField.Value+ app.NNOutputEditField.Value+app.DataforModelTestingEditField.Value;    
            if sumasplit > app.SegmentLengthmSEditField.Value
                errordlg('Sum of values of input, output and data for test must be smaller than the segment lenght','Error');
                return
            end    
        %%%FAILSAFE #4
        value = app.NNInputEditField.Value;
        if app.DatapointsButton.Value == true
            wl=getappdata(0,'loaded_wl')*getappdata(0,'loaded_sf');
        elseif app.mSButton.Value == true
            wl=getappdata(0,'loaded_wl')*1000;
        end
        r= rem(value,wl);
        if r~=0
            errordlg('NN Input must be multiple of the window length used for labelling','Error');
            return
        end        
        %%FAILSAFE #5
        r2= rem(app.DataforModelTestingEditField.Value,app.NNOutputEditField.Value);
        if r2~=0
            errordlg('DataforModelTesting ust be multiple of the NNoutput','Error');             
            return
        end
        %%%%%%%%%%%%%%%%%%%%%%CREATE NETWORK
        if app.DatapointsButton.Value == true
        inputSize=app.NNInputEditField.Value;
        numHiddenUnits=inputSize/10;
        numResponses=app.NNOutputEditField.Value;
        test_seq_len= app.DataforModelTestingEditField.Value;
        elseif app.mSButton.Value == true %%%if milliseconds
        smp_freq=getappdata(0,'loaded_sf');
        inputSize=app.NNInputEditField.Value*smp_freq/1000; %scale to a second divide by sampling rate
        numHiddenUnits=inputSize/10;
        numResponses=app.NNOutputEditField.Value*smp_freq/1000;
        test_seq_len= app.DataforModelTestingEditField.Value*smp_freq/1000;
        end
        Layers = [ ...
        sequenceInputLayer(inputSize)
        lstmLayer(numHiddenUnits)
        fullyConnectedLayer(numResponses)
        regressionLayer];  
        %%%%%%%SPLITTING data  
        out_seq_start=inputSize+1;
        out_seq_end=inputSize+numResponses;
        test_seq_end= inputSize+test_seq_len;
        [trainInd,valInd,testInd] = dividerand(Normal_seg_TrainingInput',app.TrainingEditField_2.Value,app.ValidationEditField_2.Value,app.TestEditField_2.Value);      
        X_t= trainInd (1:inputSize,:);
        X_v= valInd (1:inputSize,:);        
        Y_t= trainInd (out_seq_start:out_seq_end,:);
        Y_v= valInd (out_seq_start:out_seq_end,:);        
        X_e= testInd (1:inputSize,:);
        Y_e= testInd (out_seq_start:test_seq_end,:);       
        Valtab={X_v,Y_v};
        clear X_v Y_v trainInd valInd testInd
        %%%%%%%LOAD OPTIONS
        if app.PlotCheckBox_2.Value==1
            plotoption='training-progress';
        else
            plotoption='none';
        end
        options = trainingOptions(app.SolverDropDown_2.Value , ...
            'InitialLearnRate',app.InitialLearnRateSpinner_2.Value,...
            'MaxEpochs',app.MaxEpochsSpinner_2.Value, ...
            'MiniBatchSize',app.MiniBatchSizeSpinner_2.Value, ...
            'ValidationFrequency',app.ValidationFrequencySpinner_2.Value,...
            'ValidationData',Valtab,...
            'InitialLearnRate',app.InitialLearnRateSpinner_2.Value, ...
            'ExecutionEnvironment',app.ExecutionEnviromentDropDown_2.Value,...
            'plots',plotoption, ...
            'Verbose',app.VerboseCheckBox_2.Value,...
            'VerboseFrequency', app.VerboseFrequencySpinner_2.Value, ...
            'L2Regularization',app.L2RegularizationSpinner_2.Value,...
            'GradientThresholdMethod',app.GradientThresholdMethodDropDown_2.Value,...
            'ResetInputNormalization',app.ResetInputNormalizationCheckBox_2.Value,...
            'GradientThreshold', app.GradientThresholdSpinner_2.Value,...
            'ValidationPatience',app.ValidationPatienceSpinner_2.Value,...
            'Shuffle',app.ShuffleDropDown_2.Value,...
            'LearnRateSchedule',app.LearnRateScheduleDropDown_2.Value,...
            'LearnRateDropFactor',app.LearnRateDropFactorSpinner_2.Value,...
            'LearnRateDropPeriod',app.LearnRateDropPeriodSpinner_2.Value);            
        %%%%%%%%%%TRAIN
        [net,info] = trainNetwork(X_t,Y_t,Layers,options);
        %%%%%%%%%%%TEST SET        
        data=X_e;
        test_nn_output=[];
        iteration_total=round(test_seq_len/numResponses,0); 
        pred_start=numResponses+1;
        for i=1:iteration_total
        YPred = predict(net,data);
        newdata= [data(pred_start:end,:);YPred];
        data=newdata;   
        test_nn_output=[test_nn_output;YPred];
        end        
        n_examples=size(X_e,2);
        rmse_v=sqrt(sum((test_nn_output(:)- Y_e(:)).^2)/n_examples);        
        message= ['Test set root mean square error: ' num2str( rmse_v) ];
        helpdlg(message, 'Notice')
        app.Label_5.Text='Training Finished';
        setappdata(0,'trainednet',net)
        setappdata(0,'nninputzise',inputSize)
        setappdata(0,'nnoutputzise',numResponses)
        setappdata(0,'trainednetinfo',info)
        setappdata(0,'testrmse',rmse_v)        
        setappdata(0,'OGsegment',Y_e)
        setappdata(0,'Replacedsegment',test_nn_output)
        end

        % Button pushed function: ViewTestResultsButton
        function ViewTestResultsButtonPushed(app, event)
            test_set_process=getappdata(0,'Replacedsegment');
            %%%FAILSAFE #1
            if isempty(test_set_process)==1
                errordlg('Network not trained','Error');
                return
            end
            fig_test_set_plot= uifigure('Name','Test Set Plots','Position',[550, 100, 800, 600]); %OPEN FIGURE         
            number_of_examples=size(test_set_process,2); 
            examplelist=strings;
            for p=1:number_of_examples
                p_st=num2str(p); 
                examplelist(p)=strcat('test_example_',p_st);
                exampleval(p)=p;
            end
            scale=getappdata(0,'loaded_scale');
            sf=getappdata(0,'loaded_sf');
            lbox = uilistbox(fig_test_set_plot,'Items',examplelist, 'ItemsData',exampleval,'Position',[50 50 200 500], 'ValueChangedFcn',@selectionChanged);
            axisPanel=uiaxes(fig_test_set_plot,'Position',[300, 50, 400, 500]);  
            pltlbl = uilabel(fig_test_set_plot,'Position',[350, 550, 400, 50]);
            pltlbl.Text ='Choose Example';
            
            function selectionChanged(src,event) 
            test_set_process=getappdata(0,'Replacedsegment');
            test_set_raw=getappdata(0,'OGsegment');
            pltlbl.Text = examplelist(lbox.Value); 
            pltlbl.FontSize=18;            
            proc_signal_for_plot=test_set_process(:,lbox.Value);
            raw_signal_for_plot=test_set_raw(:,lbox.Value);
            signallength=size(proc_signal_for_plot,1);
            x1=linspace(1,signallength,signallength);
            x1=x1/sf;
            raw=plot(axisPanel,x1,raw_signal_for_plot,'Color','r');
            hold(axisPanel,'on')
            proc=plot(axisPanel,x1,proc_signal_for_plot,'Color','b');
            drawnow
            axisPanel.XLabel.String = 'Time (s)';      
            axisPanel.YLabel.String = strcat('Amplitude',scale);    
            hold(axisPanel,'off')
            end
        end

        % Button pushed function: ReplaceSegmentsButton
        function ReplaceSegmentsButtonPushed(app, event)
        trained_net=getappdata(0,'trainednet');
        %%%FAILSAFE #1
        if isempty(trained_net)==1
            errordlg('Network not trained','Error');
            return
        end
        labelled_table=getappdata(0,'loaded_labelled_data');%load table
        threshold_per_bin_per_ch=labelled_table(:,end);            
        threshold_per_bin_per_ch=table2array(threshold_per_bin_per_ch); %get labels
        ThresholdperChannel=getappdata(0,'loaded_thresh');                
        row_channel_indx=size(ThresholdperChannel,2); 
        threshold_per_bin_per_ch=reshape(threshold_per_bin_per_ch',[],row_channel_indx)';%reshape
        labelled_signals=table2array(labelled_table(:,1:end-1)); %get signal
        labelled_signals=reshape(labelled_signals',[], row_channel_indx)'; %reshape     
        setappdata(0,'per_channel_signal_unprocess',labelled_signals)        
        labelrows=size(threshold_per_bin_per_ch,1);
        labelcols=size(threshold_per_bin_per_ch,2);
        window_datapoints=getappdata(0,'wind_dat_point');
        nn_input=getappdata(0,'nninputzise');    
        nn_output=getappdata(0,'nnoutputzise');            
        nn_input_w_numb=nn_input/window_datapoints; %number ofwindows are the input        
        nn_onput_w_numb=window_datapoints/nn_output; %number of outputs to fill a window
        net=getappdata(0,'trainednet');
        %%%%%%%%%%REPLACE
        h = waitbar(0,'Replacing Segments');
        for j=1:labelrows
            for k= (nn_input_w_numb+1):labelcols
                if threshold_per_bin_per_ch(j,k)==1
                        data=labelled_signals(j, ((k-1-nn_input_w_numb)*window_datapoints+1 : (k-1)*window_datapoints))';
                        for l=1:nn_onput_w_numb
                        YPred = predict(net,data);                        
                        newdata= [data(nn_output+1:end,:);YPred];
                        data=newdata;    
                        end
                    labelled_signals(j, ((k-1)*window_datapoints+1 : k*window_datapoints))=data(end-window_datapoints+1:end)';
                end             
                 percentage= (k+(labelcols*(j-1))) / (labelcols*labelrows);
                 waitbar(percentage,h,'Replacing Segments');
            end
        end
        close(h);
        app.Label_5.Text='Segments Replaced';
        setappdata(0,'per_channel_signal_process',labelled_signals)        
        end

        % Button pushed function: PlotchannelButton
        function PlotchannelButtonPushed(app, event)
        processed_signals=getappdata(0,'per_channel_signal_process');
        %%%FAILSAFE #1
        if isempty(processed_signals)==1
            errordlg('Segments not replaced','Error');
            return
        end     
        unprocessed_signals=getappdata(0,'per_channel_signal_unprocess');
        index=app.SelectChannelDropDown_2.Value;   
        signallength=size(unprocessed_signals,2);%%%%%ADD SCALES
        x1=linspace(1,signallength,signallength);
        sf=getappdata(0,'loaded_sf');
        x1=x1/sf;        
        scale=getappdata(0,'loaded_scale');
        subplot(2,1,1),plot(x1,unprocessed_signals(index,:),'Color','r')
        title('Original Signal')
        xlabel('Time(s)') 
        ylabel(scale) 
        subplot(2,1,2),plot(x1,processed_signals(index,:),'Color','b')
        title('Signal with Artifacts Removed')
        xlabel('Time(s)') 
        ylabel(scale) 
        end

        % Button pushed function: SaveResultsButton_2
        function SaveResultsButton_2Pushed(app, event)
            processed_signals=getappdata(0,'per_channel_signal_process');
            %%%FAILSAFE #1
            if isempty(processed_signals)==1
                errordlg('Segments not replaced','Error');
                return
            end
            removal_trainednet_and_result.filename=getappdata(0,'loaded_file_name');
            removal_trainednet_and_result.trained_net=getappdata(0,'trainednet');
            removal_trainednet_and_result.info=getappdata(0,'trainednetinfo');
            removal_trainednet_and_result.test_rmse=getappdata(0,'testrmse');
            removal_trainednet_and_result.test_set=getappdata(0,'OGsegment');
            removal_trainednet_and_result.replaced_test_set=getappdata(0,'Replacedsegment');
            removal_trainednet_and_result.replaces_signals=getappdata(0,'per_channel_signal_process');
            uisave('removal_trainednet_and_result','removal_trainednet_and_result.mat');
            app.Label_5.Text='Matrix Saved';
        end
    end

    % Component initialization
    methods (Access = private)

        % Create UIFigure and components
        function createComponents(app)

            % Create UIFigure and hide until all components are created
            app.UIFigure = uifigure('Visible', 'off');
            app.UIFigure.Color = [0.9412 0.9412 0.9412];
            app.UIFigure.Position = [100 100 638 777];
            app.UIFigure.Name = 'MATLAB App';

            % Create TabGroup
            app.TabGroup = uitabgroup(app.UIFigure);
            app.TabGroup.Position = [19 17 602 695];

            % Create DataLabellingTab
            app.DataLabellingTab = uitab(app.TabGroup);
            app.DataLabellingTab.Title = 'Data Labelling';
            app.DataLabellingTab.BackgroundColor = [0.9412 0.9412 0.9412];

            % Create LoadSignalsButton
            app.LoadSignalsButton = uibutton(app.DataLabellingTab, 'state');
            app.LoadSignalsButton.ValueChangedFcn = createCallbackFcn(app, @LoadSignalsButtonValueChanged, true);
            app.LoadSignalsButton.Tooltip = {'Load neural recording'};
            app.LoadSignalsButton.Text = 'Load Signals';
            app.LoadSignalsButton.BackgroundColor = [0.9608 0.9608 0.9608];
            app.LoadSignalsButton.Position = [96 596 111 46];

            % Create GenerateAnalysisMatrixButton
            app.GenerateAnalysisMatrixButton = uibutton(app.DataLabellingTab, 'push');
            app.GenerateAnalysisMatrixButton.ButtonPushedFcn = createCallbackFcn(app, @GenerateAnalysisMatrixButtonPushed, true);
            app.GenerateAnalysisMatrixButton.Tooltip = {'Scale and re-size into selected window size'};
            app.GenerateAnalysisMatrixButton.Position = [97 327 148 38];
            app.GenerateAnalysisMatrixButton.Text = 'Generate Analysis Matrix';

            % Create SamplingFrequencyEditFieldLabel
            app.SamplingFrequencyEditFieldLabel = uilabel(app.DataLabellingTab);
            app.SamplingFrequencyEditFieldLabel.BackgroundColor = [0.9412 0.9412 0.9412];
            app.SamplingFrequencyEditFieldLabel.HorizontalAlignment = 'center';
            app.SamplingFrequencyEditFieldLabel.Position = [76 548 142 22];
            app.SamplingFrequencyEditFieldLabel.Text = 'Sampling Frequency (Hz)';

            % Create SamplingFrequencyEditField
            app.SamplingFrequencyEditField = uieditfield(app.DataLabellingTab, 'numeric');
            app.SamplingFrequencyEditField.Limits = [0.1 Inf];
            app.SamplingFrequencyEditField.BackgroundColor = [0.9412 0.9412 0.9412];
            app.SamplingFrequencyEditField.Tooltip = {'The recording frequency, in Hertz'};
            app.SamplingFrequencyEditField.Position = [97 513 100 22];
            app.SamplingFrequencyEditField.Value = 1000;

            % Create UnitofRecordingsButtonGroup
            app.UnitofRecordingsButtonGroup = uibuttongroup(app.DataLabellingTab);
            app.UnitofRecordingsButtonGroup.Tooltip = {'The unit of recorded electrical activity'};
            app.UnitofRecordingsButtonGroup.TitlePosition = 'centertop';
            app.UnitofRecordingsButtonGroup.Title = 'Unit of Recordings';
            app.UnitofRecordingsButtonGroup.Position = [267 443 106 127];

            % Create VButton
            app.VButton = uiradiobutton(app.UnitofRecordingsButtonGroup);
            app.VButton.Text = 'V';
            app.VButton.Position = [11 81 58 22];
            app.VButton.Value = true;

            % Create mVButton
            app.mVButton = uiradiobutton(app.UnitofRecordingsButtonGroup);
            app.mVButton.Text = 'mV';
            app.mVButton.Position = [11 39 65 22];

            % Create uVButton
            app.uVButton = uiradiobutton(app.UnitofRecordingsButtonGroup);
            app.uVButton.Text = 'uV';
            app.uVButton.Position = [11 3 65 22];

            % Create LabelTableButton
            app.LabelTableButton = uibutton(app.DataLabellingTab, 'push');
            app.LabelTableButton.ButtonPushedFcn = createCallbackFcn(app, @LabelTableButtonPushed, true);
            app.LabelTableButton.Tooltip = {'Adds the normal (0) and artifactual (1) labels to the matrix.'};
            app.LabelTableButton.Position = [160 10 114 52];
            app.LabelTableButton.Text = 'Label  Table';

            % Create WindowLength
            app.WindowLength = uilabel(app.DataLabellingTab);
            app.WindowLength.BackgroundColor = [0.9412 0.9412 0.9412];
            app.WindowLength.HorizontalAlignment = 'center';
            app.WindowLength.Position = [94 482 106 22];
            app.WindowLength.Text = 'Window Length (s)';

            % Create WindowLengthEditField_2
            app.WindowLengthEditField_2 = uieditfield(app.DataLabellingTab, 'numeric');
            app.WindowLengthEditField_2.Limits = [1e-06 Inf];
            app.WindowLengthEditField_2.ValueChangedFcn = createCallbackFcn(app, @WindowLengthEditField_2ValueChanged, true);
            app.WindowLengthEditField_2.BackgroundColor = [0.9412 0.9412 0.9412];
            app.WindowLengthEditField_2.Tooltip = {'Size of the window to analyze its power'};
            app.WindowLengthEditField_2.Position = [97 446 100 22];
            app.WindowLengthEditField_2.Value = 0.1;

            % Create ScaleButtonGroup
            app.ScaleButtonGroup = uibuttongroup(app.DataLabellingTab);
            app.ScaleButtonGroup.Tooltip = {'Scales the signals in regards to Unit of Recording.  If there is no need, click same unit here.'};
            app.ScaleButtonGroup.Title = 'Scale';
            app.ScaleButtonGroup.Position = [428 443 100 127];

            % Create VButton_2
            app.VButton_2 = uiradiobutton(app.ScaleButtonGroup);
            app.VButton_2.Text = 'V';
            app.VButton_2.Position = [11 81 58 22];
            app.VButton_2.Value = true;

            % Create mVButton_2
            app.mVButton_2 = uiradiobutton(app.ScaleButtonGroup);
            app.mVButton_2.Text = 'mV';
            app.mVButton_2.Position = [11 39 65 22];

            % Create uVButton_2
            app.uVButton_2 = uiradiobutton(app.ScaleButtonGroup);
            app.uVButton_2.Text = 'uV';
            app.uVButton_2.Position = [12 3 65 22];

            % Create SelectedThresholdValuesLabel
            app.SelectedThresholdValuesLabel = uilabel(app.DataLabellingTab);
            app.SelectedThresholdValuesLabel.FontSize = 14;
            app.SelectedThresholdValuesLabel.Position = [207 230 176 22];
            app.SelectedThresholdValuesLabel.Text = 'Selected Threshold Values:';

            % Create SaveButton
            app.SaveButton = uibutton(app.DataLabellingTab, 'push');
            app.SaveButton.ButtonPushedFcn = createCallbackFcn(app, @SaveButtonPushed, true);
            app.SaveButton.Tooltip = {'Choose a directory to save the matrix'};
            app.SaveButton.Position = [343 10 112 52];
            app.SaveButton.Text = 'Save';

            % Create SelectChannelDropDownLabel
            app.SelectChannelDropDownLabel = uilabel(app.DataLabellingTab);
            app.SelectChannelDropDownLabel.HorizontalAlignment = 'right';
            app.SelectChannelDropDownLabel.Position = [49 275 87 22];
            app.SelectChannelDropDownLabel.Text = 'Select Channel';

            % Create SelectChannelDropDown
            app.SelectChannelDropDown = uidropdown(app.DataLabellingTab);
            app.SelectChannelDropDown.Items = {'Channel 1'};
            app.SelectChannelDropDown.Position = [151 275 100 22];
            app.SelectChannelDropDown.Value = 'Channel 1';

            % Create UITable
            app.UITable = uitable(app.DataLabellingTab);
            app.UITable.ColumnName = {'1'; '2'; '3'; '4'; '5'; '6'; '7'; '8'; '9'; '10'};
            app.UITable.RowName = {'Channel 1-10'; ''};
            app.UITable.ColumnEditable = true;
            app.UITable.CellSelectionCallback = createCallbackFcn(app, @UITableCellSelection, true);
            app.UITable.Tag = 'thresholddisplay';
            app.UITable.Position = [47 69 510 155];

            % Create ThresTableButton
            app.ThresTableButton = uibutton(app.DataLabellingTab, 'push');
            app.ThresTableButton.ButtonPushedFcn = createCallbackFcn(app, @ThresTableButtonPushed, true);
            app.ThresTableButton.Tooltip = {'Allows for threshold selection and plot'};
            app.ThresTableButton.Position = [302 267 114 39];
            app.ThresTableButton.Text = 'Thres. Table';

            % Create ProgressPanel
            app.ProgressPanel = uipanel(app.DataLabellingTab);
            app.ProgressPanel.Tooltip = {'Guides user'};
            app.ProgressPanel.TitlePosition = 'centertop';
            app.ProgressPanel.Title = 'Progress';
            app.ProgressPanel.BackgroundColor = [0.9412 0.9412 0.9412];
            app.ProgressPanel.Position = [267 588 261 60];

            % Create Label_2
            app.Label_2 = uilabel(app.ProgressPanel);
            app.Label_2.HorizontalAlignment = 'center';
            app.Label_2.FontSize = 16;
            app.Label_2.FontWeight = 'bold';
            app.Label_2.FontColor = [1 0.0745 0.651];
            app.Label_2.Visible = 'off';
            app.Label_2.Position = [11 8 241 22];

            % Create SaveUnlabelledDataButton
            app.SaveUnlabelledDataButton = uibutton(app.DataLabellingTab, 'push');
            app.SaveUnlabelledDataButton.ButtonPushedFcn = createCallbackFcn(app, @SaveUnlabelledDataButtonPushed, true);
            app.SaveUnlabelledDataButton.Tooltip = {'Choose a directory to save the unlabelled matrix'};
            app.SaveUnlabelledDataButton.Position = [347 327 151 38];
            app.SaveUnlabelledDataButton.Text = 'Save Unlabelled Data';

            % Create FormatforSigMateButton
            app.FormatforSigMateButton = uibutton(app.DataLabellingTab, 'push');
            app.FormatforSigMateButton.ButtonPushedFcn = createCallbackFcn(app, @FormatforSigMateButtonPushed, true);
            app.FormatforSigMateButton.FontWeight = 'bold';
            app.FormatforSigMateButton.FontColor = [0.7412 0.2784 0.0824];
            app.FormatforSigMateButton.Tooltip = {'Format to .txt files for SigMate'};
            app.FormatforSigMateButton.Position = [97 384 152 38];
            app.FormatforSigMateButton.Text = 'Format for SigMate';

            % Create OpenSigMateButton
            app.OpenSigMateButton = uibutton(app.DataLabellingTab, 'push');
            app.OpenSigMateButton.ButtonPushedFcn = createCallbackFcn(app, @OpenSigMateButtonPushed, true);
            app.OpenSigMateButton.FontSize = 15;
            app.OpenSigMateButton.FontWeight = 'bold';
            app.OpenSigMateButton.FontColor = [0.7412 0.2784 0.0824];
            app.OpenSigMateButton.Tooltip = {'Run Sigmate Toolbox'};
            app.OpenSigMateButton.Position = [347 384 152 38];
            app.OpenSigMateButton.Text = 'Open SigMate';

            % Create HistogramTheshButton
            app.HistogramTheshButton = uibutton(app.DataLabellingTab, 'push');
            app.HistogramTheshButton.ButtonPushedFcn = createCallbackFcn(app, @HistogramTheshButtonPushed, true);
            app.HistogramTheshButton.Tooltip = {'Allows for threshold selection and plot'};
            app.HistogramTheshButton.Position = [440 267 114 39];
            app.HistogramTheshButton.Text = 'Histogram Thesh.';

            % Create NeuralNetworkTrainingTab
            app.NeuralNetworkTrainingTab = uitab(app.TabGroup);
            app.NeuralNetworkTrainingTab.Title = 'Neural Network Training';

            % Create SaveResultsButton
            app.SaveResultsButton = uibutton(app.NeuralNetworkTrainingTab, 'push');
            app.SaveResultsButton.ButtonPushedFcn = createCallbackFcn(app, @SaveResultsButtonPushed, true);
            app.SaveResultsButton.Tooltip = {'Saves trained network, training info and test classification.'};
            app.SaveResultsButton.Position = [239 10 123 60];
            app.SaveResultsButton.Text = 'Save Results';

            % Create TrainingoptionsPanel
            app.TrainingoptionsPanel = uipanel(app.NeuralNetworkTrainingTab);
            app.TrainingoptionsPanel.Title = 'Training options';
            app.TrainingoptionsPanel.Position = [302 84 278 495];

            % Create TabGroup2
            app.TabGroup2 = uitabgroup(app.TrainingoptionsPanel);
            app.TabGroup2.Position = [0 0 277 477];

            % Create BasicTab
            app.BasicTab = uitab(app.TabGroup2);
            app.BasicTab.Title = 'Basic';

            % Create PlotCheckBox
            app.PlotCheckBox = uicheckbox(app.BasicTab);
            app.PlotCheckBox.Tooltip = {'Show training process'};
            app.PlotCheckBox.Text = 'Plot';
            app.PlotCheckBox.Position = [26 131 43 22];
            app.PlotCheckBox.Value = true;

            % Create ExecutionEnviromentDropDownLabel
            app.ExecutionEnviromentDropDownLabel = uilabel(app.BasicTab);
            app.ExecutionEnviromentDropDownLabel.HorizontalAlignment = 'right';
            app.ExecutionEnviromentDropDownLabel.Position = [26 179 122 22];
            app.ExecutionEnviromentDropDownLabel.Text = 'Execution Enviroment';

            % Create ExecutionEnviromentDropDown
            app.ExecutionEnviromentDropDown = uidropdown(app.BasicTab);
            app.ExecutionEnviromentDropDown.Items = {'Auto', 'CPU', 'GPU', 'Multi-GPU', 'Parallel'};
            app.ExecutionEnviromentDropDown.ItemsData = {'auto', 'cpu', 'gpu', 'multi-gpu', 'parallel'};
            app.ExecutionEnviromentDropDown.Tooltip = {'Hardware resource for training network'};
            app.ExecutionEnviromentDropDown.Position = [156 179 100 22];
            app.ExecutionEnviromentDropDown.Value = 'auto';

            % Create SolverDropDownLabel
            app.SolverDropDownLabel = uilabel(app.BasicTab);
            app.SolverDropDownLabel.HorizontalAlignment = 'right';
            app.SolverDropDownLabel.Position = [26 421 40 22];
            app.SolverDropDownLabel.Text = 'Solver';

            % Create SolverDropDown
            app.SolverDropDown = uidropdown(app.BasicTab);
            app.SolverDropDown.Items = {'Adam', 'SGD', 'RMSProp', ''};
            app.SolverDropDown.ItemsData = {'adam', 'sgdm', 'rmsprop'};
            app.SolverDropDown.Tooltip = {'Solver for training network'};
            app.SolverDropDown.Position = [81 421 100 22];
            app.SolverDropDown.Value = 'adam';

            % Create InitialLearnRateSpinnerLabel
            app.InitialLearnRateSpinnerLabel = uilabel(app.BasicTab);
            app.InitialLearnRateSpinnerLabel.HorizontalAlignment = 'right';
            app.InitialLearnRateSpinnerLabel.Position = [26 372 90 22];
            app.InitialLearnRateSpinnerLabel.Text = 'InitialLearnRate';

            % Create InitialLearnRateSpinner
            app.InitialLearnRateSpinner = uispinner(app.BasicTab);
            app.InitialLearnRateSpinner.Step = 0.0001;
            app.InitialLearnRateSpinner.Limits = [0 1];
            app.InitialLearnRateSpinner.Tooltip = {'Initial learning rate'};
            app.InitialLearnRateSpinner.Position = [143 372 100 22];
            app.InitialLearnRateSpinner.Value = 0.0001;

            % Create ValidationFrequencySpinnerLabel
            app.ValidationFrequencySpinnerLabel = uilabel(app.BasicTab);
            app.ValidationFrequencySpinnerLabel.HorizontalAlignment = 'right';
            app.ValidationFrequencySpinnerLabel.Position = [26 323 117 22];
            app.ValidationFrequencySpinnerLabel.Text = 'Validation Frequency';

            % Create ValidationFrequencySpinner
            app.ValidationFrequencySpinner = uispinner(app.BasicTab);
            app.ValidationFrequencySpinner.Limits = [1 Inf];
            app.ValidationFrequencySpinner.Tooltip = {'Frequency of network validation'};
            app.ValidationFrequencySpinner.Position = [162 323 100 22];
            app.ValidationFrequencySpinner.Value = 50;

            % Create MaxEpochsSpinnerLabel
            app.MaxEpochsSpinnerLabel = uilabel(app.BasicTab);
            app.MaxEpochsSpinnerLabel.HorizontalAlignment = 'right';
            app.MaxEpochsSpinnerLabel.Position = [26 275 68 22];
            app.MaxEpochsSpinnerLabel.Text = 'MaxEpochs';

            % Create MaxEpochsSpinner
            app.MaxEpochsSpinner = uispinner(app.BasicTab);
            app.MaxEpochsSpinner.Limits = [1 Inf];
            app.MaxEpochsSpinner.Tooltip = {'Maximum Number of Epochs'};
            app.MaxEpochsSpinner.Position = [133 275 100 22];
            app.MaxEpochsSpinner.Value = 30;

            % Create MiniBatchSizeSpinnerLabel
            app.MiniBatchSizeSpinnerLabel = uilabel(app.BasicTab);
            app.MiniBatchSizeSpinnerLabel.HorizontalAlignment = 'right';
            app.MiniBatchSizeSpinnerLabel.Position = [26 227 82 22];
            app.MiniBatchSizeSpinnerLabel.Text = 'MiniBatchSize';

            % Create MiniBatchSizeSpinner
            app.MiniBatchSizeSpinner = uispinner(app.BasicTab);
            app.MiniBatchSizeSpinner.Limits = [1 Inf];
            app.MiniBatchSizeSpinner.Tooltip = {'Size of Mini-Batch'};
            app.MiniBatchSizeSpinner.Position = [129 227 100 22];
            app.MiniBatchSizeSpinner.Value = 128;

            % Create VerboseCheckBox
            app.VerboseCheckBox = uicheckbox(app.BasicTab);
            app.VerboseCheckBox.Tooltip = {'Verbose the training process'};
            app.VerboseCheckBox.Text = 'Verbose';
            app.VerboseCheckBox.Position = [26 83 66 22];
            app.VerboseCheckBox.Value = true;

            % Create VerboseFrequencySpinnerLabel
            app.VerboseFrequencySpinnerLabel = uilabel(app.BasicTab);
            app.VerboseFrequencySpinnerLabel.HorizontalAlignment = 'right';
            app.VerboseFrequencySpinnerLabel.Position = [21 44 110 22];
            app.VerboseFrequencySpinnerLabel.Text = 'Verbose Frequency';

            % Create VerboseFrequencySpinner
            app.VerboseFrequencySpinner = uispinner(app.BasicTab);
            app.VerboseFrequencySpinner.Limits = [1 Inf];
            app.VerboseFrequencySpinner.Tooltip = {'Frequency of verbose'};
            app.VerboseFrequencySpinner.Position = [139 44 100 22];
            app.VerboseFrequencySpinner.Value = 50;

            % Create AdvancedoptionalTab
            app.AdvancedoptionalTab = uitab(app.TabGroup2);
            app.AdvancedoptionalTab.Title = 'Advanced (optional)';

            % Create L2RegularizationSpinnerLabel
            app.L2RegularizationSpinnerLabel = uilabel(app.AdvancedoptionalTab);
            app.L2RegularizationSpinnerLabel.HorizontalAlignment = 'right';
            app.L2RegularizationSpinnerLabel.Position = [18 421 96 22];
            app.L2RegularizationSpinnerLabel.Text = 'L2Regularization';

            % Create L2RegularizationSpinner
            app.L2RegularizationSpinner = uispinner(app.AdvancedoptionalTab);
            app.L2RegularizationSpinner.Step = 0.0001;
            app.L2RegularizationSpinner.Limits = [0 Inf];
            app.L2RegularizationSpinner.Tooltip = {'Factor for L 2 regularizer'};
            app.L2RegularizationSpinner.Position = [134 421 126 22];
            app.L2RegularizationSpinner.Value = 0.0001;

            % Create GradientThresholdMethodDropDownLabel
            app.GradientThresholdMethodDropDownLabel = uilabel(app.AdvancedoptionalTab);
            app.GradientThresholdMethodDropDownLabel.HorizontalAlignment = 'right';
            app.GradientThresholdMethodDropDownLabel.Position = [18 379 145 22];
            app.GradientThresholdMethodDropDownLabel.Text = 'GradientThresholdMethod';

            % Create GradientThresholdMethodDropDown
            app.GradientThresholdMethodDropDown = uidropdown(app.AdvancedoptionalTab);
            app.GradientThresholdMethodDropDown.Items = {'l2norm', 'global-l2norm', 'absolutevalue'};
            app.GradientThresholdMethodDropDown.ItemsData = {'l2norm', 'global-l2norm', 'absolutevalue'};
            app.GradientThresholdMethodDropDown.Tooltip = {'Gradient Threshold Method'};
            app.GradientThresholdMethodDropDown.Position = [173 379 100 22];
            app.GradientThresholdMethodDropDown.Value = 'l2norm';

            % Create ResetInputNormalizationCheckBox
            app.ResetInputNormalizationCheckBox = uicheckbox(app.AdvancedoptionalTab);
            app.ResetInputNormalizationCheckBox.Tooltip = {'Option to reset input layer normalization'};
            app.ResetInputNormalizationCheckBox.Text = 'ResetInputNormalization';
            app.ResetInputNormalizationCheckBox.Position = [18 76 153 22];
            app.ResetInputNormalizationCheckBox.Value = true;

            % Create GradientThresholdSpinnerLabel
            app.GradientThresholdSpinnerLabel = uilabel(app.AdvancedoptionalTab);
            app.GradientThresholdSpinnerLabel.HorizontalAlignment = 'right';
            app.GradientThresholdSpinnerLabel.Position = [18 337 105 22];
            app.GradientThresholdSpinnerLabel.Text = 'GradientThreshold';

            % Create GradientThresholdSpinner
            app.GradientThresholdSpinner = uispinner(app.AdvancedoptionalTab);
            app.GradientThresholdSpinner.Step = 0.1;
            app.GradientThresholdSpinner.Limits = [0 Inf];
            app.GradientThresholdSpinner.Tooltip = {'Gradient Threshold'};
            app.GradientThresholdSpinner.Position = [133 337 114 22];
            app.GradientThresholdSpinner.Value = Inf;

            % Create ValidationPatienceLabel
            app.ValidationPatienceLabel = uilabel(app.AdvancedoptionalTab);
            app.ValidationPatienceLabel.HorizontalAlignment = 'right';
            app.ValidationPatienceLabel.Position = [21 294 104 22];
            app.ValidationPatienceLabel.Text = 'ValidationPatience';

            % Create ValidationPatienceSpinner
            app.ValidationPatienceSpinner = uispinner(app.AdvancedoptionalTab);
            app.ValidationPatienceSpinner.Limits = [1 Inf];
            app.ValidationPatienceSpinner.Tooltip = {'Patience of validation stopping'};
            app.ValidationPatienceSpinner.Position = [134 295 110 22];
            app.ValidationPatienceSpinner.Value = Inf;

            % Create ShuffleDropDownLabel
            app.ShuffleDropDownLabel = uilabel(app.AdvancedoptionalTab);
            app.ShuffleDropDownLabel.HorizontalAlignment = 'right';
            app.ShuffleDropDownLabel.Position = [18 251 43 22];
            app.ShuffleDropDownLabel.Text = 'Shuffle';

            % Create ShuffleDropDown
            app.ShuffleDropDown = uidropdown(app.AdvancedoptionalTab);
            app.ShuffleDropDown.Items = {'once', 'never', 'every-epoch'};
            app.ShuffleDropDown.ItemsData = {'once', 'never', 'every-epoch'};
            app.ShuffleDropDown.Tooltip = {'Option for data shuffling'};
            app.ShuffleDropDown.Position = [84 252 100 22];
            app.ShuffleDropDown.Value = 'once';

            % Create LearnRateScheduleDropDownLabel
            app.LearnRateScheduleDropDownLabel = uilabel(app.AdvancedoptionalTab);
            app.LearnRateScheduleDropDownLabel.HorizontalAlignment = 'right';
            app.LearnRateScheduleDropDownLabel.Position = [18 209 112 22];
            app.LearnRateScheduleDropDownLabel.Text = 'LearnRateSchedule';

            % Create LearnRateScheduleDropDown
            app.LearnRateScheduleDropDown = uidropdown(app.AdvancedoptionalTab);
            app.LearnRateScheduleDropDown.Items = {'none', 'piecewise'};
            app.LearnRateScheduleDropDown.ItemsData = {'none', 'piecewise'};
            app.LearnRateScheduleDropDown.Tooltip = {'Option for dropping learning rate during training'};
            app.LearnRateScheduleDropDown.Position = [148 212 100 22];
            app.LearnRateScheduleDropDown.Value = 'none';

            % Create LearnRateDropFactorSpinnerLabel
            app.LearnRateDropFactorSpinnerLabel = uilabel(app.AdvancedoptionalTab);
            app.LearnRateDropFactorSpinnerLabel.HorizontalAlignment = 'right';
            app.LearnRateDropFactorSpinnerLabel.Position = [18 163 122 22];
            app.LearnRateDropFactorSpinnerLabel.Text = 'LearnRateDropFactor';

            % Create LearnRateDropFactorSpinner
            app.LearnRateDropFactorSpinner = uispinner(app.AdvancedoptionalTab);
            app.LearnRateDropFactorSpinner.Step = 0.01;
            app.LearnRateDropFactorSpinner.Limits = [0 1];
            app.LearnRateDropFactorSpinner.Tooltip = {'Factor for dropping the learning rate'};
            app.LearnRateDropFactorSpinner.Position = [151 167 111 22];
            app.LearnRateDropFactorSpinner.Value = 0.1;

            % Create LearnRateDropPeriodSpinnerLabel
            app.LearnRateDropPeriodSpinnerLabel = uilabel(app.AdvancedoptionalTab);
            app.LearnRateDropPeriodSpinnerLabel.HorizontalAlignment = 'right';
            app.LearnRateDropPeriodSpinnerLabel.Position = [18 121 122 22];
            app.LearnRateDropPeriodSpinnerLabel.Text = 'LearnRateDropPeriod';

            % Create LearnRateDropPeriodSpinner
            app.LearnRateDropPeriodSpinner = uispinner(app.AdvancedoptionalTab);
            app.LearnRateDropPeriodSpinner.Limits = [1 Inf];
            app.LearnRateDropPeriodSpinner.Tooltip = {'Number of epochs for dropping the learning rate'};
            app.LearnRateDropPeriodSpinner.Position = [151 118 109 22];
            app.LearnRateDropPeriodSpinner.Value = 10;

            % Create MomentumSpinnerLabel
            app.MomentumSpinnerLabel = uilabel(app.AdvancedoptionalTab);
            app.MomentumSpinnerLabel.HorizontalAlignment = 'right';
            app.MomentumSpinnerLabel.Position = [18 35 66 22];
            app.MomentumSpinnerLabel.Text = 'Momentum';

            % Create MomentumSpinner
            app.MomentumSpinner = uispinner(app.AdvancedoptionalTab);
            app.MomentumSpinner.Step = 0.01;
            app.MomentumSpinner.Limits = [0 1];
            app.MomentumSpinner.Tooltip = {'Contribution of previous gradient step'};
            app.MomentumSpinner.Position = [99 35 161 22];
            app.MomentumSpinner.Value = 0.9;

            % Create NetworkTrainingPanel
            app.NetworkTrainingPanel = uipanel(app.NeuralNetworkTrainingTab);
            app.NetworkTrainingPanel.Title = 'Network Training';
            app.NetworkTrainingPanel.Position = [26 84 227 343];

            % Create TrainNetworkButton
            app.TrainNetworkButton = uibutton(app.NetworkTrainingPanel, 'push');
            app.TrainNetworkButton.ButtonPushedFcn = createCallbackFcn(app, @TrainNetworkButtonPushed, true);
            app.TrainNetworkButton.FontSize = 18;
            app.TrainNetworkButton.FontWeight = 'bold';
            app.TrainNetworkButton.FontColor = [0.0745 0.6235 1];
            app.TrainNetworkButton.Tooltip = {'Train network using training set, using the defined training options parameters.'};
            app.TrainNetworkButton.Position = [31 144 150 52];
            app.TrainNetworkButton.Text = 'Train Network';

            % Create ChooseNetworkDropDown_3Label
            app.ChooseNetworkDropDown_3Label = uilabel(app.NetworkTrainingPanel);
            app.ChooseNetworkDropDown_3Label.HorizontalAlignment = 'right';
            app.ChooseNetworkDropDown_3Label.Position = [59 288 94 22];
            app.ChooseNetworkDropDown_3Label.Text = 'Choose Network';

            % Create ChooseNetworkDropDown_3
            app.ChooseNetworkDropDown_3 = uidropdown(app.NetworkTrainingPanel);
            app.ChooseNetworkDropDown_3.Items = {'1D-CNN (prebuilt)', 'MLP (prebuilt)', 'Load Custom'};
            app.ChooseNetworkDropDown_3.ItemsData = {'1', '2', '3'};
            app.ChooseNetworkDropDown_3.ValueChangedFcn = createCallbackFcn(app, @ChooseNetworkDropDown_3ValueChanged, true);
            app.ChooseNetworkDropDown_3.Tooltip = {'Choose a neural network model.'};
            app.ChooseNetworkDropDown_3.Position = [40 262 132 22];
            app.ChooseNetworkDropDown_3.Value = '1';

            % Create CreateNetworkButton
            app.CreateNetworkButton = uibutton(app.NetworkTrainingPanel, 'push');
            app.CreateNetworkButton.ButtonPushedFcn = createCallbackFcn(app, @CreateNetworkButtonPushed, true);
            app.CreateNetworkButton.Tooltip = {'Adjust network to input size.'};
            app.CreateNetworkButton.Position = [30 212 153 33];
            app.CreateNetworkButton.Text = 'Create Network';

            % Create TestSetResultsButton
            app.TestSetResultsButton = uibutton(app.NetworkTrainingPanel, 'push');
            app.TestSetResultsButton.ButtonPushedFcn = createCallbackFcn(app, @TestSetResultsButtonPushed, true);
            app.TestSetResultsButton.Tooltip = {'Trained network classifies unseen test data and generates confusion matrix with threshold selection.'};
            app.TestSetResultsButton.Position = [31 19 150 47];
            app.TestSetResultsButton.Text = 'Test Set Results';

            % Create TestSetResultsPlotLabel
            app.TestSetResultsPlotLabel = uilabel(app.NetworkTrainingPanel);
            app.TestSetResultsPlotLabel.HorizontalAlignment = 'right';
            app.TestSetResultsPlotLabel.Position = [48 106 116 22];
            app.TestSetResultsPlotLabel.Text = 'Test Set Results Plot';

            % Create TestSetResultsPlotDropDown
            app.TestSetResultsPlotDropDown = uidropdown(app.NetworkTrainingPanel);
            app.TestSetResultsPlotDropDown.Items = {'Confusion Matrix', 'AUROC', 'Threshold Selector'};
            app.TestSetResultsPlotDropDown.ItemsData = {'1', '2', '3'};
            app.TestSetResultsPlotDropDown.Position = [32 82 148 22];
            app.TestSetResultsPlotDropDown.Value = '1';

            % Create TrainingDataPanel_2
            app.TrainingDataPanel_2 = uipanel(app.NeuralNetworkTrainingTab);
            app.TrainingDataPanel_2.Title = 'Training Data';
            app.TrainingDataPanel_2.Position = [28 443 224 217];

            % Create LoadTrainingDataButton
            app.LoadTrainingDataButton = uibutton(app.TrainingDataPanel_2, 'push');
            app.LoadTrainingDataButton.ButtonPushedFcn = createCallbackFcn(app, @LoadTrainingDataButtonPushed, true);
            app.LoadTrainingDataButton.Tooltip = {'Load data structured for NN training. '};
            app.LoadTrainingDataButton.Position = [56 142 120 45];
            app.LoadTrainingDataButton.Text = 'Load Training  Data';

            % Create TrainingEditFieldLabel
            app.TrainingEditFieldLabel = uilabel(app.TrainingDataPanel_2);
            app.TrainingEditFieldLabel.HorizontalAlignment = 'center';
            app.TrainingEditFieldLabel.Position = [9 114 48 22];
            app.TrainingEditFieldLabel.Text = 'Training';

            % Create TrainingEditField
            app.TrainingEditField = uieditfield(app.TrainingDataPanel_2, 'numeric');
            app.TrainingEditField.Limits = [0.5 1];
            app.TrainingEditField.Tooltip = {'Part of the data for training, at leat 50%.'};
            app.TrainingEditField.Position = [9 82 48 22];
            app.TrainingEditField.Value = 0.8;

            % Create ValidationEditFieldLabel
            app.ValidationEditFieldLabel = uilabel(app.TrainingDataPanel_2);
            app.ValidationEditFieldLabel.HorizontalAlignment = 'center';
            app.ValidationEditFieldLabel.Position = [82 114 57 22];
            app.ValidationEditFieldLabel.Text = 'Validation';

            % Create ValidationEditField
            app.ValidationEditField = uieditfield(app.TrainingDataPanel_2, 'numeric');
            app.ValidationEditField.Limits = [0.01 0.5];
            app.ValidationEditField.Tooltip = {'Part of the data for validation, at least 1%.'};
            app.ValidationEditField.Position = [85 82 51 22];
            app.ValidationEditField.Value = 0.1;

            % Create TestEditFieldLabel
            app.TestEditFieldLabel = uilabel(app.TrainingDataPanel_2);
            app.TestEditFieldLabel.HorizontalAlignment = 'center';
            app.TestEditFieldLabel.Position = [164 114 28 22];
            app.TestEditFieldLabel.Text = 'Test';

            % Create TestEditField
            app.TestEditField = uieditfield(app.TrainingDataPanel_2, 'numeric');
            app.TestEditField.Limits = [0.01 0.5];
            app.TestEditField.Tooltip = {'Part of the data for testing, at least 1%.'};
            app.TestEditField.Position = [157 83 52 22];
            app.TestEditField.Value = 0.1;

            % Create SplitButton
            app.SplitButton = uibutton(app.TrainingDataPanel_2, 'push');
            app.SplitButton.ButtonPushedFcn = createCallbackFcn(app, @SplitButtonPushed, true);
            app.SplitButton.Tooltip = {'Partition data into training, testing and validation sets.'};
            app.SplitButton.Position = [9 21 100 40];
            app.SplitButton.Text = 'Split';

            % Create BalanceDataCheckBox
            app.BalanceDataCheckBox = uicheckbox(app.TrainingDataPanel_2);
            app.BalanceDataCheckBox.Tooltip = {'Make number of classes equal by downsampling (highly suggested to avoid bias).'};
            app.BalanceDataCheckBox.Text = 'Balance Data';
            app.BalanceDataCheckBox.Position = [123 30 94 22];
            app.BalanceDataCheckBox.Value = true;

            % Create ProgressPanel_2
            app.ProgressPanel_2 = uipanel(app.NeuralNetworkTrainingTab);
            app.ProgressPanel_2.Tooltip = {'Guides user'};
            app.ProgressPanel_2.TitlePosition = 'centertop';
            app.ProgressPanel_2.Title = 'Progress';
            app.ProgressPanel_2.BackgroundColor = [0.9412 0.9412 0.9412];
            app.ProgressPanel_2.Position = [302 588 278 66];

            % Create Label_3
            app.Label_3 = uilabel(app.ProgressPanel_2);
            app.Label_3.HorizontalAlignment = 'center';
            app.Label_3.FontSize = 16;
            app.Label_3.FontWeight = 'bold';
            app.Label_3.FontColor = [1 0.0745 0.651];
            app.Label_3.Visible = 'off';
            app.Label_3.Position = [11 14 258 22];

            % Create ClassifyNewUnlabelledDataTab
            app.ClassifyNewUnlabelledDataTab = uitab(app.TabGroup);
            app.ClassifyNewUnlabelledDataTab.Title = 'Classify New Unlabelled Data';

            % Create UIAxes
            app.UIAxes = uiaxes(app.ClassifyNewUnlabelledDataTab);
            title(app.UIAxes, 'Signal Display')
            xlabel(app.UIAxes, 'X')
            ylabel(app.UIAxes, 'Y')
            app.UIAxes.ColorOrder = [0 0 1;1 0 0;0 0.5 0;0 0.75 0.75;0.75 0 0.75;0.75 0.75 0;0.25 0.25 0.25];
            app.UIAxes.Visible = 'off';
            app.UIAxes.Position = [224 176 278 261];

            % Create ClassificationResultLabel
            app.ClassificationResultLabel = uilabel(app.ClassifyNewUnlabelledDataTab);
            app.ClassificationResultLabel.Visible = 'off';
            app.ClassificationResultLabel.Position = [251 117 117 22];
            app.ClassificationResultLabel.Text = 'Classification Result:';

            % Create SelectWindowListBox
            app.SelectWindowListBox = uilistbox(app.ClassifyNewUnlabelledDataTab);
            app.SelectWindowListBox.Items = {};
            app.SelectWindowListBox.Visible = 'off';
            app.SelectWindowListBox.Position = [20 176 180 261];
            app.SelectWindowListBox.Value = {};

            % Create PlotandShowClassButton
            app.PlotandShowClassButton = uibutton(app.ClassifyNewUnlabelledDataTab, 'push');
            app.PlotandShowClassButton.ButtonPushedFcn = createCallbackFcn(app, @PlotandShowClassButtonPushed, true);
            app.PlotandShowClassButton.Visible = 'off';
            app.PlotandShowClassButton.Position = [42 107 135 38];
            app.PlotandShowClassButton.Text = 'Plot and Show Class';

            % Create ProgressPanel_3
            app.ProgressPanel_3 = uipanel(app.ClassifyNewUnlabelledDataTab);
            app.ProgressPanel_3.Tooltip = {'Guides user'};
            app.ProgressPanel_3.TitlePosition = 'centertop';
            app.ProgressPanel_3.Title = 'Progress';
            app.ProgressPanel_3.BackgroundColor = [0.9412 0.9412 0.9412];
            app.ProgressPanel_3.Position = [224 594 278 54];

            % Create Label_4
            app.Label_4 = uilabel(app.ProgressPanel_3);
            app.Label_4.HorizontalAlignment = 'center';
            app.Label_4.FontSize = 16;
            app.Label_4.FontWeight = 'bold';
            app.Label_4.FontColor = [1 0.0745 0.651];
            app.Label_4.Visible = 'off';
            app.Label_4.Position = [11 2 258 22];

            % Create NormalLabel
            app.NormalLabel = uilabel(app.ClassifyNewUnlabelledDataTab);
            app.NormalLabel.FontName = 'Arial Black';
            app.NormalLabel.FontSize = 18;
            app.NormalLabel.FontWeight = 'bold';
            app.NormalLabel.FontColor = [0 1 0];
            app.NormalLabel.Visible = 'off';
            app.NormalLabel.Position = [391 117 77 28];
            app.NormalLabel.Text = 'Normal';

            % Create SaveButton_2
            app.SaveButton_2 = uibutton(app.ClassifyNewUnlabelledDataTab, 'push');
            app.SaveButton_2.ButtonPushedFcn = createCallbackFcn(app, @SaveButton_2Pushed, true);
            app.SaveButton_2.Tooltip = {'Choose a directory to save the matrix'};
            app.SaveButton_2.Position = [51 27 117 43];
            app.SaveButton_2.Text = 'Save';

            % Create LoadTrainedNetButton
            app.LoadTrainedNetButton = uibutton(app.ClassifyNewUnlabelledDataTab, 'push');
            app.LoadTrainedNetButton.ButtonPushedFcn = createCallbackFcn(app, @LoadTrainedNetButtonPushed, true);
            app.LoadTrainedNetButton.Tooltip = {'Load trained network from a file saved from the app.'};
            app.LoadTrainedNetButton.Position = [44 603 131 45];
            app.LoadTrainedNetButton.Text = 'Load Trained Net';

            % Create LoadUnlabelledDataButton_3
            app.LoadUnlabelledDataButton_3 = uibutton(app.ClassifyNewUnlabelledDataTab, 'push');
            app.LoadUnlabelledDataButton_3.ButtonPushedFcn = createCallbackFcn(app, @LoadUnlabelledDataButtonPushed, true);
            app.LoadUnlabelledDataButton_3.Tooltip = {'Load new data to be classified by the trained network.'};
            app.LoadUnlabelledDataButton_3.Position = [44 527 131 45];
            app.LoadUnlabelledDataButton_3.Text = 'Load Unlabelled Data';

            % Create ClassifyButton_3
            app.ClassifyButton_3 = uibutton(app.ClassifyNewUnlabelledDataTab, 'state');
            app.ClassifyButton_3.ValueChangedFcn = createCallbackFcn(app, @ClassifyButtonValueChanged, true);
            app.ClassifyButton_3.Tooltip = {'Classify unlabelled data with created network.'};
            app.ClassifyButton_3.Text = 'Classify ';
            app.ClassifyButton_3.FontSize = 18;
            app.ClassifyButton_3.FontWeight = 'bold';
            app.ClassifyButton_3.FontColor = [0.3922 0.8314 0.0745];
            app.ClassifyButton_3.Position = [60 467 100 29];

            % Create SelectWindowListBoxLabel
            app.SelectWindowListBoxLabel = uilabel(app.ClassifyNewUnlabelledDataTab);
            app.SelectWindowListBoxLabel.HorizontalAlignment = 'right';
            app.SelectWindowListBoxLabel.Visible = 'off';
            app.SelectWindowListBoxLabel.Position = [67 436 85 22];
            app.SelectWindowListBoxLabel.Text = 'Select Window';

            % Create ArtifactRemovalTab
            app.ArtifactRemovalTab = uitab(app.TabGroup);
            app.ArtifactRemovalTab.Title = 'Artifact Removal';

            % Create SaveResultsButton_2
            app.SaveResultsButton_2 = uibutton(app.ArtifactRemovalTab, 'push');
            app.SaveResultsButton_2.ButtonPushedFcn = createCallbackFcn(app, @SaveResultsButton_2Pushed, true);
            app.SaveResultsButton_2.Tooltip = {'Saves trained network, training info and artefact-removed dataset.'};
            app.SaveResultsButton_2.Position = [245 6 123 60];
            app.SaveResultsButton_2.Text = 'Save Results';

            % Create TrainingoptionsPanel_2
            app.TrainingoptionsPanel_2 = uipanel(app.ArtifactRemovalTab);
            app.TrainingoptionsPanel_2.Title = 'Training options';
            app.TrainingoptionsPanel_2.Position = [320 69 278 495];

            % Create TabGroup2_2
            app.TabGroup2_2 = uitabgroup(app.TrainingoptionsPanel_2);
            app.TabGroup2_2.Position = [0 1 277 477];

            % Create BasicTab_2
            app.BasicTab_2 = uitab(app.TabGroup2_2);
            app.BasicTab_2.Title = 'Basic';

            % Create PlotCheckBox_2
            app.PlotCheckBox_2 = uicheckbox(app.BasicTab_2);
            app.PlotCheckBox_2.Tooltip = {'Show training process'};
            app.PlotCheckBox_2.Text = 'Plot';
            app.PlotCheckBox_2.Position = [26 131 43 22];
            app.PlotCheckBox_2.Value = true;

            % Create ExecutionEnviromentDropDown_2Label
            app.ExecutionEnviromentDropDown_2Label = uilabel(app.BasicTab_2);
            app.ExecutionEnviromentDropDown_2Label.HorizontalAlignment = 'right';
            app.ExecutionEnviromentDropDown_2Label.Position = [26 179 122 22];
            app.ExecutionEnviromentDropDown_2Label.Text = 'Execution Enviroment';

            % Create ExecutionEnviromentDropDown_2
            app.ExecutionEnviromentDropDown_2 = uidropdown(app.BasicTab_2);
            app.ExecutionEnviromentDropDown_2.Items = {'Auto', 'CPU', 'GPU', 'Multi-GPU', 'Parallel'};
            app.ExecutionEnviromentDropDown_2.ItemsData = {'auto', 'cpu', 'gpu', 'multi-gpu', 'parallel'};
            app.ExecutionEnviromentDropDown_2.Tooltip = {'Hardware resource for training network'};
            app.ExecutionEnviromentDropDown_2.Position = [156 179 100 22];
            app.ExecutionEnviromentDropDown_2.Value = 'auto';

            % Create SolverDropDown_2Label
            app.SolverDropDown_2Label = uilabel(app.BasicTab_2);
            app.SolverDropDown_2Label.HorizontalAlignment = 'right';
            app.SolverDropDown_2Label.Position = [26 421 40 22];
            app.SolverDropDown_2Label.Text = 'Solver';

            % Create SolverDropDown_2
            app.SolverDropDown_2 = uidropdown(app.BasicTab_2);
            app.SolverDropDown_2.Items = {'Adam', 'SGD', 'RMSProp', ''};
            app.SolverDropDown_2.ItemsData = {'adam', 'sgdm', 'rmsprop'};
            app.SolverDropDown_2.Tooltip = {'Solver for training network'};
            app.SolverDropDown_2.Position = [81 421 100 22];
            app.SolverDropDown_2.Value = 'adam';

            % Create InitialLearnRateSpinner_2Label
            app.InitialLearnRateSpinner_2Label = uilabel(app.BasicTab_2);
            app.InitialLearnRateSpinner_2Label.HorizontalAlignment = 'right';
            app.InitialLearnRateSpinner_2Label.Position = [26 372 90 22];
            app.InitialLearnRateSpinner_2Label.Text = 'InitialLearnRate';

            % Create InitialLearnRateSpinner_2
            app.InitialLearnRateSpinner_2 = uispinner(app.BasicTab_2);
            app.InitialLearnRateSpinner_2.Step = 0.0001;
            app.InitialLearnRateSpinner_2.Limits = [0 1];
            app.InitialLearnRateSpinner_2.Tooltip = {'Initial learning rate'};
            app.InitialLearnRateSpinner_2.Position = [143 372 100 22];
            app.InitialLearnRateSpinner_2.Value = 0.0001;

            % Create ValidationFrequencySpinner_2Label
            app.ValidationFrequencySpinner_2Label = uilabel(app.BasicTab_2);
            app.ValidationFrequencySpinner_2Label.HorizontalAlignment = 'right';
            app.ValidationFrequencySpinner_2Label.Position = [26 323 117 22];
            app.ValidationFrequencySpinner_2Label.Text = 'Validation Frequency';

            % Create ValidationFrequencySpinner_2
            app.ValidationFrequencySpinner_2 = uispinner(app.BasicTab_2);
            app.ValidationFrequencySpinner_2.Limits = [1 Inf];
            app.ValidationFrequencySpinner_2.Tooltip = {'Frequency of network validation'};
            app.ValidationFrequencySpinner_2.Position = [162 323 100 22];
            app.ValidationFrequencySpinner_2.Value = 50;

            % Create MaxEpochsSpinner_2Label
            app.MaxEpochsSpinner_2Label = uilabel(app.BasicTab_2);
            app.MaxEpochsSpinner_2Label.HorizontalAlignment = 'right';
            app.MaxEpochsSpinner_2Label.Position = [26 275 68 22];
            app.MaxEpochsSpinner_2Label.Text = 'MaxEpochs';

            % Create MaxEpochsSpinner_2
            app.MaxEpochsSpinner_2 = uispinner(app.BasicTab_2);
            app.MaxEpochsSpinner_2.Limits = [1 Inf];
            app.MaxEpochsSpinner_2.Tooltip = {'Maximum Number of Epochs'};
            app.MaxEpochsSpinner_2.Position = [133 275 100 22];
            app.MaxEpochsSpinner_2.Value = 30;

            % Create MiniBatchSizeSpinner_2Label
            app.MiniBatchSizeSpinner_2Label = uilabel(app.BasicTab_2);
            app.MiniBatchSizeSpinner_2Label.HorizontalAlignment = 'right';
            app.MiniBatchSizeSpinner_2Label.Position = [26 227 82 22];
            app.MiniBatchSizeSpinner_2Label.Text = 'MiniBatchSize';

            % Create MiniBatchSizeSpinner_2
            app.MiniBatchSizeSpinner_2 = uispinner(app.BasicTab_2);
            app.MiniBatchSizeSpinner_2.Limits = [1 Inf];
            app.MiniBatchSizeSpinner_2.Tooltip = {'Size of Mini-Batch'};
            app.MiniBatchSizeSpinner_2.Position = [129 227 100 22];
            app.MiniBatchSizeSpinner_2.Value = 128;

            % Create VerboseCheckBox_2
            app.VerboseCheckBox_2 = uicheckbox(app.BasicTab_2);
            app.VerboseCheckBox_2.Tooltip = {'Verbose the training process'};
            app.VerboseCheckBox_2.Text = 'Verbose';
            app.VerboseCheckBox_2.Position = [26 83 66 22];
            app.VerboseCheckBox_2.Value = true;

            % Create VerboseFrequencySpinner_2Label
            app.VerboseFrequencySpinner_2Label = uilabel(app.BasicTab_2);
            app.VerboseFrequencySpinner_2Label.HorizontalAlignment = 'right';
            app.VerboseFrequencySpinner_2Label.Position = [21 44 110 22];
            app.VerboseFrequencySpinner_2Label.Text = 'Verbose Frequency';

            % Create VerboseFrequencySpinner_2
            app.VerboseFrequencySpinner_2 = uispinner(app.BasicTab_2);
            app.VerboseFrequencySpinner_2.Limits = [1 Inf];
            app.VerboseFrequencySpinner_2.Tooltip = {'Frequency of verbose'};
            app.VerboseFrequencySpinner_2.Position = [139 44 100 22];
            app.VerboseFrequencySpinner_2.Value = 50;

            % Create AdvancedoptionalTab_2
            app.AdvancedoptionalTab_2 = uitab(app.TabGroup2_2);
            app.AdvancedoptionalTab_2.Title = 'Advanced (optional)';

            % Create L2RegularizationSpinner_2Label
            app.L2RegularizationSpinner_2Label = uilabel(app.AdvancedoptionalTab_2);
            app.L2RegularizationSpinner_2Label.HorizontalAlignment = 'right';
            app.L2RegularizationSpinner_2Label.Position = [18 421 96 22];
            app.L2RegularizationSpinner_2Label.Text = 'L2Regularization';

            % Create L2RegularizationSpinner_2
            app.L2RegularizationSpinner_2 = uispinner(app.AdvancedoptionalTab_2);
            app.L2RegularizationSpinner_2.Step = 0.0001;
            app.L2RegularizationSpinner_2.Limits = [0 Inf];
            app.L2RegularizationSpinner_2.Tooltip = {'Factor for L 2 regularizer'};
            app.L2RegularizationSpinner_2.Position = [134 421 126 22];
            app.L2RegularizationSpinner_2.Value = 0.0001;

            % Create GradientThresholdMethodDropDown_2Label
            app.GradientThresholdMethodDropDown_2Label = uilabel(app.AdvancedoptionalTab_2);
            app.GradientThresholdMethodDropDown_2Label.HorizontalAlignment = 'right';
            app.GradientThresholdMethodDropDown_2Label.Position = [18 379 145 22];
            app.GradientThresholdMethodDropDown_2Label.Text = 'GradientThresholdMethod';

            % Create GradientThresholdMethodDropDown_2
            app.GradientThresholdMethodDropDown_2 = uidropdown(app.AdvancedoptionalTab_2);
            app.GradientThresholdMethodDropDown_2.Items = {'l2norm', 'global-l2norm', 'absolutevalue'};
            app.GradientThresholdMethodDropDown_2.ItemsData = {'l2norm', 'global-l2norm', 'absolutevalue'};
            app.GradientThresholdMethodDropDown_2.Tooltip = {'Gradient Threshold Method'};
            app.GradientThresholdMethodDropDown_2.Position = [173 379 100 22];
            app.GradientThresholdMethodDropDown_2.Value = 'l2norm';

            % Create ResetInputNormalizationCheckBox_2
            app.ResetInputNormalizationCheckBox_2 = uicheckbox(app.AdvancedoptionalTab_2);
            app.ResetInputNormalizationCheckBox_2.Tooltip = {'Option to reset input layer normalization'};
            app.ResetInputNormalizationCheckBox_2.Text = 'ResetInputNormalization';
            app.ResetInputNormalizationCheckBox_2.Position = [18 76 153 22];
            app.ResetInputNormalizationCheckBox_2.Value = true;

            % Create GradientThresholdSpinner_2Label
            app.GradientThresholdSpinner_2Label = uilabel(app.AdvancedoptionalTab_2);
            app.GradientThresholdSpinner_2Label.HorizontalAlignment = 'right';
            app.GradientThresholdSpinner_2Label.Position = [18 337 105 22];
            app.GradientThresholdSpinner_2Label.Text = 'GradientThreshold';

            % Create GradientThresholdSpinner_2
            app.GradientThresholdSpinner_2 = uispinner(app.AdvancedoptionalTab_2);
            app.GradientThresholdSpinner_2.Step = 0.1;
            app.GradientThresholdSpinner_2.Limits = [0 Inf];
            app.GradientThresholdSpinner_2.Tooltip = {'Gradient Threshold'};
            app.GradientThresholdSpinner_2.Position = [133 337 114 22];
            app.GradientThresholdSpinner_2.Value = Inf;

            % Create ValidationPatienceSpinner_2Label
            app.ValidationPatienceSpinner_2Label = uilabel(app.AdvancedoptionalTab_2);
            app.ValidationPatienceSpinner_2Label.HorizontalAlignment = 'right';
            app.ValidationPatienceSpinner_2Label.Position = [21 294 104 22];
            app.ValidationPatienceSpinner_2Label.Text = 'ValidationPatience';

            % Create ValidationPatienceSpinner_2
            app.ValidationPatienceSpinner_2 = uispinner(app.AdvancedoptionalTab_2);
            app.ValidationPatienceSpinner_2.Limits = [1 Inf];
            app.ValidationPatienceSpinner_2.Tooltip = {'Patience of validation stopping'};
            app.ValidationPatienceSpinner_2.Position = [134 295 110 22];
            app.ValidationPatienceSpinner_2.Value = Inf;

            % Create ShuffleDropDown_2Label
            app.ShuffleDropDown_2Label = uilabel(app.AdvancedoptionalTab_2);
            app.ShuffleDropDown_2Label.HorizontalAlignment = 'right';
            app.ShuffleDropDown_2Label.Position = [18 251 43 22];
            app.ShuffleDropDown_2Label.Text = 'Shuffle';

            % Create ShuffleDropDown_2
            app.ShuffleDropDown_2 = uidropdown(app.AdvancedoptionalTab_2);
            app.ShuffleDropDown_2.Items = {'once', 'never', 'every-epoch'};
            app.ShuffleDropDown_2.ItemsData = {'once', 'never', 'every-epoch'};
            app.ShuffleDropDown_2.Tooltip = {'Option for data shuffling'};
            app.ShuffleDropDown_2.Position = [84 252 100 22];
            app.ShuffleDropDown_2.Value = 'once';

            % Create LearnRateScheduleDropDown_2Label
            app.LearnRateScheduleDropDown_2Label = uilabel(app.AdvancedoptionalTab_2);
            app.LearnRateScheduleDropDown_2Label.HorizontalAlignment = 'right';
            app.LearnRateScheduleDropDown_2Label.Position = [18 209 112 22];
            app.LearnRateScheduleDropDown_2Label.Text = 'LearnRateSchedule';

            % Create LearnRateScheduleDropDown_2
            app.LearnRateScheduleDropDown_2 = uidropdown(app.AdvancedoptionalTab_2);
            app.LearnRateScheduleDropDown_2.Items = {'none', 'piecewise'};
            app.LearnRateScheduleDropDown_2.ItemsData = {'none', 'piecewise'};
            app.LearnRateScheduleDropDown_2.Tooltip = {'Option for dropping learning rate during training'};
            app.LearnRateScheduleDropDown_2.Position = [148 212 100 22];
            app.LearnRateScheduleDropDown_2.Value = 'none';

            % Create LearnRateDropFactorSpinner_2Label
            app.LearnRateDropFactorSpinner_2Label = uilabel(app.AdvancedoptionalTab_2);
            app.LearnRateDropFactorSpinner_2Label.HorizontalAlignment = 'right';
            app.LearnRateDropFactorSpinner_2Label.Position = [18 163 122 22];
            app.LearnRateDropFactorSpinner_2Label.Text = 'LearnRateDropFactor';

            % Create LearnRateDropFactorSpinner_2
            app.LearnRateDropFactorSpinner_2 = uispinner(app.AdvancedoptionalTab_2);
            app.LearnRateDropFactorSpinner_2.Step = 0.01;
            app.LearnRateDropFactorSpinner_2.Limits = [0 1];
            app.LearnRateDropFactorSpinner_2.Tooltip = {'Factor for dropping the learning rate'};
            app.LearnRateDropFactorSpinner_2.Position = [151 167 111 22];
            app.LearnRateDropFactorSpinner_2.Value = 0.1;

            % Create LearnRateDropPeriodSpinner_2Label
            app.LearnRateDropPeriodSpinner_2Label = uilabel(app.AdvancedoptionalTab_2);
            app.LearnRateDropPeriodSpinner_2Label.HorizontalAlignment = 'right';
            app.LearnRateDropPeriodSpinner_2Label.Position = [18 121 122 22];
            app.LearnRateDropPeriodSpinner_2Label.Text = 'LearnRateDropPeriod';

            % Create LearnRateDropPeriodSpinner_2
            app.LearnRateDropPeriodSpinner_2 = uispinner(app.AdvancedoptionalTab_2);
            app.LearnRateDropPeriodSpinner_2.Limits = [1 Inf];
            app.LearnRateDropPeriodSpinner_2.Tooltip = {'Number of epochs for dropping the learning rate'};
            app.LearnRateDropPeriodSpinner_2.Position = [151 118 109 22];
            app.LearnRateDropPeriodSpinner_2.Value = 10;

            % Create MomentumSpinner_2Label
            app.MomentumSpinner_2Label = uilabel(app.AdvancedoptionalTab_2);
            app.MomentumSpinner_2Label.HorizontalAlignment = 'right';
            app.MomentumSpinner_2Label.Position = [18 35 66 22];
            app.MomentumSpinner_2Label.Text = 'Momentum';

            % Create MomentumSpinner_2
            app.MomentumSpinner_2 = uispinner(app.AdvancedoptionalTab_2);
            app.MomentumSpinner_2.Step = 0.01;
            app.MomentumSpinner_2.Limits = [0 1];
            app.MomentumSpinner_2.Tooltip = {'Contribution of previous gradient step'};
            app.MomentumSpinner_2.Position = [99 35 161 22];
            app.MomentumSpinner_2.Value = 0.9;

            % Create NetworkTrainingPanel_2
            app.NetworkTrainingPanel_2 = uipanel(app.ArtifactRemovalTab);
            app.NetworkTrainingPanel_2.Title = 'Network Training';
            app.NetworkTrainingPanel_2.Position = [12 69 302 426];

            % Create TrainNetworkButton_2
            app.TrainNetworkButton_2 = uibutton(app.NetworkTrainingPanel_2, 'push');
            app.TrainNetworkButton_2.ButtonPushedFcn = createCallbackFcn(app, @TrainNetworkButton_2Pushed, true);
            app.TrainNetworkButton_2.FontSize = 18;
            app.TrainNetworkButton_2.FontWeight = 'bold';
            app.TrainNetworkButton_2.FontColor = [0.0745 0.6235 1];
            app.TrainNetworkButton_2.Tooltip = {'Train network using training set, using the defined training options parameters.'};
            app.TrainNetworkButton_2.Position = [8 130 150 50];
            app.TrainNetworkButton_2.Text = 'Train Network';

            % Create ViewTestResultsButton
            app.ViewTestResultsButton = uibutton(app.NetworkTrainingPanel_2, 'push');
            app.ViewTestResultsButton.ButtonPushedFcn = createCallbackFcn(app, @ViewTestResultsButtonPushed, true);
            app.ViewTestResultsButton.Tooltip = {'plot different test set windows with the network''s prediction'};
            app.ViewTestResultsButton.Position = [166 130 114 50];
            app.ViewTestResultsButton.Text = 'View Test Results';

            % Create TrainingEditField_2Label
            app.TrainingEditField_2Label = uilabel(app.NetworkTrainingPanel_2);
            app.TrainingEditField_2Label.HorizontalAlignment = 'center';
            app.TrainingEditField_2Label.Position = [40 227 48 22];
            app.TrainingEditField_2Label.Text = 'Training';

            % Create TrainingEditField_2
            app.TrainingEditField_2 = uieditfield(app.NetworkTrainingPanel_2, 'numeric');
            app.TrainingEditField_2.Limits = [0.5 1];
            app.TrainingEditField_2.Tooltip = {'Part of the data for training, at leat 50%.'};
            app.TrainingEditField_2.Position = [40 195 48 22];
            app.TrainingEditField_2.Value = 0.8;

            % Create ValidationEditField_2Label
            app.ValidationEditField_2Label = uilabel(app.NetworkTrainingPanel_2);
            app.ValidationEditField_2Label.HorizontalAlignment = 'center';
            app.ValidationEditField_2Label.Position = [123 227 57 22];
            app.ValidationEditField_2Label.Text = 'Validation';

            % Create ValidationEditField_2
            app.ValidationEditField_2 = uieditfield(app.NetworkTrainingPanel_2, 'numeric');
            app.ValidationEditField_2.Limits = [0.01 0.5];
            app.ValidationEditField_2.Tooltip = {'Part of the data for validation, at least 1%.'};
            app.ValidationEditField_2.Position = [126 195 51 22];
            app.ValidationEditField_2.Value = 0.1;

            % Create TestEditField_2Label
            app.TestEditField_2Label = uilabel(app.NetworkTrainingPanel_2);
            app.TestEditField_2Label.HorizontalAlignment = 'center';
            app.TestEditField_2Label.Position = [217 227 28 22];
            app.TestEditField_2Label.Text = 'Test';

            % Create TestEditField_2
            app.TestEditField_2 = uieditfield(app.NetworkTrainingPanel_2, 'numeric');
            app.TestEditField_2.Limits = [0.01 0.5];
            app.TestEditField_2.Tooltip = {'Part of the data for testing, at least 1%.'};
            app.TestEditField_2.Position = [210 196 52 22];
            app.TestEditField_2.Value = 0.1;

            % Create ReplaceSegmentsButton
            app.ReplaceSegmentsButton = uibutton(app.NetworkTrainingPanel_2, 'push');
            app.ReplaceSegmentsButton.ButtonPushedFcn = createCallbackFcn(app, @ReplaceSegmentsButtonPushed, true);
            app.ReplaceSegmentsButton.Tooltip = {'Replace artifactual segments of the loaded data with NN predictions'};
            app.ReplaceSegmentsButton.Position = [89 71 117 50];
            app.ReplaceSegmentsButton.Text = 'Replace Segments';

            % Create PlotchannelButton
            app.PlotchannelButton = uibutton(app.NetworkTrainingPanel_2, 'push');
            app.PlotchannelButton.ButtonPushedFcn = createCallbackFcn(app, @PlotchannelButtonPushed, true);
            app.PlotchannelButton.Tooltip = {'Plot selected channel in the original and replaced versions for comparison'};
            app.PlotchannelButton.Position = [154 6 115 55];
            app.PlotchannelButton.Text = 'Plot channel';

            % Create SequenceLengthPanel
            app.SequenceLengthPanel = uipanel(app.NetworkTrainingPanel_2);
            app.SequenceLengthPanel.Title = 'Sequence Length';
            app.SequenceLengthPanel.Position = [3 252 299 151];

            % Create NNInputEditFieldLabel
            app.NNInputEditFieldLabel = uilabel(app.SequenceLengthPanel);
            app.NNInputEditFieldLabel.HorizontalAlignment = 'center';
            app.NNInputEditFieldLabel.Position = [20 100 53 22];
            app.NNInputEditFieldLabel.Text = 'NN Input';

            % Create NNInputEditField
            app.NNInputEditField = uieditfield(app.SequenceLengthPanel, 'numeric');
            app.NNInputEditField.Limits = [1e-06 Inf];
            app.NNInputEditField.Tooltip = {'Input size of the neural network'};
            app.NNInputEditField.Position = [22 68 48 22];
            app.NNInputEditField.Value = 200;

            % Create NNOutputEditFieldLabel
            app.NNOutputEditFieldLabel = uilabel(app.SequenceLengthPanel);
            app.NNOutputEditFieldLabel.HorizontalAlignment = 'center';
            app.NNOutputEditFieldLabel.Position = [91 100 62 22];
            app.NNOutputEditFieldLabel.Text = 'NN Output';

            % Create NNOutputEditField
            app.NNOutputEditField = uieditfield(app.SequenceLengthPanel, 'numeric');
            app.NNOutputEditField.Limits = [1e-06 Inf];
            app.NNOutputEditField.Tooltip = {'Number of points predicted by the network'};
            app.NNOutputEditField.Position = [98 68 48 22];
            app.NNOutputEditField.Value = 25;

            % Create UnitButtonGroup
            app.UnitButtonGroup = uibuttongroup(app.SequenceLengthPanel);
            app.UnitButtonGroup.Tooltip = {'Define which unit are the sequence lengths defined in.'};
            app.UnitButtonGroup.TitlePosition = 'centertop';
            app.UnitButtonGroup.Title = 'Unit';
            app.UnitButtonGroup.Position = [15 6 271 52];

            % Create mSButton
            app.mSButton = uiradiobutton(app.UnitButtonGroup);
            app.mSButton.Tooltip = {''};
            app.mSButton.Text = 'mS';
            app.mSButton.Position = [70 6 58 22];
            app.mSButton.Value = true;

            % Create DatapointsButton
            app.DatapointsButton = uiradiobutton(app.UnitButtonGroup);
            app.DatapointsButton.Text = 'Datapoints';
            app.DatapointsButton.Position = [152 6 79 22];

            % Create DataforModelTestingLabel
            app.DataforModelTestingLabel = uilabel(app.SequenceLengthPanel);
            app.DataforModelTestingLabel.HorizontalAlignment = 'center';
            app.DataforModelTestingLabel.Position = [167 100 125 22];
            app.DataforModelTestingLabel.Text = 'Data for Model Testing';

            % Create DataforModelTestingEditField
            app.DataforModelTestingEditField = uieditfield(app.SequenceLengthPanel, 'numeric');
            app.DataforModelTestingEditField.Limits = [1e-06 Inf];
            app.DataforModelTestingEditField.Tooltip = {'Number of points to calculate the RMSE of the model''s prediction'};
            app.DataforModelTestingEditField.Position = [201 68 48 22];
            app.DataforModelTestingEditField.Value = 100;

            % Create TrainingDataPanel_3
            app.TrainingDataPanel_3 = uipanel(app.ArtifactRemovalTab);
            app.TrainingDataPanel_3.Title = 'Training Data';
            app.TrainingDataPanel_3.Position = [14 503 299 163];

            % Create LoadTrainingDataButton_2
            app.LoadTrainingDataButton_2 = uibutton(app.TrainingDataPanel_3, 'push');
            app.LoadTrainingDataButton_2.ButtonPushedFcn = createCallbackFcn(app, @LoadTrainingDataButton_2Pushed, true);
            app.LoadTrainingDataButton_2.Tooltip = {'Load data structured for NN training. '};
            app.LoadTrainingDataButton_2.Position = [96 91 120 45];
            app.LoadTrainingDataButton_2.Text = 'Load Training  Data';

            % Create ExtractArtifactfreeSegmentsButton
            app.ExtractArtifactfreeSegmentsButton = uibutton(app.TrainingDataPanel_3, 'push');
            app.ExtractArtifactfreeSegmentsButton.ButtonPushedFcn = createCallbackFcn(app, @ExtractArtifactfreeSegmentsButtonPushed, true);
            app.ExtractArtifactfreeSegmentsButton.Tooltip = {'Extract artifact free segments of the length defined.'};
            app.ExtractArtifactfreeSegmentsButton.Position = [149 15 137 52];
            app.ExtractArtifactfreeSegmentsButton.Text = {'Extract Artifact-free '; 'Segments'};

            % Create SegmentLengthmSEditFieldLabel
            app.SegmentLengthmSEditFieldLabel = uilabel(app.TrainingDataPanel_3);
            app.SegmentLengthmSEditFieldLabel.HorizontalAlignment = 'center';
            app.SegmentLengthmSEditFieldLabel.Position = [6 50 123 22];
            app.SegmentLengthmSEditFieldLabel.Text = 'Segment Length (mS)';

            % Create SegmentLengthmSEditField
            app.SegmentLengthmSEditField = uieditfield(app.TrainingDataPanel_3, 'numeric');
            app.SegmentLengthmSEditField.Limits = [0.001 Inf];
            app.SegmentLengthmSEditField.Tooltip = {'Number of points without noise to be extracted'};
            app.SegmentLengthmSEditField.Position = [43 18 48 22];
            app.SegmentLengthmSEditField.Value = 1000;

            % Create ProgressPanel_4
            app.ProgressPanel_4 = uipanel(app.ArtifactRemovalTab);
            app.ProgressPanel_4.Tooltip = {'Guides user'};
            app.ProgressPanel_4.TitlePosition = 'centertop';
            app.ProgressPanel_4.Title = 'Progress';
            app.ProgressPanel_4.BackgroundColor = [0.9412 0.9412 0.9412];
            app.ProgressPanel_4.Position = [320 574 278 92];

            % Create Label_5
            app.Label_5 = uilabel(app.ProgressPanel_4);
            app.Label_5.HorizontalAlignment = 'center';
            app.Label_5.FontSize = 16;
            app.Label_5.FontWeight = 'bold';
            app.Label_5.FontColor = [1 0.0745 0.651];
            app.Label_5.Visible = 'off';
            app.Label_5.Position = [11 11 258 51];

            % Create SelectChannelDropDown_2Label
            app.SelectChannelDropDown_2Label = uilabel(app.ArtifactRemovalTab);
            app.SelectChannelDropDown_2Label.HorizontalAlignment = 'right';
            app.SelectChannelDropDown_2Label.Position = [37 117 87 22];
            app.SelectChannelDropDown_2Label.Text = 'Select Channel';

            % Create SelectChannelDropDown_2
            app.SelectChannelDropDown_2 = uidropdown(app.ArtifactRemovalTab);
            app.SelectChannelDropDown_2.Items = {'Channel 1'};
            app.SelectChannelDropDown_2.Tooltip = {'Choose channel to plot.'};
            app.SelectChannelDropDown_2.Position = [31 84 100 22];
            app.SelectChannelDropDown_2.Value = 'Channel 1';

            % Create Label
            app.Label = uilabel(app.UIFigure);
            app.Label.HorizontalAlignment = 'center';
            app.Label.FontSize = 18;
            app.Label.FontWeight = 'bold';
            app.Label.FontColor = [1 0.0745 0.651];
            app.Label.Position = [278 743 101 22];
            app.Label.Text = 'S.A.N.T.I.A.';

            % Create SigMateAdvancedaNeuronalToolforIdentificationofArtifactsLabel
            app.SigMateAdvancedaNeuronalToolforIdentificationofArtifactsLabel = uilabel(app.UIFigure);
            app.SigMateAdvancedaNeuronalToolforIdentificationofArtifactsLabel.FontWeight = 'bold';
            app.SigMateAdvancedaNeuronalToolforIdentificationofArtifactsLabel.FontColor = [1 0.0745 0.651];
            app.SigMateAdvancedaNeuronalToolforIdentificationofArtifactsLabel.Position = [137 722 383 22];
            app.SigMateAdvancedaNeuronalToolforIdentificationofArtifactsLabel.Text = 'SigMate Advanced: a  Neuronal Tool for Identification of Artifacts';

            % Create Image
            app.Image = uiimage(app.UIFigure);
            app.Image.Position = [567 722 53 43];
            app.Image.ImageSource = 'Nottingham_Trent_University_shield.png';

            % Show the figure after all components are created
            app.UIFigure.Visible = 'on';
        end
    end

    % App creation and deletion
    methods (Access = public)

        % Construct app
        function app = SANTIA_toolbox

            % Create UIFigure and components
            createComponents(app)

            % Register the app with App Designer
            registerApp(app, app.UIFigure)

            % Execute the startup function
            runStartupFcn(app, @startupFcn)

            if nargout == 0
                clear app
            end
        end

        % Code that executes before app deletion
        function delete(app)

            % Delete UIFigure when app is deleted
            delete(app.UIFigure)
        end
    end
end