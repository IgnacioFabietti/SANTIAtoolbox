function Plot_Spikes(handles)
USER_DATA = get(handles.wave_clus_figure,'userdata');
par = USER_DATA{1};
spikes = USER_DATA{2};
spk_times = USER_DATA{3};
clu = USER_DATA{4};
classes = USER_DATA{6};
classes = classes(:)';
class_bkup = USER_DATA{9};
class_bkup = class_bkup;
inspk = USER_DATA{7};
temp = USER_DATA{8};
ls = size(spikes,2);
par.to_plot_std = 1;                % # of std from mean to plot

% Closes aux figures
h_figs=get(0,'children');
h_fig = findobj(h_figs,'tag','wave_clus_figure');
h_fig1 = findobj(h_figs,'tag','wave_clus_aux');
h_fig2= findobj(h_figs,'tag','wave_clus_aux1');
close(h_fig1); close(h_fig2);
eval(['close(10)'],[''])

% Extract spike features if needed
if get(handles.spike_shapes_button,'value') ==0
    if isempty(inspk) | (length(inspk)~=size(spikes,1))
        [inspk] = wave_features_wc(spikes,handles);        
        USER_DATA{7} = inspk;
    end
end

% Defines nclusters
cluster_sizes=[];
cluster_sizes_bkup=[];
ifixflag=zeros(1,par.max_clus);
for i=1:par.max_clus                                    
    eval(['cluster_sizes = [cluster_sizes length(find(classes==' num2str(i) '))];'])
    eval(['cluster_sizes_bkup = [cluster_sizes_bkup length(find(class_bkup==' num2str(i) '))];'])
end

% Classes should be consecutive numbers
i=1;
while i<=min(max(classes),par.max_clus);
    if isempty(classes(find(classes==i)))
        for k=i+1:par.max_clus
            classes(find(classes==k))=k-1;
        end
    else
        i=i+1;
    end
end
i=1;
while i<=min(max(class_bkup),par.max_clus);
    if isempty(class_bkup(find(class_bkup==i)))
        for k=i+1:par.max_clus
            class_bkup(find(class_bkup==k))=k-1;
        end
    else
        i=i+1;
    end
end

nclusters_bkup = length(find(cluster_sizes(:) >= par.min_clus));
class_bkup(find(class_bkup > nclusters_bkup))=0;

% Clusters labels change after changes in parameters, but not after forcing
if handles.setclus == 0    
    sizemin_clus = par.min_clus;
else
    sizemin_clus = 1; 
end
nclusters = length(find(cluster_sizes(:) >= sizemin_clus));


% Get fixed clusters
if get(handles.fix1_button,'value') ==1     
    nclusters = nclusters +1;
    fix_class = USER_DATA{10}';
    classes(find(classes==nclusters))=0;
    classes(fix_class)=nclusters;
    ifixflag(nclusters)=1;
end
if get(handles.fix2_button,'value') ==1     
    nclusters = nclusters +1;
    fix_class = USER_DATA{11}';
    classes(find(classes==nclusters))=0;
    classes(fix_class)=nclusters;
    ifixflag(nclusters)=1;
end
if get(handles.fix3_button,'value') ==1     
    nclusters = nclusters +1;
    fix_class = USER_DATA{12}';
    classes(find(classes==nclusters))=0;
    classes(fix_class)=nclusters;
    ifixflag(nclusters)=1;
end
% Get fixed clusters from aux figures
for i=4:par.max_clus
    eval(['fixx = par.fix' num2str(i) ';']);
    if fixx == 1
        nclusters = nclusters +1;
        fix_class = USER_DATA{12+i-3}';
        classes(find(classes==nclusters))=0;
        classes(fix_class)=nclusters;
        ifixflag(nclusters)=1;
    end
end

% Defines classes
clustered = [];
cont=0;  
for i=1:nclusters       
    eval(['class_temp = find(classes==' num2str(i) ');'])
    if ((ifixflag(i)==1) & (~isempty(class_temp)))
        ifixflagc = 1;
    else
        ifixflagc = 0;
    end    
    if ((length(class_temp) >= sizemin_clus) || (ifixflagc == 1))
        cont=cont+1;        
        eval(['class' num2str(cont) '= class_temp;'])
        eval(['clustered = [clustered class' num2str(cont) '];'])
    end        
end
nclusters = cont;
class0 = setdiff( 1:size(spikes,1), sort(clustered) );

% Redefines classes
classes = zeros(size(spikes,1),1);
for i = 1:nclusters+1
    if ~ (isempty(class0) & i==1)
        eval(['classes(class' num2str(i-1) ') = ' num2str(i-1) ';']);
    end
end

% Saves new classes
USER_DATA{6} = classes;
USER_DATA{9} = class_bkup;
for i=10:22
    USER_DATA{i} = [];
end
set(handles.wave_clus_figure,'userdata',USER_DATA)

% Clear plots
for i=1:4                                               
    eval(['axes(handles.spikes' num2str(i-1) ');']); cla reset;
    eval(['axes(handles.isi' num2str(i-1) ');']); cla reset;
end    
axes(handles.projections); cla; reset(gca)

% Plot clusters
ylimit = [];
colors = ['k' 'b' 'r' 'g' 'c' 'm' 'y' 'b' 'r' 'g' 'c' 'm' 'y' 'b'];
for i = 1:nclusters+1
    if ~ (isempty(class0) & i==1)
        %PLOTS SPIKES OR PROJECTIONS
        axes(handles.projections)
        hold on
        eval(['max_spikes=min(length(class' num2str(i-1) '),par.max_spikes);']);
        eval(['sup_spikes=length(class' num2str(i-1) ');']);
        if get(handles.spike_shapes_button,'value') ==1 & get(handles.plot_all_button,'value') ==1
            permut=randperm(sup_spikes);
            eval(['plot(spikes(class' num2str(i-1) '(permut(1:max_spikes)),:)'',''' colors(i) ''');'])
            xlim([1 ls])
        elseif get(handles.spike_shapes_button,'value') ==1
            eval(['av   = mean(spikes(class' num2str(i-1) ',:));']);
            eval(['plot(1:ls,av,''color'',''' colors(i) ''',''linewidth'',2);']);
            xlim([1 ls])
        else
            eval(['plot(inspk(class' num2str(i-1) ',1),inspk(class' num2str(i-1) ',2),''.' colors(i) ''',''markersize'',.5);']);
        end        
        if i < 5
            eval(['axes(handles.spikes' num2str(i-1) ');']); 
            hold on
            eval(['av   = mean(spikes(class' num2str(i-1) ',:));']);
            eval(['avup = av + par.to_plot_std * std(spikes(class' num2str(i-1) ',:));']);
            eval(['avdw = av - par.to_plot_std * std(spikes(class' num2str(i-1) ',:));']);
            if get(handles.plot_all_button,'value') ==1
                permut=randperm(sup_spikes);
                eval(['plot(spikes(class' num2str(i-1) '(permut(1:max_spikes)),:)'',''color'',''' colors(i) ''')']);
                if i==1
                    plot(1:ls,av,'c','linewidth',2);
                    plot(1:ls,avup,'c','linewidth',.5)
                    plot(1:ls,avdw,'c','linewidth',.5)
                else
                    plot(1:ls,av,'k','linewidth',2);
                    plot(1:ls,avup,1:ls,avdw,'color',[.4 .4 .4],'linewidth',.5)
                end
            else
                plot(1:ls,av,'color',colors(i),'linewidth',2)
                plot(1:ls,avup,1:ls,avdw,'color',[.65 .65 .65],'linewidth',.5)
            end
            xlim([1 ls])
            if i>1; ylimit = [ylimit;ylim]; end;
            eval(['aux=num2str(length(class' num2str(i-1) '));']);
            eval(['title([''Cluster ' num2str(i-1) ':  # ' aux '''],''Fontweight'',''bold'')']);
            eval(['axes(handles.isi' num2str(i-1) ');']); 
            eval(['times' num2str(i-1) '=diff(spk_times(class' num2str(i-1) '));']);
            % Calculates # ISIs < 3ms  
            bin_step_temp = 1;
            eval(['[N,X]=hist(times' num2str(i-1) ',0:bin_step_temp:par.nbins' num2str(i-1) ');']);
            multi_isi= sum(N(1:3)); 
            % Builds and plots the histogram
            eval(['[N,X]=hist(times' num2str(i-1) ',0:par.bin_step' num2str(i-1) ':par.nbins' num2str(i-1) ');']);
            bar(X(1:end-1),N(1:end-1))
            eval(['xlim([0 par.nbins' num2str(i-1) ']);']);
            eval(['set(get(gca,''children''),''facecolor'',''' colors(i) ''',''edgecolor'',''' colors(i) ''',''linewidth'',0.01);']);    
            title([num2str(multi_isi) ' in < 3ms'])
            xlabel('ISI (ms)');
        elseif i < 10 
            par.axes_nr = i;
            par.ylimit = ylimit;
            eval(['par.class_to_plot = class' num2str(i-1) ';']);
            par.plot_all_button = get(handles.plot_all_button,'value');
            USER_DATA{1} = par;
            set(handles.wave_clus_figure,'userdata',USER_DATA)
            wave_clus_aux
        else
            par.axes_nr = i;
            par.ylimit = ylimit;
            eval(['par.class_to_plot = class' num2str(i-1) ';']);
            par.plot_all_button = get(handles.plot_all_button,'value');
            USER_DATA{1} = par;
            set(handles.wave_clus_figure,'userdata',USER_DATA)
            wave_clus_aux1
        end
    end
end       

%Resize axis  
if ~strcmp(char(handles.datatype),'Sc data') & ~strcmp(char(handles.datatype),'Sc data (pre-clustered)')
    ymin = min(ylimit(:,1));
    ymax = max(ylimit(:,2));
    for i=1:3
        eval(['axes(handles.spikes' num2str(i) '); ylim([ymin ymax])'])
    end
end

