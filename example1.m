clc
clear all
close all

%%
%%%%%% Solve A1 A2 A3
%%%%%% physcial parameters
L=0.2;
lambda=400;
Tb=320;
qa=50000;
Sc=1000;
Ta=Tb+qa/lambda*0.2+Sc/(2*lambda)*(L^2);
Sp=-5000;

%%%%%% physcial parameters
n=51;

%%%%%% Grid generation
x0=linspace(0,L,n);% x0 nodes positions
dx=L/(n-1);
Dx=dx;

%%%%%% creating the matrix
A=zeros(n,n);
B=zeros(n,1);

% node 1
A(1,1)=1;
B(1)=Ta;
% node 2
A(n,n)=1;
B(n)=Tb;

for i=2:n-1
    A(i,i-1)=-lambda/dx;
    A(i,i)=2*lambda/dx-Sp*Dx;
    A(i,i+1)=-lambda/dx;
    B(i)=Sc*Dx;
end

T=A\B;

figure ('color','w','units','Centimeters','position',[5 5 7.5 7])
plot(x0,T,'rs');
grid on;
xlabel('x[m]');
ylabel('T[k]');
hold on


%%%%%%  the result of A2
disp('x=L/2 时,温度T为：')
disp(T(26))


%%%%%%  plot numerical and theoretical solutions
%%% Theoretical solution
% mu11=sqrt(-Sp/lambda);
% mu22=-sqrt(-Sp/lambda);
% c11=((Tb+((qa*exp(mu22*L))/(lambda*mu22))+Sc/Sp))/(exp(mu11*L)-(mu11*exp(mu22*L))/mu22);
% c22=(-qa/lambda-c11*mu11)/mu22;
% Tteo1=c11*exp(mu11*x0)+c22*exp(mu22*x0)-Sc/Sp;

mu1=sqrt(abs(Sp)/lambda);
mu2=-sqrt(abs(Sp)/lambda);
c1=(Tb-(Sc/Sp+Ta)*exp(mu2*L)+Sc/Sp)/(exp(mu1*L)-exp(mu2*L));
c2=Ta+Sc/Sp-c1;
Tteo=c1*exp(mu1*x0)+c2*exp(mu2*x0)-Sc/Sp;


figure (2)
plot(x0,T,'rs');
grid on;
xlabel('x[m]');
ylabel('T[k]');
hold on
plot(x0,Tteo,'k-')
legend('backlash','Exact')


