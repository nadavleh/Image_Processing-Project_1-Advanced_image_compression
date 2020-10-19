function [ ClearIm ] = CompressClear( Im, nb )
% This function's input is an image after compressing progress and its number
% of blocks. It returns the image after cleaning the lines at the blocks
% edges.

[SizeR, SizeC] = size(Im);

[r, c] = meshgrid(-1:1);
Var = (20)^2;
H = exp(((r.^2+c.^2))/(2*Var));
H = H/(sum(H(:)));

[r, c] = meshgrid(1:256);
GridImR1 = ~mod(r,SizeR/nb);
GridImR2 = ~(mod(r,SizeR/nb)-1);
GridImR2(:,1) = 0;

GridImC1 = ~mod(c,SizeC/nb);
GridImC2 = ~(mod(c,SizeC/nb)-1);
GridImC2(1,:) = 0;

GridIm = max(max(GridImR1,GridImR2),max(GridImC1,GridImC2));

TempIm = conv2(Im,H,'same');
ClearIm = TempIm.*GridIm + Im.*(abs(GridIm-1));  

end

