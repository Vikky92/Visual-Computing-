runFM;
imgA = imread('data/1/DSCF4177.jpg');
imgB = imread('data/1/DSCF4182.jpg');
imgC = imread('data/1/DSCF4186.jpg');
imgD = imread('data/1/DSCF4188.jpg');
imgE = imread('data/1/DSCF4190.jpg');
imgF = imread('data/1/DSCF4195.jpg');

% imgA = imread('data/2/DSCF4199.jpg');
% imgB = imread('data/2/DSCF4193.jpg');
% imgC = imread('data/2/DSCF4201.jpg');
% imgD = imread('data/2/DSCF4183.jpg');
% imgE = imread('data/2/DSCF4179.jpg');
% imgF = imread('data/1/DSCF4184.jpg');
imshow(imgA);
input = ginput(1);
figure;
imshow(imgA);hold on;
plot(input(:,1), input(:,2), 'go')


for i=1:5
    eLines = epipolarLine(fundMatrix(:,:,i),input);
    if (i==1)
        figure;
        imshow(imgB);
        points = lineToBorderPoints(eLines, size(imgB));
    end
    if(i==2)
        figure;
        imshow(imgC);
        points = lineToBorderPoints(eLines, size(imgC));
    end
    if(i==3)
        figure;
        imshow(imgD);
        points = lineToBorderPoints(eLines, size(imgD));
    end
    if(i==4)
        figure;
        imshow(imgE);
        points = lineToBorderPoints(eLines, size(imgE));
    end
    if(i==5)
        figure;
        imshow(imgF);
        points = lineToBorderPoints(eLines, size(imgF));
    end
    line(points(:, [1,3])', points(:, [2,4])','LineWidth',2);
end