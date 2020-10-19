function [ NewIm ] = ReFCA( Fc, Ind, FullImR, FullImC )
% This function reconstructs an Image from compressed data 'Fc' and 'Ind'
% by doing the reverse actions to the FCA function.

NewIm = zeros(FullImR*FullImC,1);
NewIm(Ind) = Fc;
NewIm = reshape(NewIm, FullImR, FullImC);

NewIm = real(ifft2(NewIm));

end

