%% Computing Fundamental Matrix for Correspondences in Set A and Set B
clear;
clc;
imgSetA = [     
        'C7782';
        'C7786';
        'C7788';
        'C7790';
        'C7795'; 
    ];

imgSetB = [       
        'C9993';
        'C9901';
        'C9983';
        'C9979'; 
        'C9984';
    ];

set = 1;
if (set == 1)
    imgs = imgSetA;
else
    imgs = imgSetB;
end
noOfImages = size(imgs,1);
fundMatrix = zeros(3,3,noOfImages);

for i=1:noOfImages
    load_file = strcat('data/', num2str(set), '/', imgs(i,:), '.txt');
    file = textread(load_file);
    mPointsA = file(:,1:2);
    mPointsB = file(:,3:4);    
    fundMatrix(:,:,i) = computeFundamentalMatrix(mPointsA,mPointsB,'Method','Norm8Point');
end
