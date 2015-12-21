clc;
clear all;
close all;
im = imread('psnr2.png');
im1 = imread('cameraman.jpg');
im = rgb2gray(im);
im1 = rgb2gray(im1);
figure,imshow(im);
FT = fft2(double(im));
FT1 = fftshift(FT);%finding spectrum

FT2 = fft2(double(im1));
FT22 = fftshift(FT2);

figure,imshow(1+log(abs(FT1)),[]);
title('Noise');
figure,imshow(1+log(abs(FT22)),[]);
title('Original');

x = size(im,1);
y = size(im,2);

t = 0:pi/20:2*pi;
xcen=129; % point around which we filter image
ycen=130;
r=128;   %Radium of circular region of interest(for BRF)
r1 =60;
xcc = r*cos(t)+xcen;
ycc =  r*sin(t)+ycen;

xcc1 = r1*cos(t)+xcen;
ycc1 =  r1*sin(t)+ycen;

m = poly2mask(double(xcc),double(ycc), x,y);
m1 = poly2mask(double(xcc1),double(ycc1), x,y);%generating mask for filtering

m(m1)=0;

FT2=FT1;
FT2(m)=0;%cropping area or bandreject filtering

figure,imshow(1+log(abs(FT2)),[]);
output = ifft2(ifftshift(FT2));
figure,imshow(output,[]);
