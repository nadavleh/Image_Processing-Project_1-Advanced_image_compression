function [ NewIm ] = ReFCNA( Fc, FullImR, FullImC, c )
% This function reconstructs an Image from compressed data 'Fc'
% by doing the reverse actions to the FCNA function.

InitInfo = FullImR*FullImC;
NewInfo = InitInfo/c;
InitSize = sqrt(InitInfo);
NewSize = sqrt(NewInfo);
      
TempImFc = zeros(InitSize);

diff = InitSize - NewSize;

TempFc = reshape(Fc,NewSize/2,NewSize);
       
TempFc(NewSize/2+1:NewSize-1,1:NewSize/2-1) = TempFc(1:NewSize/2-1,NewSize/2+1:NewSize-1)';
TempFc(NewSize/2+1:NewSize-1,NewSize/2) = flipud((TempFc(1:NewSize/2-1,NewSize/2)').');
TempFc(NewSize/2+1:NewSize-1,NewSize/2+1:NewSize-1) = rot90(TempFc(1:NewSize/2-1,1:NewSize/2-1)',2);
TempFc(NewSize,:) = 0 + 0*1i;

TempImFc(diff/2+2:diff/2+NewSize+1,diff/2+2:diff/2+NewSize+1) = TempFc;
NewIm = real(ifft2(ifftshift(TempImFc)));

end

