function par=set_parameters(sr,filename,handles)

% SPC PARAMETERS
par.mintemp = 0.00;                  % minimum temperature for SPC
par.maxtemp = 0.201;                 % maximum temperature for SPC
par.tempstep = 0.01;                 % temperature steps
par.SWCycles = 100;                  % SPC iterations for each temperature (default=100)
par.KNearNeighb=11;                  % number of nearest neighbors for SPC
par.num_temp = floor((par.maxtemp ...
    -par.mintemp)/par.tempstep);     % total number of temperatures 
par.min_clus = 60;                   % minimum size of a cluster (default 60)   
par.max_clus = 13;                   % maximum number of clusters allowed (default 13)
par.randomseed = 0;                  % if 0, random seed is taken as the clock value (default 0)
%par.randomseed = 147;                % If not 0, random seed   
%par.temp_plot = 'lin';               % temperature plot in linear scale
par.temp_plot = 'log';               % temperature plot in log scale
par.fname_in = 'tmp_data';           % temporary filename used as input for SPC
par.fname = 'data';                  % filename for interaction with SPC

% DETECTION PARAMETERS
par.tmax= 'all';                     % maximum time to load (default)
%par.tmax= 180;                       % maximum time to load (in sec)
par.tmin= 0;                         % starting time for loading (in sec)
par.sr=sr;                           % sampling rate
par.w_pre=20;                        % number of pre-event data points stored
par.w_post=44;                       % number of post-event data points stored
ref = 1.5;                           % detector dead time (in ms)
par.ref = floor(ref *sr/1000);       % conversion to datapoints
par.stdmin = 5;                      % minimum threshold for detection
par.stdmax = 50;                     % maximum threshold for detection
par.detect_fmin = 300;               %high pass filter for detection
par.detect_fmax = 1000;              %low pass filter for detection
par.sort_fmin = 300;                 %high pass filter for sorting
par.sort_fmax = 3000;                %low pass filter for sorting
par.detection = 'pos';               % type of threshold
%par.detection = 'neg';
%par.detection = 'both';
par.segments_length = 5;             %length of segments in which the data is cutted (default 5min).

% INTERPOLATION PARAMETERS
par.int_factor = 2;                  % interpolation factor
par.interpolation = 'y';             % interpolation with cubic splines (default)
%par.interpolation = 'n';


% FEATURES PARAMETERS
par.inputs=10;                       % number of inputs to the clustering
par.scales=4;                        % number of scales for the wavelet decomposition
par.features = 'wav'                 % type of feature 
%par.features = 'pca'                
if strcmp(par.features,'pca'); par.inputs=3; end


% FORCE MEMBERSHIP PARAMETERS
par.template_sdnum = 3;             % max radius of cluster in std devs.
par.template_k = 10;                % # of nearest neighbors
par.template_k_min = 10;            % min # of nn for vote
%par.template_type = 'mahal';        % nn, center, ml, mahal
par.template_type = 'center';        % nn, center, ml, mahal
par.force_feature = 'spk';          % feature use for forcing (whole spike shape)
%par.force_feature = 'wav';         % feature use for forcing (wavelet coefficients).


% TEMPLATE MATCHING
par.match = 'y';                    % for template matching
%par.match = 'n';                    % for no template matching
par.max_spk = 30000;                % max. # of spikes before starting templ. match.


% HISTOGRAM PARAMETERS
for i=1:par.max_clus+1
    eval(['par.nbins' num2str(i-1) ' = 100;']);  % # of bins for the ISI histograms
    eval(['par.bin_step' num2str(i-1) ' = 1;']);  % percentage number of bins to plot
end

par.max_spikes = 1000;               % max. # of spikes to be plotted

par.filename = filename;

% Sets to zero fix buttons from aux figures
for i=4:par.max_clus
    eval(['par.fix' num2str(i) '=0;'])
end
    
USER_DATA = get(handles.wave_clus_figure,'userdata');
USER_DATA{1} = par;
set(handles.wave_clus_figure,'userdata',USER_DATA);
