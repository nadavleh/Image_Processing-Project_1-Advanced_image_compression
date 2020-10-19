function [ NewIm ] = ReBFCA( Fc, Ind, nb, FullImR, FullImC)
% This function reconstructs an Image from compressed data 'Fc' and 'Ind'
% by doing the reverse actions to the BFCA function.

InitInfoPerBlock = FullImR*FullImC/nb^2;
InitBlockSize = sqrt(InitInfoPerBlock);

BlockFc = zeros(FullImR*FullImC,1);
BlockFc(Ind) = Fc;
BlockFc = reshape(BlockFc, FullImR, FullImC);

for ii = 1:nb
    for jj = 1:nb
        BlockFc((ii-1)*InitBlockSize+1:ii*InitBlockSize,(jj-1)*InitBlockSize+1:jj*InitBlockSize)...
            = ifft2( BlockFc((ii-1)*InitBlockSize+1:ii*InitBlockSize,(jj-1)*InitBlockSize+1:jj*InitBlockSize));
    end
end

NewIm = real(BlockFc);

end

