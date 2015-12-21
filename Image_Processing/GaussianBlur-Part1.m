clear all; 
close all; 
Image = imread('CARTOON.jpg') ; 
for k =  1:4 %Varying the standard deviation for the Gaussian Filter
    Iblur = imgaussfilt(Image,k) ; 
    subplot(2,2,k)
    imshow(uint8(Iblur))
    if(k==1)
        title(['Original Image'])
    else
        title(['Gaussian filtered image, \sigma = ' ,num2str(k)])
    end
end