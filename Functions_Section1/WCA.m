function [ Wc,Ind ] = WCA(Im, L, wn, Par, c)
%% Adaptive Compression - Wavelet
% This function's input is an image (Im), compration ratio ( c = size(Im)/size(NewIm) ),
% deepest Wavelets level (L) and Wavelets type (wn). The function activates
% Wavelets Transform on the full image, and keeps the required information
% to reconstruct the image. The size of the saved information is equal to size(Im)/c.

InitInfo = size(Im,1)*size(Im,2);

qmf             = MakeONFilter(wn, Par);
TempWc          = FWT2_PO(Im,log2(size(Im,1))-L, qmf);

[~, I]          = sort(TempWc(:),'descend');
WcSize          = InitInfo/(2*c);

Ind(:,1)        = I(1:WcSize);
Wc(1:WcSize,1)  = TempWc(I(1:WcSize));

end

