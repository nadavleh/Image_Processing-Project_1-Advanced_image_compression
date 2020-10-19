function [ Fc ] = BFCNA(Im, nb, c)
%% Blocks Non-Adaptive Compression - Fourier
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
NewInfoPerBlock = round(sqrt(InitInfoPerBlock/c))^2;
InitBlockSize = sqrt(InitInfoPerBlock);
NewBlockSize = sqrt(NewInfoPerBlock);

for ii = 1:nb
    for jj = 1:nb
        
        clear TempNew
        TempBlockFc = fftshift(fft2( Im((ii-1)*InitBlockSize+1:ii*InitBlockSize,(jj-1)*InitBlockSize+1:jj*InitBlockSize) ));
                
        diff = InitBlockSize - NewBlockSize;
        if mod(diff,2)
            TempNew = TempBlockFc( (diff+1)/2+1:(diff+1)/2+NewBlockSize,...
                (diff+1)/2+1:(diff+1)/2+NewBlockSize );
        else
            TempNew = TempBlockFc( diff/2+2:diff/2+NewBlockSize+1,...
                diff/2+2:diff/2+NewBlockSize+1 );
        end
        
        if mod(NewBlockSize,2)
            Index = (NewInfoPerBlock+NewBlockSize)/2*nb*(ii-1)+(NewInfoPerBlock+NewBlockSize)/2*(jj-1)+1;
            NextIndex = Index + (NewInfoPerBlock+NewBlockSize)/2 - 1;
            TempNew = TempNew(1:((NewBlockSize+1)/2),:);
        else
            Index = NewInfoPerBlock/2*nb*(ii-1)+NewInfoPerBlock/2*(jj-1)+1;
            NextIndex = Index + NewInfoPerBlock/2 - 1;
            TempNew = TempNew(1:(NewBlockSize/2),:);
        end
        
        Fc(Index:NextIndex,1) = TempNew(:); 
        
    end
end

end

