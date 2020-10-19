function [ Fc, Ind ] = FCA(Im, c)
%% Adaptive Compression - Fourier
% This function's input is an image (Im) and compration ratio ( c = size(Im)/size(NewIm) ).
% The function activates Fourier transform on the full image, and keeps the
% required information to reconstruct the image. The size of the saved
% information is equal to size(Im)/c.

InitInfo = size(Im,1)*size(Im,2);

BlockFc = fft2(Im);
[~, I] = sort(abs(BlockFc(:)),'descend');
FcSize = round(InitInfo/(2*c*1.5));

Ind(:,1) = I(1:FcSize);
Fc(1:FcSize,1) = BlockFc(I(1:FcSize));

end

