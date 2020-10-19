function [ Fc, Ind ] = BFCA(Im, nb, c)
%% Ass 2 - Section 3: Adaptive Compression
% This function's input is an image (Im), number of block per direction (nb), and 
% compration ratio ( c = size(Im)/size(NewIm) ). The function activates
% Fourier transform on each block, and keeps the required information to
% reconstruct the image. The size of the saved information is equal to size(Im)/c.

[SizeR, SizeC] = size(Im);

% removes the edges of the image to fit it to the nb if needed.
if mod(SizeR,nb)
    Im = Im(1:SizeR - mod(SizeR,nb),:);
end
if mod(SizeC,nb)
    Im = Im(:,1:SizeC - mod(SizeC,nb));
end

InitInfoPerBlock = size(Im,1)*size(Im,2)/nb^2;
InitBlockSize = sqrt(InitInfoPerBlock);

for ii = 1:nb
    for jj = 1:nb
        BlockFc((ii-1)*InitBlockSize+1:ii*InitBlockSize,(jj-1)*InitBlockSize+1:jj*InitBlockSize)...
            = fft2( Im((ii-1)*InitBlockSize+1:ii*InitBlockSize,(jj-1)*InitBlockSize+1:jj*InitBlockSize));
    end    
end

[~, I] = sort(abs(BlockFc(:)),'descend');
FcSize = round(size(Im,1)*size(Im,2)/(2*c*1.5));


Ind(:,1) = I(1:FcSize);
Fc(1:FcSize,1) = BlockFc(I(1:FcSize));


end


