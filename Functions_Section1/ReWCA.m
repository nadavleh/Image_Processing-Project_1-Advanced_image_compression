function [ NewIm ] = ReWCA(Wc, Ind, L, wn, Par, n)
% This function reconstructs an Image from compressed data 'Wc' and 'Ind'
% by doing the reverse actions to the WCA function.

qmf                 = MakeONFilter(wn, Par);

NewIm               = zeros(n^2,1);
NewIm(Ind)          = Wc;
NewIm               = reshape(NewIm, n, n);

NewIm               = IWT2_PO(NewIm,log2(n)-L,qmf);

end

