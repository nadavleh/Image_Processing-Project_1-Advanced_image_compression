function [ Wc ] = WCNA(Im, wn, Par, c)
%% Non-Adaptive Compression - Wavelet
% This function's input is an image (Im), compration ratio ( c = size(Im)/size(NewIm) )
% and Wavelets type (wn). The function activates Wavelets transform on the full image,
% and keeps the required information to reconstruct the image. The size of the saved
% information is equal to size(Im)/c.

L               = c/4;
qmf             = MakeONFilter(wn,Par);
TempWc          = FWT2_PO(Im,log2(size(Im,1))-L, qmf);
Wc              = TempWc(1:size(Im,1)/log2(c),1:size(Im,1)/log2(c));
Wc              = Wc(:);

end

