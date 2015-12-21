clc;
clear all;
close all;
im = imread('moonlanding.png');
figure,imshow(im);

FT = fft2(double(im));
FT1 = fftshift(FT);%finding spectrum
figure,imshow(abs(FT1),[]);

x = size(im,1);
y = size(im,2);

t = 0:pi/5:2*pi;
xcen=(x+150)/2; % point around which we filter image
ycen=(y-150)/2;
r=200;   %Radium of circular region of interest(for BRF)
r1 = 40;
xcc = r*cos(t)+xcen;
ycc =  r*sin(t)+ycen;

xcc1 = r1*cos(t)+xcen;
ycc1 =  r1*sin(t)+ycen;

m = poly2mask(double(xcc),double(ycc), x,y);
m1 = poly2mask(double(xcc1),double(ycc1), x,y); %generating mask for filtering

m(m1)=0;

FT2=FT1;
FT2(m)=0;%cropping area or bandreject filtering

figure,imshow(1+log(abs(FT2)),[]);
output = ifft2(ifftshift(FT2));
figure,imshow(output,[]);
