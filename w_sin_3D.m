clear
close all
clc

C=1;
B=0;
xsize=4*pi;
ysize=4*pi;
zsize=4*pi;
Nx=21;
Ny=21;
Nz=21;
dx=xsize/(Nx-1);
dy=ysize/(Ny-1);
dz=zsize/(Nz-1);
X=0:dx:xsize;
Y=0:dy:ysize;
Z=0:dz:zsize;

n=Nx*Ny*Nz;
R=B*ones(n,1);
L=zeros(n,n);
for x=1:Nx
   for y=1:Ny
      p=(y-1)*Nx+x;
      L(p,p)=1;
      p=p+Nx*Ny*(Nz-1);
      L(p,p)=1;
   end
end
for x=1:Nx
   for z=2:Nz-1
      p=Nx*Ny*(z-1)+x;
      L(p,p)=1;
      p=p+Nx*(Ny-1);
      L(p,p)=1;
   end
end
for y=2:Ny-1
   for z=2:Nz-1
      p=Nx*Ny*(z-1)+Nx*(y-1)+1;
      L(p,p)=1;
      p=p+Nx-1;
      L(p,p)=1;
   end
end
for x=2:Nx-1
   for y=2:Ny-1
      for z=2:Nz-1
         p=Nx*Ny*(z-1)+Nx*(y-1)+x;
         R(p)=-sin(X(x))-sin(Y(y))-sin(Z(z));
         L(p,p)=-2/(dx^2)-2/(dy^2)-2/(dz^2);
         L(p,p-1)=1/(dx^2);
         L(p,p+1)=1/(dx^2);
         L(p,p-Ny)=1/(dy^2);
         L(p,p+Ny)=1/(dy^2);
         L(p,p-Ny*Nx)=1/(dz^2);
         L(p,p+Ny*Nx)=1/(dz^2);
      end
   end
end

s=L\R;
for x=1:Nx
   for y=1:Ny
      for z=1:Nz
         p=Nx*Ny*(z-1)+Nx*(y-1)+x;
         S(x,y,z)=s(p);
      end
   end
end

xs=linspace(0,xsize,9);
xs=xs([2 4 6 8]);
ys=[];
zs=[];
[X,Y,Z]=meshgrid(X,Y,Z);
figure;slice(X,Y,Z,S,xs,ys,zs);colormap hsv;h=colorbar;shading interp;box on
xlabel('x/km');ylabel('y/km');zlabel('z/km');title('解三维泊松方程:f=-sin(x)-sin(y)-sin(z)')
axis([0 xsize 0 ysize 0 zsize]);set(get(h,'Title'),'string','phi');