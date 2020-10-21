function closeGUI

selection = questdlg('Do you really want to exit?',...
                     'Exit Request Confirmation',...
                     'Yes','No','Yes');
switch selection,
   case 'Yes',
    delete(gcf)
   case 'No'
     return
end