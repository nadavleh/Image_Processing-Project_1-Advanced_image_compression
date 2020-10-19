%% Section 2
% This script is tests the compress algorithms using Quad Tree technic. In
% each algorithm the image information is rearranged into a new struct
% (cell array). The main idea is to recognize homogeneous areas in the
% original image, and to unite their average color value into a singel
% cell. There are 3 different algorithm for each section:
% 
% 1. Simple Quad Tree - this algorithm divides the image into 4 squares 
% with the same size, and checks if the standard deviation of each square 
% is lower then a threshold value.
% 
% 2. Improved Quad Tree - this algorithm works the same as the Simple Quad
% Tree, only plus checking the possibility of dividing any image square 
% piece into two rectangels (vertical or horizontal).
% 
% 3. Improved Quad Tree II - this algorithm works the same as the Improved
% Quad Tree, only plus checking the possibility of dividing any image 
% square piece into two triangles by the square main diagonal line.

load wbarb
Threshold           = 10;

%% Simple Quad Tree

CompSimple = SimpleQuadTree(X, [], 1, Threshold );

figure(1)
subplot(1,2,1)
imagesc(X)
colormap gray
axis square
title('Original Image')

subplot(1,2,2)
NewImSimple = ReSimpleQuadTree(CompSimple,1,size(X,1));
title({'Compressed Image' ; 'Using Simple Quad Tree'});


%% Improved Quad Tree

CompImproved = ImprovedQuad(X, [], 1, Threshold );

figure(2)
subplot(1,2,1)
imagesc(X)
colormap gray
axis square
title('Original Image')

subplot(1,2,2)
NewImproved = ReImprovedQuad(CompImproved,1,size(X,1));
title({'Compressed Image' ; 'Using Improved Quad Tree'});


%% Improved Quad Tree II

CompImprovedII = ImprovedQuadII(X, [], 1, Threshold );

figure(3)
subplot(1,2,1)
imagesc(X)
colormap gray
axis square
title('Original Image')

subplot(1,2,2)
NewImprovedII = ReImprovedQuad(CompImprovedII,1,size(X,1));
title({'Compressed Image' ; 'Using Improved Quad Tree II'});
