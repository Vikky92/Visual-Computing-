%% Computing Calibration Matrix for all the images in a particular set.
clear all;
clc;
imgSetA = [
        'DSCF4177';
        'DSCF4182';
        'DSCF4186';
        'DSCF4188';
        'DSCF4190';  
        'DSCF4195'; 
    ];

imgSetB = [ 
        'DSCF4199';
        'DSCF4193';  
        'DSCF4201';
        'DSCF4183'; 
        'DSCF4179';  
        'DSCF4184';  
    ];

set = 1;

if set==1
    imgs = imgSetA;
else
    imgs = imgSetB;
end

noOfImages = size(imgs,1);
calibMatrix = zeros(3,4,noOfImages);
intrinsic = reshape(repmat(eye(4,4),1,noOfImages), 4,4,noOfImages);
rotation = reshape(repmat(eye(4,4),1,noOfImages), 4,4,noOfImages);
translation = reshape(repmat(eye(4,4),1,noOfImages), 4,4,noOfImages);

for i=1:noOfImages
    load_file = strcat('data/', num2str(set), '/', imgs(i,:), '_2D_3D.txt');
    file = textread(load_file);
    wordlCo = file(:,1:4);
    imgCo = file(:,5:6);    
    [C,K,R,T] = calibrateCamera(wordlCo,imgCo);
    calibMatrix(:,:,i) = C;
    intrinsic(1:3,1:3,i) = K;
    rotation(1:3,1:3,i) = R;
    translation(1:3,4,i) = T;
end

    
    
    

