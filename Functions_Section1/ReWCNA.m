function [ NewIm ] = ReWCNA(Wc, c, wn, Par, n)
% This function reconstructs an Image from compressed data 'Wc'
% by doing the reverse actions to the WCNA function.

L                       = c/4;
qmf                     = MakeONFilter(wn, Par);
Wc                      = reshape(Wc,n/log2(c),n/log2(c));

Wc(size(Wc,1)+1:n,size(Wc,2)+1:n) = 0;

NewIm                   = IWT2_PO(Wc,log2(n)-L,qmf);

end

