function[dxy] = funz_Pearson_correlation(vet_x,vet_y)

nx = length(vet_x);
ny = length(vet_y);
if nx ~= ny
    display('the two vectors don''t have the same length')
    dxy = NaN;
    return
else
    avg_x = mean(vet_x);
    avg_y = mean(vet_y);
    den1 = sqrt(sum((vet_x - avg_x).^2)/nx);
    den2 = sqrt(sum((vet_y - avg_y).^2)/ny);
    sommation = 0;
    for a = 1:nx        
        x = vet_x(a);
        y = vet_y(a);                
        sommation = sommation + ((x-avg_x)/den1)*((y-avg_y)/den2);
    end
    dxy = sommation/nx;
end