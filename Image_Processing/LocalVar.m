function[EdgeDecision,var] = LocalVar(Image,row,col,window,T)
%finding the neighbours of the central pixel based on the window size 
w = (window-1)/2;
sum = 0.0 ;

for x =-w:1:w
    for y = -w:1:w
        sum=sum+Image(row+x,col+y);
    end
end
MeanLocal = sum / (window*window) ; 
%This is used to find the local mean of a particular central pixel

sum = 0.0 ;
for a = -w:1:w 
    for b=-w:1:w 
        sum = sum + ((Image(row+a,col+b)-MeanLocal)^2);
    end
end
var = sum/((window*window)-1);

if var > T 
    EdgeDecision =  255 ; 
else
    EdgeDecision = 0 ; 
end 
