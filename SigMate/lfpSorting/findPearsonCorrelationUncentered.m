function[dxy] = findPearsonCorrelationUncentered(vet_x,vet_y)

nx = length(vet_x);
ny = length(vet_y);
if nx ~= ny
    display('the two vectors don''t have the same length')
    dxy = NaN;
    return
else
    den1 = sqrt(sum(vet_x.^2)/nx);
    den2 = sqrt(sum(vet_y.^2)/ny);
    sommation = 0;
    for a = 1:nx        
        x = vet_x(a);
        y = vet_y(a);                
        sommation = sommation + (x/den1)*(y/den2);
    end
    dxy = sommation/nx;
end