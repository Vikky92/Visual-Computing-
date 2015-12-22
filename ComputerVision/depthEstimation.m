function [ XYZPoints ] = depthEstimation(CalibMatrix,camCo)
% camCo is an m x 2 x noOfCameras containing the m correspondence.
% CalibMatrix is the calibration matrix for numOfCameras (3 x 4 x
% noOfCamers)
[~,~,numCameras] = size(CalibMatrix);
% [~,numPts,numData] = size(data);
[numPts,~,~] = size(camCo);
for p = 1 : numPts
    %% Set up a linear system of equations for solving depth equation containg all the cameras
    linsys = zeros(numCameras,4);
    for cam = 1 : numCameras
        row = 2 * cam - 1; 
        % Writing the equation in the form of Ax = 0;
        % u-coordinate row
        linsys(row,1) = camCo(p,1,cam)*CalibMatrix(3,1,cam) - CalibMatrix(1,1,cam);
        linsys(row,2) = camCo(p,1,cam)*CalibMatrix(3,2,cam) - CalibMatrix(1,2,cam);
        linsys(row,3) = camCo(p,1,cam)*CalibMatrix(3,3,cam) - CalibMatrix(1,3,cam);
        linsys(row,4) = camCo(p,1,cam)*CalibMatrix(3,4,cam) - CalibMatrix(1,4,cam);
        % v-coordinate row
        linsys(row+1,1) = camCo(p,2,cam)*CalibMatrix(3,1,cam) - CalibMatrix(2,1,cam);
        linsys(row+1,2) = camCo(p,2,cam)*CalibMatrix(3,2,cam) - CalibMatrix(2,2,cam);
        linsys(row+1,3) = camCo(p,2,cam)*CalibMatrix(3,3,cam) - CalibMatrix(2,3,cam);
        linsys(row+1,4) = camCo(p,2,cam)*CalibMatrix(3,4,cam) - CalibMatrix(2,4,cam);
    end

    %% Solve the linear system with SVD
    [U,S,V] = svd(linsys);
    % Solution is the vector V with lowest 
    P = V(:,end);    
    % Finding out original coordinates from 4-D Homogenous Coordinates
    XYZPoints(:,p) = P ./ P(end);
    
end