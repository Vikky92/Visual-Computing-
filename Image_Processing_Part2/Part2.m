close all; 
clear all ;  %#ok<CLALL>
I = imread('Cross.jpg') ; 

I1 = rgb2gray(I);

figure,imshow(I1);

F1 = fftshift(fft2(I1)) ;
figure, imshow(1+log(abs(F1)),[]);
figure, imshow(angle(F1));