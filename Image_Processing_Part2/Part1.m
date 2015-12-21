close all; 
clear all;  %#ok<CLALL>

for x = 1 : 512 
    for y = 1 : 512  
        I(x,y)= sin(0.1*x) + sin(0.2*x) + cos(0.4*x) + sin(sqrt(x^2+y^2)*0.15)+ sin(sqrt(x^2+y^2)*0.35);
    end
end

figure,imshow(I,[]);
title('Original Image') ; 

F = fft2(double(I));
F_mag = abs(fftshift(F));
F_phase = angle(fftshift(F));
figure,imshow(abs(fftshift(F)),[])
title('This is the magnitude plot of the FFT') ; 

figure,imshow(angle(fftshift(F)),[-pi,pi])
title('This is the phase plot of the FFT') ; 

F1 = 2*abs(F).*exp(i*angle(F)); %#ok<IJCL>
I1=ifft2(F1);
figure,imshow(I1,[]);

F11 = fft2(double(I1));
figure,imshow(abs(fftshift(F11)),[])



