function run_chronux()

% this script starts chronux

chronuxPath = which('run_chronux');
chronuxPath = chronuxPath(1:end-(length('run_chronux.m')+1));
% 
% subdirsPath = genpath(chronuxPath);
% 
% [path, toks]=strtok(subdirsPath,';');
% 
% toks = toks(2:end);
% 
% addpath(toks);



choice=questdlg([{'The chronux folder is located at:' chronuxPath, 'As most of the chronux functions operate in the command line mode from the Matlab console please use the console to use its functions.',...
    '','To incorporate the automated path management, we have started the ''Wave Browser'' GUI','Please keep this GUI open as long as you are working on chronux.','Closing this GUI will remove the subfolder paths from the path variable of Matlab.','','Do you want to continue?'}],'Important!! Read Me First!','Yes','No','Yes');

switch lower(choice)
    case 'yes'
        chronuxPath = which('run_chronux');
        chronuxPath = chronuxPath(1:end-(length('run_chronux.m')+1));
        
        subdirsPath = genpath(chronuxPath);
        
        [path, toks]=strtok(subdirsPath,';');
        
        toks = toks(2:end);
        
        addpath(toks);
        
        run wave_browser;
    case 'no'
        return;    
end