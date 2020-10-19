function [ NewIm ] = SimpleQuadTree( Im, NewIm, Level, TH )
% This MATLAB function compresses images by using the Quad Tree, in order
% to recognize homogeneous parts in the picture.

n               = size(Im,1);               % Image's size
STD             = std(Im(:));               % STD of the specific Image

if STD < TH
    NewIm = mean(Im(:));
    return
end

if Level == 5                               % Higher resolution for lower levels
    TH = TH/2;
end

for ii = 1:4

    if log2(n) == 0
        NewIm = mean(Im(:));
        return
    end
    
    NewIm{ii} = [];
        
    switch ii  
        case 1
            NewIm{ii} = SimpleQuadTree( Im(1:n/2,1:n/2), NewIm{ii}, Level+1, TH);
        case 2
            NewIm{ii} = SimpleQuadTree( Im(1:n/2,n/2+1:end), NewIm{ii}, Level+1, TH);
        case 3
            NewIm{ii} = SimpleQuadTree( Im(n/2+1:end,1:n/2), NewIm{ii}, Level+1, TH);
        case 4
            NewIm{ii} = SimpleQuadTree( Im(n/2+1:end,n/2+1:end), NewIm{ii}, Level+1, TH);
    end
end

end

