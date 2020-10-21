function [spikes,thr,index] = amp_detect(x,handles)
% Detect spikes with amplitude thresholding. Uses median estimation.
% Detection is done with filters set by fmin_detect and fmax_detect. Spikes
% are stored for sorting using fmin_sort and fmax_sort. This trick can
% eliminate noise in the detection but keeps the spikes shapes for sorting.

sr=handles.par.sr;
w_pre=handles.par.w_pre;
w_post=handles.par.w_post;
ref=handles.par.ref;
detect = handles.par.detection;
stdmin = handles.par.stdmin;
stdmax = handles.par.stdmax;
fmin_detect = handles.par.detect_fmin;
fmax_detect = handles.par.detect_fmax;
fmin_sort = handles.par.sort_fmin;
fmax_sort = handles.par.sort_fmax;

% HIGH-PASS FILTER OF THE DATA
xf=zeros(length(x),1);
[b,a]=ellip(2,0.1,40,[fmin_detect fmax_detect]*2/sr);
xf_detect=filtfilt(b,a,x);
[b,a]=ellip(2,0.1,40,[fmin_sort fmax_sort]*2/sr);
xf=filtfilt(b,a,x);
lx=length(xf);

noise_std_detect = median(abs(xf_detect))/0.6745;
noise_std_sorted = median(abs(xf))/0.6745;
thr = stdmin * noise_std_detect;        %thr for detection is based on detect settings.
thrmax = stdmax * noise_std_sorted;     %thrmax for artifact removal is based on sorted settings.

set(handles.file_name,'string','Detecting spikes ...');

if ~(strcmp(handles.datatype,'CSC data (pre-clustered)') | strcmp(handles.datatype,'ASCII spikes (pre-clustered)') )
    % LOCATE SPIKE TIMES
	switch detect
    	case 'pos'
        	nspk = 0;
        	xaux = find(xf_detect(w_pre+2:end-w_post-2) > thr) +w_pre+1;
        	xaux0 = 0;
        	for i=1:length(xaux)
            	if xaux(i) >= xaux0 + ref
                	[maxi iaux]=max((xf(xaux(i):xaux(i)+floor(ref/2)-1)));    %introduces alignment
                	nspk = nspk + 1;
                	index(nspk) = iaux + xaux(i) -1;
                	xaux0 = index(nspk);
            	end
        	end
    	case 'neg'
        	nspk = 0;
        	xaux = find(xf_detect(w_pre+2:end-w_post-2) < -thr) +w_pre+1;
        	xaux0 = 0;
        	for i=1:length(xaux)
            	if xaux(i) >= xaux0 + ref
                	[maxi iaux]=min((xf(xaux(i):xaux(i)+floor(ref/2)-1)));    %introduces alignment
                	nspk = nspk + 1;
                	index(nspk) = iaux + xaux(i) -1;
                	xaux0 = index(nspk);
            	end
        	end
  	  	case 'both'
   	    	nspk = 0;
   	     	xaux = find(abs(xf_detect(w_pre+2:end-w_post-2)) > thr) +w_pre+1;
    	    xaux0 = 0;
    	    for i=1:length(xaux)
	            if xaux(i) >= xaux0 + ref
            	    [maxi iaux]=max(abs(xf(xaux(i):xaux(i)+floor(ref/2)-1)));    %introduces alignment
            	    nspk = nspk + 1;
        	        index(nspk) = iaux + xaux(i) -1;
        	        xaux0 = index(nspk);
    	        end
	        end
	end
    
    % SPIKE STORING (with or without interpolation)
    ls=w_pre+w_post;
    spikes=zeros(nspk,ls+4);
    xf=[xf zeros(1,w_post)];
    for i=1:nspk                          %Eliminates artifacts
        if max(abs( xf(index(i)-w_pre:index(i)+w_post) )) < thrmax               
            spikes(i,:)=xf(index(i)-w_pre-1:index(i)+w_post+2);
        end
    end
    aux = find(spikes(:,w_pre)==0);       %erases indexes that were artifacts
    spikes(aux,:)=[];
    index(aux)=[];
    
    switch handles.par.interpolation
        case 'n'
            spikes(:,end-1:end)=[];       %eliminates borders that were introduced for interpolation 
            spikes(:,1:2)=[];
        case 'y'
            %Does interpolation
            spikes = int_spikes(spikes,handles);   
    end
    
    if ~(strcmp(handles.datatype,'CSC data') & strcmp(handles.par.tmax,'all')) 
        USER_DATA = get(handles.wave_clus_figure,'userdata');
        USER_DATA{2}=spikes;    
        USER_DATA{3}=index*1000/sr; 
        set(handles.wave_clus_figure,'userdata',USER_DATA);
        Plot_continuous_data(xf,handles,thr,thrmax)
    elseif handles.flag == 1 
        Plot_continuous_data(xf(1:floor(60*sr)),handles,thr,thrmax)
    end
else
    USER_DATA = get(handles.wave_clus_figure,'userdata');
    spikes = USER_DATA{2};
    index = USER_DATA{3};
    if (strcmp(handles.datatype,'CSC data (pre-clustered)')) %Case CSC preclustered
        Plot_continuous_data(xf(1:floor(60*sr)),handles,thr,thrmax)
    else
        Plot_continuous_data(xf,handles,thr,thrmax) %case ASCII spikes preclustered
    end    
end
