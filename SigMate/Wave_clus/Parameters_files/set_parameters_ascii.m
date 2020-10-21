function par=set_parameters(filename,handles)

% SPC PARAMETERS
par.mintemp = 0.00;                  % minimum temperature for SPC
par.maxtemp = 0.201;                 % maximum temperature for SPC
par.tempstep = 0.01;                 % temperature steps
par.SWCycles = 100;                  % SPC iterations for each temperature
par.KNearNeighb=11;                  % number of nearest neighbors for SPC
par.num_temp = floor((par.maxtemp ...
    -par.mintemp)/par.tempstep);     % total number of temperatures 
par.min_clus = 60;                   % minimun size of a cluster
par.max_clus = 13;                    % maximum number of clusters allowed
par.randomseed = 0;                  % if 0, random seed is taken as the clock value (default)
%par.randomseed = 147;                % If not 0, random seed 
%par.temp_plot = 'lin';               % temperature plot in linear scale
par.temp_plot = 'log';               % temperature plot in log scale
par.fname = 'data';                  % filename for interaction with SPC

% DETECTION PARAMETERS
% par.sr= 20000;                       % sampling rate (in Hz).
data=load(filename);
par.sr=1/(data(2,1)-data(1,1));
par.tmax= 'all';                     % maximum time to load
par.w_pre=20;                        % number of pre-event data points stored
par.w_post=44;                       % number of post-event data points stored
ref = 1.5;                           % detector dead time (in ms)
par.ref = floor(ref *par.sr/1000);   % conversion to datapoints
par.stdmin = 5;                      % minimum threshold for detection
par.stdmax = 50;                     % maximum threshold for detection
par.detect_fmin = 1000;               % high pass filter for detection
par.detect_fmax = 1000;              % low pass filter for detection
par.sort_fmin = 1000;                 % high pass filter for sorting
par.sort_fmax = 1000;                % low pass filter for sorting
%par.detection = 'pos';               % type of threshold
%par.detection = 'neg';
par.detection = 'both';
par.segments = 1;                    % nr. of segments in which the data is cutted.

% INTERPOLATION PARAMETERS
par.int_factor = 2;                  % interpolation factor
par.interpolation = 'y';             % interpolation with cubic splines
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
par.force_feature = 'spk';          % feature use for forcing
%par.force_feature = 'wav';         % feature use for forcing

% TEMPLATE MATCHING
par.match = 'y';                    % for template matching
%par.match = 'n';                    % for template matching
par.max_spk = 20000;                 % max. # of spikes before starting templ. match.


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
