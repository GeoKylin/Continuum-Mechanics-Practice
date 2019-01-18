clear
close all
clc

e(1,1,:)=[0 0 0];
e(1,2,:)=[0 0 1];
e(1,3,:)=[0 -1 0];
e(2,1,:)=[0 0 -1];
e(2,2,:)=[0 0 0];
e(2,3,:)=[1 0 0];
e(3,1,:)=[0 1 0];
e(3,2,:)=[-1 0 0];
e(3,3,:)=[0 0 0];
i=1:1:3;
j=i;
k=i;
[i,j,k]=meshgrid(i,j,k);
xs=[1,2,3];
ys=xs;
zs=xs;
figure;slice(i,j,k,e,xs,ys,zs);shading interp;colormap hsv;colorbar;box on;
xlabel('i');ylabel('j');zlabel('k');
title('三阶各项同性体：\epsilon_{ijk}')