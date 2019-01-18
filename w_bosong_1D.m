clear
close all
clc

C=1;
B=[0 0];
N=1000;
dx=1;
x=0:dx:N-1;

R=[B(1);C*ones(N-2,1);B(2)];
L=sparse(N,N);
L(1,1)=1;L(N,N)=1;
for i=2:N-1
   L(i,i-1)=1/(dx^2);
   L(i,i)=-2/(dx^2);
   L(i,i+1)=1/(dx^2);
end

S=L\R;
figure;plot(x,S);grid on;xlabel('x/km');ylabel('phi');title('解一维泊松方程:phi”(x)=1')