clear
close all
clc

C=1;
B=0;
xsize=4*pi;
ysize=4*pi;
Nx=31;
Ny=41;
dx=xsize/(Nx-1);
dy=ysize/(Ny-1);
x=0:dx:xsize;
y=0:dy:ysize;

R=B*ones(Nx*Ny,1);
L=zeros(Nx*Ny,Nx*Ny);
for i=1:Ny
   p=i;
   L(p,p)=1;
   p=Ny*(Nx-1)+i;
   L(p,p)=1;
end
for i=2:Nx-1
   p=(i-1)*Ny+1;
   L(p,p)=1;
   p=i*Ny;
   L(p,p)=1;
end
for xi=2:Nx-1
   for yi=2:Ny-1
      p=(xi-1)*Ny+yi;
      R(p)=-sin(x(xi))-sin(y(yi));
      L(p,p-Ny)=1/(dx^2);
      L(p,p+Ny)=1/(dx^2);
      L(p,p-1)=1/(dy^2);
      L(p,p+1)=1/(dy^2);
      L(p,p)=-2/(dx^2)-2/(dy^2);
   end
end

s=L\R;
for i=1:Nx
   for j=1:Ny
      S(j,i)=s(Ny*(i-1)+j);
   end
end

[x,y]=meshgrid(x,y);
figure;surf(x,y,S);axis([0 xsize 0 ysize 1.05*min(s) 1.05*max(s)]);colorbar;box on
xlabel('x/km');ylabel('y/km');zlabel('phi');title('解二维泊松方程:f=-sin(x)-sin(y)')
shading interp