function [ fund_matrix ] = computeFundamentalMatrix(mPointsA, mPointsB )
aU = mPointsA(:,1);
aV = mPointsA(:,2);
bU = mPointsB(:,1);
bV = mPointsB(:,2);

A = zeros(length(aU),9);
for x = 1:length(aU)
    [u,v] = deal(aU(x),aV(x));
    [up,vp] = deal(bU(x),bV(x));
    A(x,:) = [u*up, v*up, up, u*vp, v*vp, vp, u, v, 1];
end

% solve Af=0 using SVD
[~,~,V] = svd(A);
f = V(:,end);
F = reshape(f,[3,3])'; 

% enforce det(F)=0 using svd
[U,S,V] = svd(F);
S(3,3) = 0;
fund_matrix = U*S*V';

end

