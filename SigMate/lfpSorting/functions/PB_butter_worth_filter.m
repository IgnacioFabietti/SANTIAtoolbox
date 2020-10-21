function[z_filt] = PB_butter_worth_filter(z, FS, cutoff_freq, order)
% filtro butter worth passa basso.

fNorm = cutoff_freq/(FS/2);
[b, a] = butter(order, fNorm, 'low');
z_filt = filtfilt(b,a,z);