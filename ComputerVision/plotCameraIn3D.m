function [ ] = plotCameraIn3D( rotation, translation,worldCoA,worldCoB)
% 'rotation' and 'translation' need to be (4x4xn) matrices
% noc is the number of cameras you want to plot
% 'worldCoA' and 'worldCoB' 3-D coordinates of two points A and B that you need
% to plot.
[~,~,noc] = size(rotation);

%% assign plot properties
figure;
hold on;
xlabel('x');
ylabel('y');
zlabel('z');
axis([-200 400 -200 400 0 500]);

% plot the planar checkerboard
plot3([0 200 200 0 0],[0 0 200 200 0],[0 0 0 0 0]); hold on;
% plot the blocks at the origin
trans = 0.85; % transparency
plotcube([64 64 19],[ 0  0  0],trans,[0 0 1]); % blue
plotcube([64 64 10],[ 0  0 19],trans,[1 0 0]); % red
plotcube([32 32 19],[16 16 29],trans,[0 1 0]); % center green
plotcube([32 32 19],[ 0 48 29],trans,[0 1 0]); % corner green
plotcube([32 32 19],[ 0 48 48],trans,[1 1 0]); % yellow

% Assuming default instrinsic parameters
f=5; % Focal Length
l=20; % Lenght of the rays.
cl=2; % Window size of camera
col=[0 0 0]; % Default Color
for i = 1:noc           
    
    transformation = [rotation(1:3,1:3,i)' translation(1:3,4,i);
             0 0 0 1]; 
    % Generate the 4 viewing rays that emanate from the principal point and
    % pass through the corners of the image.
    corner{1} = [-cl; -cl; f];
    corner{2} = [ cl; -cl; f];
    corner{3} = [ cl;  cl; f];
    corner{4} = [-cl;  cl; f];        
    for n = 1:4
        % Scale rays to length l and make homogeneous
        ray{n} = [corner{n}*l/f; 1];

        % Transform to world coords
        ray{n} = transformation*ray{n}; 

        % Draw the ray
        line([translation(1,4,i), ray{n}(1)],...
             [translation(2,4,i), ray{n}(2)],...
             [translation(3,4,i), ray{n}(3)], ...
             'color', [0 0 0]);        
    end

    % Draw rectangle joining ends of rays
    line([ray{1}(1) ray{2}(1) ray{3}(1) ray{4}(1) ray{1}(1)],...
         [ray{1}(2) ray{2}(2) ray{3}(2) ray{4}(2) ray{1}(2)],...
         [ray{1}(3) ray{2}(3) ray{3}(3) ray{4}(3) ray{1}(3)],...
         'color', [0 0 0]);                 

    % Draw and label axes
    X = transformation(1:3,1)*l + translation(1:3,4,i);
    Y = transformation(1:3,2)*l + translation(1:3,4,i);    
    Z = transformation(1:3,3)*l + translation(1:3,4,i);            

    line([translation(1,4,i), X(1,1)], [translation(2,4,i), X(2,1)], [translation(3,4,i), X(3,1)],...
         'color', col);        
    line([translation(1,4,i), Y(1,1)], [translation(2,4,i), Y(2,1)], [translation(3,4,i), Y(3,1)],...
         'color', col);        
    line([translation(1,4,i), Z(1,1)], [translation(2,4,i), Z(2,1)], [translation(3,4,i), Z(3,1)],...
         'color', col);        
    text(X(1), X(2), X(3), 'X', 'color', col,'FontSize',14);        
    text(Y(1), Y(2), Y(3), 'Y', 'color', col,'FontSize',14);   
end
    scatter3(worldCoA(1,:)', worldCoA(2,:)',worldCoA(3,:)','b.');
    scatter3(worldCoB(1,:)', worldCoB(2,:)',worldCoB(3,:)','r.');
axis equal;




