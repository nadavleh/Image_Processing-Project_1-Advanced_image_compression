%% Section 1
% This is a test script that shows the differences between the different 
% compression methods:
% Method A - Non-Adaptive compression using Fourier transform.
% Method B - Adaptive compression using Fourier transform.
% Method C - Adaptive and Non-Adaptive compression using Fourier transform, and by dividing the image into blocks.
% Method D - Adaptive and Non-Adaptive compression using Wavelet transform.
% 
% Methods A&B had been tested for different compression ratio (c). Method C
% had also been tested for different blocks number (nb). Method D had also
% been tested for different Wavelets types (wn) and levels (L).
% 
% Note: in Section D, the functions uses the MATLAB library 'Wavelab850'.

clc; clear;
load wbarb

c               = 4;                % compression ratio

nb              = 32;               % number of blocks

wn              = 'Daubechies';           % Wavelets type (Haar / Daubechies)
Par             = 14;                % Wavelets type's parameter
L               = 2;                % Wavelets Level


%% A&B: Non-Adaptive and Adaptive compression using Fourier transform.

FcNA            = FCNA(X,c);        % Non-Adaptive
[FcA, Ind]      = FCA(X,c);         % Adaptive

% It is possiable to see that the memory size of FcNA and (FcA + Ind) is
% equal to Bytes(X)/c.
fprintf('Sections A&B:\nHere you can see the sizes of the compressed images using Fourier Transform in both Adaptive and Non-Adaptive ways.\n\n');
whos FcNA FcA Ind X

SizeX           = whos('X');
SizeFcA         = whos('FcA');
SizeInd         = whos('Ind');
SizeFcNA        = whos('FcNA');

% Reconstruct both compressed images.
NewImA          = ReFCA(FcA,Ind,size(X,1),size(X,2));
NewImNA         = ReFCNA(FcNA,size(X,1),size(X,2),c);

figure(1)
subplot(1,3,1)
imagesc(X)
title({'Original Image';['Size = ', num2str(SizeX.bytes), ' Bytes']})
axis square
subplot(1,3,2)
imagesc(NewImNA)
title({'Non-Aaptive Compressed Image';['Size(FcNA) = ', num2str(SizeFcNA.bytes), ' Bytes']})
axis square
subplot(1,3,3)
imagesc(NewImA)
title({'Adaptive Compressed Image';['Size(FcA + Ind) = ', ...
    num2str(SizeFcA.bytes + SizeInd.bytes), ' Bytes']})
axis square
colormap gray



%% C: Non-Adaptive and Adaptive blocks compression using Fourier transform.

% Compress in both methods.
BFcNA           = BFCNA(X,nb,c);    % Non-Adaptive
[BFcA, BInd]    = BFCA(X,nb,c);     % Adaptive

% It is possiable to see that the memory size of FcNA and (FcA + Ind) is
% equal to Bytes(X)/c.
fprintf('Section C:\nHere you can see the sizes of the compressed images using Blocks Fourier Transform both Adaptive and Non-Adaptive ways.\n\n');
whos BFcNA BFcA BInd X

SizeX = whos('X');
SizeBFcA = whos('BFcA');
SizeBInd = whos('BInd');
SizeBFcNA = whos('BFcNA');

% Reconstruct both compressed images.
NewImBA = ReBFCA(BFcA,BInd,nb,size(X,1),size(X,2));
NewImBNA = ReBFCNA(BFcNA,nb,size(X,1),size(X,2),c);

% Activets the blocks lines cleaner.
ClearImBA = CompressClear(NewImBA,nb);
ClearImBNA = CompressClear(NewImBNA,nb);

figure(2)
subplot(1,3,1)
imagesc(X)
title({'Original Image';['Size = ', num2str(SizeX.bytes), ' Bytes']})
axis square
subplot(1,3,2)
imagesc(ClearImBNA)
title({'Non-Aaptive Compressed Image';['Size(BFcNA) = ', num2str(SizeBFcNA.bytes), ' Bytes']})
axis square
subplot(1,3,3)
imagesc(ClearImBA)
title({'Adaptive Compressed Image';['Size(BFcA + BInd) = ', ...
    num2str(SizeBFcA.bytes + SizeBInd.bytes), ' Bytes']})
axis square
colormap gray

figure(3)
subplot(1,2,1)
imagesc(NewImBNA)
title('Non-Adaptive: Before')
axis square
subplot(1,2,2)
imagesc(ClearImBNA)
title('Non-Adaptive: After')
axis square
colormap gray

figure(4)
subplot(1,2,1)
imagesc(NewImBA)
title('Adaptive: Before')
axis square
subplot(1,2,2)
imagesc(ClearImBA)
title('Adaptive: After')
axis square
colormap gray


%% D: Adaptive and Non-Adaptive compression using Wavelet transform.

WcNA            = WCNA(X, wn, Par, c);   % Non-Adaptive
[WcA, WInd]     = WCA(X ,L, wn, Par, c); % Adaptive

% It is possiable to see that the memory size of FcNA and (FcA + Ind) is
% equal to Bytes(X)/c.
fprintf('Section D:\nHere you can see the sizes of the compressed images using Wavelets Transform in both Adaptive and Non-Adaptive ways.\n\n');
whos WcNA WcA WInd X

SizeX           = whos('X');
SizeWcA         = whos('WcA');
SizeWInd        = whos('WInd');
SizeWcNA        = whos('WcNA');

% Reconstruct both compressed images.
NewImWA         = ReWCA(WcA, WInd, L, wn, Par, size(X,1));
NewImWNA        = ReWCNA(WcNA, c, wn, Par, size(X,1));

figure(5)
subplot(1,3,1)
imagesc(X)
title({'Original Image';['Size = ', num2str(SizeX.bytes), ' Bytes']})
axis square
subplot(1,3,2)
imagesc(NewImWNA)
title({'Non-Aaptive Compressed Image';['Size(WcNA) = ', num2str(SizeWcNA.bytes), ' Bytes']})
axis square
subplot(1,3,3)
imagesc(NewImWA)
title({'Adaptive Compressed Image';['Size(WcA + WInd) = ', ...
    num2str(SizeWcA.bytes + SizeWInd.bytes), ' Bytes']})
axis square
colormap gray
