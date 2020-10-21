function[obj_fun] = gauss_generic(par,info)

z = info.z;
t = info.t;
sd = info.sd;

N = length(par);
num_gaussiane = N/3;

m = par(1:num_gaussiane);
A = par((num_gaussiane+1):(2*num_gaussiane));
B = par((2*num_gaussiane+1):end);

y = zeros(length(t),1);
for a = 1:num_gaussiane
    sigma_tmp = B(a)/(sqrt(2*pi)*A(a));
    y = y+ A(a)*exp(-1/2*((t-m(a))/sigma_tmp).^2);
end

obj_fun = (z-y)./sd;