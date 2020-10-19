function [ Im ] = ReImprovedQuad( NewIm, Level, n )
% This MATLAB function reconstructs an image from compresses data by using
% the simple Quat Tree method.

Im = zeros(n);

for ii = 1:4
    if isa(NewIm,'double')   
        if ~isscalar(NewIm)
            switch NewIm(1)
                case 1
                    m = NewIm(2);
                    Im(1:m,:) = NewIm(3);
                    Im(m+1:end,:) = NewIm(4);
                    return
                case 2
                    m = NewIm(2);
                    Im(:,1:m) = NewIm(3);
                    Im(:,m+1:end) = NewIm(4);
                    return
            end
        else
            Im(:,:) = NewIm;
            return
        end
    else
        switch ii
            case 1            
                Im(1:n/2,1:n/2) = ReImprovedQuad( NewIm{ii+1}, Level+1, n/2);
            case 2
                Im(1:n/2,n/2+1:end) = ReImprovedQuad( NewIm{ii+1}, Level+1, n/2);
            case 3
                Im(n/2+1:end,1:n/2) = ReImprovedQuad( NewIm{ii+1}, Level+1, n/2);
            case 4
                Im(n/2+1:end,n/2+1:end) = ReImprovedQuad( NewIm{ii+1}, Level+1, n/2);
        end
    end
end

if Level == 1
    imagesc(Im);
    colormap gray
    axis square
end

end

