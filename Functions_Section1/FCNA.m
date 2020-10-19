function [ Fc ] = FCNA(Im, c)
%% Non-Adaptive Compression - Fourier
% This function's input is an image (Im) and compration ratio ( c = size(Im)/size(NewIm) ).
% The function activates Fourier transform on the full image, and keeps the
% required information to reconstruct the image. The size of the saved
% information is equal to size(Im)/c.

InitInfo = size(Im,1)*size(Im,2);
NewInfo = InitInfo/c;

TempFc = fftshift(fft2(Im));

diff = sqrt(InitInfo) - sqrt(NewInfo);
TempNew = TempFc( diff/2+2:diff/2+sqrt(NewInfo)+1,diff/2+2:diff/2+sqrt(NewInfo)+1 );
TempNew = TempNew(1:(sqrt(NewInfo)/2),:);

Fc(:,1) = TempNew(:); 
      
end

