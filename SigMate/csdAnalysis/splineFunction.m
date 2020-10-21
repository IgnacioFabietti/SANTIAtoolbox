function y=splineFunction(x,d,depthi,depthj,sigma,m)


    y=(1/(2*sigma))*((x-depthi).^m).*(sqrt((depthj-x).^2+d^2)-abs(depthj-x));
