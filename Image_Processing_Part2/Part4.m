clc ; 
clear all;
close all ; 

for x = 1 : 32 
    for y = 1 : 64  
        I(y,x)= 1; 
    end
end

for x = 33 : 64 
    for y = 1 : 64  
        I(y,x)= 0 ; 
    end
end

figure,imshow(I,[])

F = fftshift(fft2(double(I)));
figure,imshow(1+log(abs(F)),[]);
figure,imshow(angle(F));

for x = 65 :  128 
    for y = 1 : 64
        I(y,x)=0;
    end
end
    
for y = 65 :  128 
    for x = 1 : 64
        I(y,x)=0;
    end
end

figure,imshow(I,[])

F = fftshift(fft2(double(I)));
figure,imshow(abs(F),[]);
figure,imshow(angle(F));

for x = 129 :  256
    for y = 1 : 128
        I(y,x)=0;
    end
end
    
for y = 129 :  256 
    for x = 1 : 128
        I(y,x)=0;
    end
end

figure,imshow(I,[])

F = fftshift(fft2(double(I)));
figure,imshow(abs(F),[]);
figure,imshow(angle(F));


for x = 257 :  512
    for y = 1 : 256
        I(y,x)=0;
    end
end
    
for y = 257 :  512 
    for x = 1 : 256
        I(y,x)=0;
    end
end

figure,imshow(I,[])
F = fftshift(fft2(double(I)));
figure,imshow(abs(F),[]);
figure,imshow(angle(F));
