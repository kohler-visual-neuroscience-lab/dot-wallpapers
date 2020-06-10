
function [Pattern] = WallPatternGen(Tileimage,numRepRows,numRepCol,showFig)

data = Tileimage;
for iTile=1:length(data)

%PMM
image15(iTile).Fund=repmat(data(iTile).Fund,numRepRows,numRepCol);
zFig=data;
dots=(find(zFig(iTile).Fund));
        zFig(iTile).Fund(dots) = zFig(iTile).Fund(dots)./range(zFig(iTile).Fund(dots(:)));
        zFig(iTile).Fund(dots)=zFig(iTile).Fund(dots)-min(zFig(iTile).Fund(dots));
        zFig(iTile).Fund(dots)=zFig(iTile).Fund(dots)-mean(zFig(iTile).Fund(dots));
        zFig(iTile).Fund(dots)=zFig(iTile).Fund(dots)/max(zFig(iTile).Fund(dots));
        zFig(iTile).Fund(dots)=zFig(iTile).Fund(dots)*125+127;
        image(iTile).Fund = uint8(round(zFig(iTile).Fund));
        meanImage(iTile).Fund = mean(image(iTile).Fund(dots(:)))
        meanImage(iTile)
        
       
Pattern(iTile).Fund=image15(iTile).Fund;
Pattern(iTile).meanimage = meanImage(iTile)

if showFig ==1
figure(6000+iTile) %this plots one fundamental region 
    imshow(Pattern(iTile).Fund)
else
end
end
% Pattern(iTile).Fund=image15(iTile).Fund;
% Pattern(iTile).meanimage = meanImage(iTile).Fund
end