function [ Im ] = ReSimpleQuadTree( NewIm, Level, n )
% This MATLAB function reconstructs an image from compresses data by using
% the simple Quat Tree method.

Im = zeros(n);

for ii = 1:4
    if isa(NewIm{ii},'double')
        Im(:,:) = NewIm{ii};
    else
        switch ii
            case 1            
                Im(1:n/2,1:n/2) = ReSimpleQuadTree( NewIm{ii}, Level+1, n/2);
            case 2
                Im(1:n/2,n/2+1:end) = ReSimpleQuadTree( NewIm{ii}, Level+1, n/2);
            case 3
                Im(n/2+1:end,1:n/2) = ReSimpleQuadTree( NewIm{ii}, Level+1, n/2);
            case 4
                Im(n/2+1:end,n/2+1:end) = ReSimpleQuadTree( NewIm{ii}, Level+1, n/2);
        end
    end
end

if Level == 1
    imagesc(Im);
    colormap gray
    axis square
end

end