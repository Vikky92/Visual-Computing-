    clear all;
    close all;
    %Reading the first image 
    
    A_I = (imread('text.jpg')) ; %Input the Image 
    F = 1/4*ones(2); %Box filter for convolution
   
    figure,imshow(uint8(A_I)) ; % Display the original image 
    
    %Apply the Box filter on the image in stages and getting the Gaussian
    %Pyramid
    A_IC1 = convolution(A_I,F);
    A_I1=imresize(A_IC1,0.5,'Method','bilinear') ; 

    A_IC2 = convolution(A_I1,F) ; 
    A_I2 = imresize(A_IC2,0.5,'Method','bilinear')  ; 

    A_IC3 = convolution(A_I2,F) ; 
    A_I3= imresize(A_IC3,0.5,'Method','bilinear')  ; 

    A_IC4 = convolution(A_I3,F) ; 
    A_I4= imresize(A_IC4,0.5,'Method','bilinear')  ; 

    A_IC5 = convolution(A_I4,F) ; 
    A_I5= imresize(A_IC5,0.5,'Method','bilinear')  ; 

    A_IC6 = convolution(A_I5,F) ; 
    A_I6= imresize(A_IC6,0.5,'Method','bilinear')  ; 

    A_IC7 = convolution(A_I6,F) ; 
    A_I7= imresize(A_IC7,0.5,'Method','bilinear')  ; 

    A_IC8 = convolution(A_I7,F) ; 
    A_I8= imresize(A_IC8,0.5,'Method','bilinear')  ; 

    %As the images get smaller and harder to illustrate with every layer
    %imresize with bilinear interpolation is used. 
    
    
    A_G0 = A_I ; 
    A_G1=imresize(A_I1,2, 'Method', 'bilinear');
    A_G2=imresize(A_I2,4, 'Method', 'bilinear');
    A_G3=imresize(A_I3,8, 'Method', 'bilinear');
    A_G4=imresize(A_I4,16, 'Method', 'bilinear');
    A_G5=imresize(A_I5,32, 'Method', 'bilinear');
    A_G6=imresize(A_I6,64, 'Method', 'bilinear');
    A_G7=imresize(A_I7,128, 'Method', 'bilinear');
    

    
    figure('name','Laplacian Pyramid ');
    
    %Compute the Laplacian Pyramid as mentioned 

    A_0=double(A_G0)-A_G1;
    subplot(3,3,1);
    imshow(uint8(A_0)) ;

    A_1=A_G1-A_G2;
    subplot(3,3,2);
    imshow(uint8(A_1)) ;

    A_2=A_G2-A_G3;
    subplot(3,3,3);
    imshow(uint8(A_2)) ;

    A_3=A_G3-A_G4;
    subplot(3,3,4);
    imshow(uint8(A_3)) ;

    A_4=A_G4-A_G5;
    subplot(3,3,5);
    imshow(uint8(A_4)) ;

    A_5=A_G5-A_G6;
    subplot(3,3,6);
    imshow(uint8(A_5)) ;

    A_6=A_G6-A_G7;
    subplot(3,3,7);
    imshow(uint8(A_6)) ;
    
    A_7=A_6 ; 


    %Laplacian Operator(L) used at each level of the Gaussian Pyramid (G0 to G7)
    pause(3);
    close all ;
    
    B_I = (imread('polarcities.jpg')) ; %Input the Image 
   
    figure,imshow(uint8(B_I)) ; % Display the original image 
    
    %Apply the Box filter on the image in stages 

    B_IC1 = convolution(B_I,F);
    B_I1=imresize(B_IC1,0.5,'Method','bilinear') ; 

    B_IC2 = convolution(B_I1,F) ; 
    B_I2 = imresize(B_IC2,0.5,'Method','bilinear')  ; 

    B_IC3 = convolution(B_I2,F) ; 
    B_I3= imresize(B_IC3,0.5,'Method','bilinear')  ; 

    B_IC4 = convolution(B_I3,F) ; 
    B_I4= imresize(B_IC4,0.5,'Method','bilinear')  ; 

    B_IC5 = convolution(B_I4,F) ; 
    B_I5= imresize(B_IC5,0.5,'Method','bilinear')  ; 

    B_IC6 = convolution(B_I5,F) ; 
    B_I6= imresize(B_IC6,0.5,'Method','bilinear')  ; 

    B_IC7 = convolution(B_I6,F) ; 
    B_I7= imresize(B_IC7,0.5,'Method','bilinear')  ; 

    B_IC8 = convolution(B_I7,F) ; 
    B_I8= imresize(B_IC8,0.5,'Method','bilinear')  ; 

    B_G0 = B_I ; 
    B_G1=imresize(B_I1,2, 'Method', 'bilinear');
    B_G2=imresize(B_I2,4, 'Method', 'bilinear');
    B_G3=imresize(B_I3,8, 'Method', 'bilinear');
    B_G4=imresize(B_I4,16, 'Method', 'bilinear');
    B_G5=imresize(B_I5,32, 'Method', 'bilinear');
    B_G6=imresize(B_I6,64, 'Method', 'bilinear');
    B_G7=imresize(B_I7,128, 'Method', 'bilinear');

    figure('name','Laplacian Pyramid ');
    
    B_0=double(B_G0)-B_G1;
    subplot(3,3,1);
    imshow(uint8(B_0)) ;

    B_1=B_G1-B_G2;
    subplot(3,3,2);
    imshow(uint8(B_1)) ;

    B_2=B_G2-B_G3;
    subplot(3,3,3);
    imshow(uint8(B_2)) ;

    B_3=B_G3-B_G4;
    subplot(3,3,4);
    imshow(uint8(B_3)) ;

    B_4=B_G4-B_G5;
    subplot(3,3,5);
    imshow(uint8(B_4)) ;

    B_5=B_G5-B_G6;
    subplot(3,3,6);
    imshow(uint8(B_5)) ;

    B_6=B_G6-B_G7;
    subplot(3,3,7);
    imshow(uint8(B_6)) ;
    
    B_7=B_6 ;

    pause(3);
    close all ; 
    

    %Creating the mask 
    [x1,y1] = size(A_I) ; 
    [x2,y2] = size(B_I) ; 
    
    for i = 1:x1/2 
        for j = 1:y1 
            G_I(j,i) = 0 ; 
        end
    end
    
     
    for i = x2/2:x2 
        for j = 1:y2 
            G_I(j,i) = 1; 
        end
    end
    
    title('Mask for blending') ;
    imshow(G_I) ; 
    
    G_IC1 = convolution(G_I,F);
    G_I1=imresize(G_IC1,0.5,'Method','bilinear') ; 

    G_IC2 = convolution(G_I1,F) ; 
    G_I2 = imresize(G_IC2,0.5,'Method','bilinear')  ; 

    G_IC3 = convolution(G_I2,F) ; 
    G_I3= imresize(G_IC3,0.5,'Method','bilinear')  ; 

    G_IC4 = convolution(G_I3,F) ; 
    G_I4= imresize(G_IC4,0.5,'Method','bilinear')  ; 

    G_IC5 = convolution(G_I4,F) ; 
    G_I5= imresize(G_IC5,0.5,'Method','bilinear')  ; 

    G_IC6 = convolution(G_I5,F) ; 
    G_I6= imresize(G_IC6,0.5,'Method','bilinear')  ; 

    G_IC7 = convolution(G_I6,F) ; 
    G_I7= imresize(G_IC7,0.5,'Method','bilinear')  ; 

    G_IC8 = convolution(G_I7,F) ; 
    G_I8= imresize(G_IC8,0.5,'Method','bilinear')  ; 

    %As the images get smaller and harder to illustrate with every layer
    %imresize with bilinear interpolation is used. 
    
    
    G_0 =G_I ; 
    G_1=imresize(G_I1,2, 'Method', 'bilinear');
    G_2=imresize(G_I2,4, 'Method', 'bilinear');
    G_3=imresize(G_I3,8, 'Method', 'bilinear');
    G_4=imresize(G_I4,16, 'Method', 'bilinear');
    G_5=imresize(G_I5,32, 'Method', 'bilinear');
    G_6=imresize(G_I6,64, 'Method', 'bilinear');
    G_7=imresize(G_I7,128, 'Method', 'bilinear');
    
    
    close all ; 
    
    Blended = 0 ; 
    
    for k = 0:7 
          G = eval(['G_',num2str(k)]) ;
          A = eval(['A_',num2str(k)]) ;
          B = eval(['B_',num2str(k)]) ; 
        for i = 1 : 256 
            for j = 1: 256 
                C(i,j) = A(i,j)*G(i,j) + (1-G(i,j)) * B(i,j) ;    
            end
        end
        
        Blended = Blended + C ;
        
    end
   
    Blended(Blended < 0) = 0;
    Blended(Blended > 255) = 255;
    
    imshow(uint8(Blended));
    imwrite(uint8(Blended),['Blended_'], 'jpg');    
    
    
            
    
  
    
    
    


                           
                   
                        


    


                           
                   
                        