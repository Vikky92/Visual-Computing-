Images = {'CARTOON.jpg','flowergray.jpg','kitty.jpg','polarcities.jpg','text.jpg'};


for im = 1 : 5 
    
    I = double(imread(Images{im})) ; %Input the Image 
    F = 1/4*ones(2); %Box filter for convolution
   
    figure,imshow(uint8(I)) ; % Display the original image 
    title('Original Image');
    
    %Applying the Box filter on the original image in stages 
    IC1 = convolution(I,F);
    I1=imresize(IC1,0.5,'Method','bilinear') ; 
    figure,imshow(uint8(IC1));
    title('Image at stage 1 ');

    IC2 = convolution(I1,F) ; 
    I2 = imresize(IC2,0.5,'Method','bilinear')  ; 
    figure,imshow(uint8(IC2));
    title('Image at stage 2');

    IC3 = convolution(I2,F) ; 
    I3= imresize(IC3,0.5,'Method','bilinear')  ; 
    figure,imshow(uint8(IC3));
    title('Image at stage 3');

    IC4 = convolution(I3,F) ; 
    I4= imresize(IC4,0.5,'Method','bilinear')  ; 
    figure,imshow(uint8(IC4));
    title('Image at stage 4');

    IC5 = convolution(I4,F) ; 
    I5= imresize(IC5,0.5,'Method','bilinear')  ; 
    figure,imshow(uint8(IC5));
    title('Image at stage 5');

    IC6 = convolution(I5,F) ; 
    I6= imresize(IC6,0.5,'Method','bilinear')  ; 
    figure,imshow(uint8(IC6));
    title('Image at stage 6');

    IC7 = convolution(I6,F) ; 
    I7= imresize(IC7,0.5,'Method','bilinear')  ; 
    figure,imshow(uint8(IC7));
    title('Image at stage 7');

    IC8 = convolution(I7,F) ; 
    I8= imresize(IC8,0.5,'Method','bilinear')  ; 
    figure,imshow(uint8(IC8));
    pause(3);
    close all;

    %As the images get smaller and harder to illustrate with every layer
    %imresize with bilinear interpolation is used. 
    
    figure('name','Gaussian Pyramid');
    
    G0 = I ; 
    subplot(3,3,1)
    imshow(uint8(G0))
    imwrite(uint8(G0), ['G0_',Images{im}], 'jpg');
    
    G1=imresize(I1,2, 'Method', 'bilinear');
    subplot(3,3,2)
    imshow(uint8(G1));
    imwrite(uint8(G1), ['G1_',Images{im}], 'jpg');


    G2=imresize(I2,4, 'Method', 'bilinear');
    subplot(3,3,3)
    imshow(uint8(G2));
    imwrite(uint8(G2), ['G2_',Images{im}], 'jpg');


    G3=imresize(I3,8, 'Method', 'bilinear');
    subplot(3,3,4)
    imshow(uint8(G3));    
    imwrite(uint8(G3), ['G3_',Images{im}], 'jpg');


    G4=imresize(I4,16, 'Method', 'bilinear');
    subplot(3,3,5)
    imshow(uint8(G4));
    imwrite(uint8(G4), ['G4_',Images{im}], 'jpg');

    G5=imresize(I5,32, 'Method', 'bilinear');
    subplot(3,3,6)
    imshow(uint8(G5));
    imwrite(uint8(G5), ['G5_',Images{im}], 'jpg');

    G6=imresize(I6,64, 'Method', 'bilinear');
    subplot(3,3,7)
    imshow(uint8(G6));
    imwrite(uint8(G6), ['G6_',Images{im}], 'jpg');
    
    G7=imresize(I7,128, 'Method', 'bilinear');
    subplot(3,3,8)
    imshow(uint8(G7));
    imwrite(uint8(G7), ['G7_',Images{im}], 'jpg');
    
    figure('name','Laplacian Pyramid ');
    
    %Compute the Laplacian Pyramid as mentioned 

    L0=double(G0)-G1;
    subplot(3,3,1);
    imshow(uint8(L0)) ;
    imwrite(uint8(L0), ['L0_',Images{im}], 'jpg');


    L1=G1-G2;
    subplot(3,3,2);
    imshow(uint8(L1)) ;
    imwrite(uint8(L1), ['L1_',Images{im}], 'jpg');

    L2=G2-G3;
    subplot(3,3,3);
    imshow(uint8(L2)) ;
    imwrite(uint8(L2), ['L2_',Images{im}], 'jpg');

    L3=G3-G4;
    subplot(3,3,4);
    imshow(uint8(L3)) ;
    imwrite(uint8(L3), ['L3_',Images{im}], 'jpg');

    L4=G4-G5;
    subplot(3,3,5);
    imshow(uint8(L4)) ;
    imwrite(uint8(L4), ['L4_',Images{im}], 'jpg');

    L5=G5-G6;
    subplot(3,3,6);
    imshow(uint8(L5)) ;
    imwrite(uint8(L5), ['L5_',Images{im}], 'jpg');

    L6=G6-G7;
    subplot(3,3,7);
    imshow(uint8(L6)) ;
    imwrite(uint8(L6), ['L6_',Images{im}], 'jpg');

    %Laplacian Operator(L) used at each level of the Gaussian Pyramid (G0 to G7)
    pause(2);
    close all ; 

    L = [-1/8 -1/8 -1/8; -1/8 1 -1/8; -1/8 -1/8 -1/8];

    for i = 0:7 
        GC = convolution(eval(['G',num2str(i)]),L); %convolution with of G with L 
    % figure, imshow(GC); 
    
    [x,y] = size(GC); 

    %Segmentation
    for a = 1:x 
        for b = 1:y
            if GC(a,b) > 0 
                GSegment{i+1}(a,b)=1;
            else
                GSegment{i+1}(a,b)=0;
            end
        end
    end

    windowsize =3 ;
    T=100;  %T being the threshold required for edge detection

    for k=2:x-1  % Edge detection for a single layer
        for l=2:y-1
            if GSegment{i+1}(k-1,l-1)~=GSegment{i+1}(k,l)
                [GEdge{i+1}(k,l),var]=LocalVar(GC,k,l,windowsize,T);            
            elseif GSegment{i+1}(k-1,l)~=GSegment{i+1}(k,l)
                [GEdge{i+1}(k,l),var]=LocalVar(GC,k,l, windowsize, T);
            elseif GSegment{i+1}(k-1,l+1)~=GSegment{i+1}(k,l)
                [GEdge{i+1}(k,l), var]=LocalVar(GC,k,l, windowsize,T);
            elseif GSegment{i+1}(k,l+1)~=GSegment{i+1}(k,l)
                [GEdge{i+1}(k,l), var]=LocalVar(GC,k,l, windowsize,T);
            elseif GSegment{i+1}(k+1,l+1)~=GSegment{i+1}(k,l)
                [GEdge{i+1}(k,l),var]=LocalVar(GC,k,l, windowsize,T);
            elseif GSegment{i+1}(k+1,l)~=GSegment{i+1}(k,l)
                [GEdge{i+1}(k,l), var]=LocalVar(GC,k,l, windowsize,T);
            elseif GSegment{i+1}(k+1,l-1)~=GSegment{i+1}(k,l)
                [GEdge{i+1}(k,l),var]=LocalVar(GC,k,l, windowsize, T);
            elseif GSegment{i+1}(k,l-1)~=GSegment{i+1}(k,l)
                [GEdge{i+1}(k,l),var]=LocalVar(GC,k,l, windowsize,T);            
            end
        end
    end %Edge detection for a single layer 

    ImageEdgeDet = GEdge{i+1} ; %Form the Image of the Edges
    figure, imshow(uint8(ImageEdgeDet)) ;
    imwrite(uint8(ImageEdgeDet), ['Edge_',num2str(x),Images{im}], 'jpg');


    end
    pause(15);
    close all;
    clearvars -except Images  ;
end

    



                           
                   
                        