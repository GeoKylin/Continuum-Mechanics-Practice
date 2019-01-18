clear
close all
clc

W=1000000;
H=1500000;
k=2*H/W+9.9e-16;
Nx=36;
Ny=36;
xstep=W/(Nx-1);
ystep=H/(Ny-1);
x=0:xstep:W;
y=0:ystep:H;
[x,y]=meshgrid(x,y);
Vx0=10^(-9);
Vy0=k*10^(-9);
Vx=-Vx0*sin(2*pi*x/W).*cos(pi*y/H);
Vy=Vy0*cos(2*pi*x/W).*sin(pi*y/H);

dVx=-2*pi*Vx0/W*cos(2*pi*x/W).*cos(pi*y/H);
dVy=pi*Vy0/H*cos(2*pi*x/W).*cos(pi*y/H);
dV=dVx+dVy;

figure;set(gcf,'outerposition',get(0,'screensize'));
subplot(2,3,1);pcolor(x/1000,y/1000,Vx);xlabel('x,km');ylabel('y,km');title('Vx colormap,m/s')
set(gca,'ydir','reverse');shading interp;colormap jet;colorbar

subplot(2,3,2);pcolor(x/1000,y/1000,Vy);xlabel('x,km');ylabel('y,km');title('Vy colormap,m/s')
set(gca,'ydir','reverse');shading interp;colormap jet;colorbar

subplot(2,3,3);quiver(x/1000,y/1000,Vx,Vy);axis([0 W/1000 0 H/1000]);
set(gca,'ydir','reverse');xlabel('x,km');ylabel('y,km');title('velocity field')

subplot(2,3,4);pcolor(x/1000,y/1000,dVx);xlabel('x,km');ylabel('y,km');title('dVx/dx colormap,1/s')
set(gca,'ydir','reverse');shading interp;colormap jet;colorbar

subplot(2,3,5);pcolor(x/1000,y/1000,dVy);xlabel('x,km');ylabel('y,km');title('dVy/dy colormap,1/s')
set(gca,'ydir','reverse');shading interp;colormap jet;colorbar

subplot(2,3,6);pcolor(x/1000,y/1000,dV);xlabel('x,km');ylabel('y,km');title('div(V) colormap,1/s')
set(gca,'ydir','reverse');shading interp;colormap jet;colorbar