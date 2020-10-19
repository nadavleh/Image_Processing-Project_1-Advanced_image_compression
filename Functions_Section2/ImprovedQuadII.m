function [ NewIm ] = ImprovedQuadII( Im, NewIm, Level, TH )
% This MATLAB function compresses images by using the Quad Tree, in order
% to recognize homogeneous parts in the picture.

n               = size(Im,1);               % Image's size

if n > 1
    for ii = 1:n-1                              % Horizontal    
        Temp1 = Im(1:ii,:);
        Temp2 = Im(ii+1:n,:);

        StdMatA(1,ii) = std(Temp1(:));
        StdMatA(2,ii) = std(Temp2(:));
    end

    for ii = 1:n-1                              % Vertical
        Temp1 = Im(:,1:ii);
        Temp2 = Im(:,ii+1:n);

        StdMatB(1,ii) = std(Temp1(:));
        StdMatB(2,ii) = std(Temp2(:));
    end
    
    DiagAU = triu(Im);
    DiagAL = tril(Im,-1);
    StdDiagAU = 0.4*std(DiagAU(:))*(n^2-1)/(0.5*(n^2+n)-1);
    StdDiagAL = 0.4*std(DiagAL(:))*(n^2-1)/(0.5*(n^2-n)-1);
        
    DiagBU = triu(fliplr(Im));
    DiagBL = tril(fliplr(Im),-1);
    StdDiagBU = 0.4*std(DiagBU(:))*(n^2-1)/(0.5*(n^2+n)-1);
    StdDiagBL = 0.4*std(DiagBL(:))*(n^2-1)/(0.5*(n^2-n)-1);    
    
    StdDiagA = StdDiagAU + StdDiagAL;
    StdDiagB = StdDiagBU + StdDiagBL;    
    [MinRecA, IndA] = min(sum(StdMatA,1));
    [MinRecB, IndB] = min(sum(StdMatB,1));
    
    [~, Ind] = min([MinRecA MinRecB StdDiagA StdDiagB]);
    
    switch Ind
        case 1
            if ((StdMatA(1,IndA) < TH) && (StdMatA(2,IndA) < TH))
                NewIm = [1, IndA, mean(mean(Im(1:IndA,:))),mean(mean(Im(IndA+1:end,:))) ];
                return
            end
        case 2
            if ((StdMatB(1,IndB) < TH) && (StdMatB(2,IndB) < TH))
                NewIm = [2, IndB, mean(mean(Im(:,1:IndB))) ,mean(mean(Im(:,IndB+1:end)))];
                return
            end 
        case 3
            if ((StdDiagAU < TH) && (StdDiagAL < TH))
                NewIm = [3, sum(DiagAU(:))/(0.5*(n^2+n)) ,sum(DiagAL(:))/(0.5*(n^2-n))];
                return
            end
        case 4
            if ((StdDiagBU < TH) && (StdDiagBL < TH))
                NewIm = [4, sum(DiagBU(:))/(0.5*(n^2+n)) ,sum(DiagBL(:))/(0.5*(n^2-n))];
                return
            end            
    end 
end

STD             = std(Im(:));               % STD of the specific Image

if STD < TH
    NewIm = mean(Im(:));
    return
end

if Level == 5                               % Higher resolution for lower levels
    TH = TH/2;
end

NewIm{1} = 0;

for ii = 1:4

    if log2(n) == 0
        NewIm = mean(Im(:));
        return
    end
    
    NewIm{ii+1} = [];
        
    switch ii  
        case 1
            NewIm{ii+1} = ImprovedQuadII( Im(1:n/2,1:n/2), NewIm{ii+1}, Level+1, TH);
        case 2
            NewIm{ii+1} = ImprovedQuadII( Im(1:n/2,n/2+1:end), NewIm{ii+1}, Level+1, TH);
        case 3
            NewIm{ii+1} = ImprovedQuadII( Im(n/2+1:end,1:n/2), NewIm{ii+1}, Level+1, TH);
        case 4
            NewIm{ii+1} = ImprovedQuadII( Im(n/2+1:end,n/2+1:end), NewIm{ii+1}, Level+1, TH);
    end
end

end

