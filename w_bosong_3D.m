clear
close all
clc

C=1;
B=0;
xsize=1000;
ysize=1000;
zsize=1000;
Nx=21;
Ny=21;
Nz=21;
dx=xsize/(Nx-1);
dy=ysize/(Ny-1);
dz=zsize/(Nz-1);
X=0:dx:xsize;
Y=0:dy:ysize;
Z=0:dz:zsize;
[X,Y,Z]=meshgrid(X,Y,Z);

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
         R(p)=C;
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

xs=linspace(0,xsize,4);
xs=xs([2 3]);
ys=xs;
zs=xs;
figure;slice(X,Y,Z,S,xs,ys,zs);colormap hsv;h=colorbar;shading interp;box on
xlabel('x/km');ylabel('y/km');zlabel('z/km');title('ÈýÎ¬²´ËÉ·½³Ì:f=1')
set(get(h,'title'),'string','phi')