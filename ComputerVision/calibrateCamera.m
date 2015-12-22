function [ C,K,R,T ] = calibrateCamera(worldCo, imgCo )
n = size(worldCo,1);
P(1:2*n,1:12) = 0; % The Project Matrix P 
j=1;
%construct matrix P
for i=1:2:2*n    
    P(i,1) = worldCo(j,1); P(i+1,5) = worldCo(j,1);
    P(i,2) = worldCo(j,2); P(i+1,6) = worldCo(j,2);
    P(i,3) = worldCo(j,3); P(i+1,7) = worldCo(j,3);
    P(i,4) = worldCo(j,4); P(i+1,8) = worldCo(j,4);
    P(i,9:12) = P(i,1:4)*-1*imgCo(j,1);
    P(i+1,9:12) = P(i,1:4)*-1*imgCo(j,2);
    j = j+1;
end

%Perform SVD of P
[U S V] = svd(P);
[min_val, min_index] = min(diag(S(1:12,1:12)));
%m is given by right singular vector of min. singular value
m = V(1:12, min_index);
norm_31 = norm(m(9:11));
m_canonical = m / norm_31;
calibMatrix = reshape(m_canonical,[4 3])';
C=calibMatrix;
M = zeros(3,3);
M(1,:) = calibMatrix(1,1:3);
M(2,:) = calibMatrix(2,1:3);
M(3,:) = calibMatrix(3,1:3);
MT = calibMatrix(1:3,4);
[K R] = rq(M);
K = abs(K);
K = K./K(end:end);
Minv = inv(M);
% R = inv(R);
T = -Minv*MT;