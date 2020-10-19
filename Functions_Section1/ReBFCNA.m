function [ NewIm ] = ReBFCNA( Fc, nb, FullImR, FullImC, c )
% This function reconstructs an Image from compressed data 'Fc'
% by doing the reverse actions to the BFCNA function.

% removes the edges of the image to fit it to the nb if needed.

FullImR = FullImR - mod(FullImR,nb);
FullImC = FullImC - mod(FullImC,nb);

InitInfoPerBlock = FullImR*FullImC/nb^2;
NewInfoPerBlock = round(sqrt(InitInfoPerBlock/c))^2;
InitBlockSize = sqrt(InitInfoPerBlock);
NewBlockSize = sqrt(NewInfoPerBlock);

for ii = 1:nb
    for jj = 1:nb
        
        TempBlockFc = zeros(InitBlockSize);
        clear TempFc
        
        diff = InitBlockSize - NewBlockSize;
        
        if mod(NewBlockSize,2)
            Index = (NewInfoPerBlock+NewBlockSize)/2*nb*(ii-1)+(NewInfoPerBlock+NewBlockSize)/2*(jj-1)+1;
            NextIndex = Index + (NewInfoPerBlock+NewBlockSize)/2 - 1;
            TempFc = reshape(Fc(Index:NextIndex),(NewBlockSize+1)/2,NewBlockSize);
            
            TempFc((NewBlockSize+1)/2+1:NewBlockSize,1:(NewBlockSize-1)/2) = ...
                TempFc(1:(NewBlockSize-1)/2,(NewBlockSize+1)/2+1:NewBlockSize)';
            TempFc((NewBlockSize+1)/2+1:NewBlockSize,(NewBlockSize+1)/2) = ...
                flipud((TempFc(1:(NewBlockSize-1)/2,(NewBlockSize+1)/2)').');
            TempFc((NewBlockSize+1)/2+1:NewBlockSize,(NewBlockSize+1)/2+1:NewBlockSize) = ...
                rot90(TempFc(1:(NewBlockSize-1)/2,1:(NewBlockSize-1)/2)',2);        
        else
            Index = NewInfoPerBlock/2*nb*(ii-1)+NewInfoPerBlock/2*(jj-1)+1;
            NextIndex = Index + NewInfoPerBlock/2 - 1;
            TempFc = reshape(Fc(Index:NextIndex),NewBlockSize/2,NewBlockSize);
            
            TempFc(NewBlockSize/2+1:NewBlockSize-1,1:NewBlockSize/2-1) = ...
                TempFc(1:NewBlockSize/2-1,NewBlockSize/2+1:NewBlockSize-1)';
            TempFc(NewBlockSize/2+1:NewBlockSize-1,NewBlockSize/2) = ...
                flipud((TempFc(1:NewBlockSize/2-1,NewBlockSize/2)').');
            TempFc(NewBlockSize/2+1:NewBlockSize-1,NewBlockSize/2+1:NewBlockSize-1) = ...
                rot90(TempFc(1:NewBlockSize/2-1,1:NewBlockSize/2-1)',2);            
            TempFc(NewBlockSize,:) = 0 + 0*1i;
            
        end
        
        if mod(diff,2)
            TempBlockFc( (diff+1)/2+1:(diff+1)/2+NewBlockSize, (diff+1)/2+1:(diff+1)/2+NewBlockSize)...
                = TempFc;
        else
            TempBlockFc(diff/2+2:diff/2+NewBlockSize+1,diff/2+2:diff/2+NewBlockSize+1)...
                = TempFc;
        end
        
        NewIm((ii-1)*InitBlockSize+1:ii*InitBlockSize,(jj-1)*InitBlockSize+1:jj*InitBlockSize) = real(ifft2(ifftshift(TempBlockFc)));

    end
end

end

