clear
close all
clc

C=1;
xsize=2*pi;
N=1001;
B=[0 sin(xsize)];
dx=xsize/(N-1);
x=0:dx:xsize;

R=zeros(N,1);
R(1,1)=B(1);
R(N,1)=B(2);
for i=2:N-1
   R(i,1)=-sin(x(i));
end

L=sparse(N,N);
L(1,1)=1;L(N,N)=1;
for i=2:N-1
   L(i,i-1)=1/(dx^2);
   L(i,i)=-2/(dx^2);
   L(i,i+1)=1/(dx^2);
end

S=L\R;
figure;plot(x,S);grid on;xlabel('x/km');ylabel('phi');title('解一维泊松方程:phi”(x)=-sin(x)')