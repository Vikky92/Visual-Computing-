%This function is used to find the convolution 
function [Output_Image] = convolution(I,F) 

[ih,iw]= size(I); %Return the dimensions of the Original Image
[fh,fw]= size(F); %Return the dimension of the filter 


Output_Image = zeros(ih,iw); 

for iy = 1:ih 
    for ix = 1:iw 
        SumOfPixels  = 0 ;
        
        fy =1;
        fx = fw;
        
        for y = 1:fh 
            for x = 1:fw 
                
                if(iy+y-1 <=ih && ix-x+1>=1)
                    SumOfPixels = SumOfPixels + I(iy+y-1,ix-x+1)*F(fy+y-1,fx-x+1);
                end
            end
        end
        Output_Image(iy,ix) = SumOfPixels; 
    end
end
end
