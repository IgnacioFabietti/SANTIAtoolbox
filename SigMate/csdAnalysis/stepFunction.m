function y=stepFunction(x,d,depth,sigma)
%this function returns the integration of the various recording depths

    y=(1/(2*sigma))*(sqrt((depth-x).^2+d^2)-abs(depth-x));

