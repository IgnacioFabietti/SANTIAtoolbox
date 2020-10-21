function M=calculateSplineICSDSS(potentials,sigma,h,z,R)

% This is a function that calculate the CSD throught the spline iCSD method
% potentials is a matrix qhich contain the LFP, sigma is the conductivity
% tensor, h is the electode spacing, z is a vector that contain the recording sites, R is
% the radius the source of CSD


    N=length(z)-2;

    c=(1/(z(3)-z(2)))*ones(N,1); % It's a vector with a constant value because the electrode spacing in constant (1/(zi+1-zi))
    c2=2*(c(1)+c(2));
    r=zeros(1,N+2);
    r(1)=c(1);
    r(2)=c2;
    r(3)=c(2);
    col=zeros(N+2,1);
    col(1)=c(1);
    c1=toeplitz(col,r);  %matrix that moltiplicates the matrix K

    r=zeros(1,N+2);
    r(1)=-(c(1)^2);
    r(2)=c(1)^2-c(2)^2;
    r(3)=c(2)^2;
    col=zeros(N+2,1);
    col(1)=-(c(1)^2);
    c2=3*toeplitz(col,r);  %matrix that moltiplicates the matrix C

    T=c2*inv(c1);  % K=TC

    row=zeros(N+2,1);
    row(1)=1;

    E0=toeplitz(row);  % matrice identità
    E0=E0(1:N+1,:);

    E1=E0*T;
    %E1=E1(1:N+1,:);

    % COSTRUNCTION OF MATRIX E2
    % ai2=3ci^2*(Ci+1-Ci)-ci(Ki+1+2Ki)

    r=zeros(1,N+2);
    r(1)=-(c(1)^2);
    r(2)=(c(1)^2);
    col=zeros(N+2,1);
    col(1)=-c(1)^2;
    c3=3*toeplitz(col,r);  

    r=zeros(1,N+2);
    r(1)=2*c(1);
    r(2)=c(1);
    col=zeros(N+2,1);
    col(1)=2*c(1);
    c4=toeplitz(col,r);  

    E2=c3-c4*T;
    E2=E2(1:N+1,:);

    % COSTRUNCTION OF MATRIX E3
    % ai3=2ci^3*(Ci-Ci+1)+ci^2(Ki+1+Ki)

    r=zeros(1,N+2);
    r(1)=(c(1)^3);
    r(2)=-(c(1)^3);
    col=zeros(N+2,1);
    col(1)=c(1)^3;
    c5=2*toeplitz(col,r);  

    r=zeros(1,N+2);
    r(1)=c(1)^2;
    r(2)=c(1)^2;
    col=zeros(N+2,1);
    col(1)=r(1);
    c6=toeplitz(col,r);  

    E3=c5+c6*T;
    E3=E3(1:N+1,:);

    % CONSTRUCTION OF MATRIX F0

    F0=zeros(N,N+1);
    m=0;


    for j=1:N
        depthj=z(j);
        for i=1:N+1
            depthi=z(i);
            a=z(i);
            b=z(i)+h;
            F0(j,i)=quad(@(x)splineFunction(x,R,depthi,depthj,sigma,m),a,b);
        end
    end

    % CONSTRUCTION OF MATRIX F1

    F1=zeros(N,N+1);
    m=1;


    for j=1:N
        depthj=z(j);
        for i=1:N+1
            depthi=z(i);
            a=z(i);
            b=z(i)+h;
            F1(j,i)=quad(@(x)splineFunction(x,R,depthi,depthj,sigma,m),a,b);
        end
    end

    % CONSTRUCTION OF MATRIX F2

    F2=zeros(N,N+1);
    m=2;


    for j=1:N
        depthj=z(j);
        for i=1:N+1
            depthi=z(i);
            a=z(i);
            b=z(i)+h;
            F2(j,i)=quad(@(x)splineFunction(x,R,depthi,depthj,sigma,m),a,b);
        end
    end

    % CONSTRUCTION OF MATRIX F3

    F3=zeros(N,N+1);
    m=3;


    for j=1:N
        depthj=z(j);
        for i=1:N+1
            depthi=z(i);
            a=z(i);
            b=z(i)+h;
            F3(j,i)=quad(@(x)splineFunction(x,R,depthi,depthj,sigma,m),a,b);
        end
    end


    f=F0*E0+F1*E1+F2*E2+F3*E3;
    r1=zeros(1,N+2);
    r1(1)=1;
    r2=zeros(1,N+2);
    r2(N+2)=1;
    F=[r1;f;r2];

    inv_F=inv(F);


    C=inv_F*potentials';
    M=C(2:(1+N),:)/1000;