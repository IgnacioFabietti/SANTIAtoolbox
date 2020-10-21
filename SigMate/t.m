j=1;
xx=dir(fullfile(pathToAdd));
for i=1:length(xx)
    temp=xx(i,1).name; 
    if (~isequal(temp, '.') && ~isequal(temp, '..')) && isdir(temp)
        folders{j}=temp; j=j+1; 
    end
end