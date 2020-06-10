%This code generates fundamental region of Wallpaper patterns. It can also
%be used as randot generator. ImageSize is where you need to define your
%size of the fundamental. If imageSize is 128 then it will generate 128x128
%matrix.
%minRad = minimun radius of the dot
%maxRad = maximum radius of the dot
%minCol = region that the dots should not overlap
%dotNum = # of dots
%FundNum =  # of fundamental region

function fundamental = FunGen(imageSize,minRad,maxRad,minCol,dotNum,FundNum,showFig)
%FundNum=1;
x = 1:imageSize;
y = 1:imageSize;
[xM,yM] = meshgrid(x,y);

zFig = struct;
zFig1 = struct;

DotCol = zeros(1,dotNum);
while true
    for iFund=1:FundNum
        zFig(iFund).Fund = zeros(imageSize,imageSize);
        zFig1(iFund).Fund = zeros(imageSize,imageSize);
        for iDot=1:dotNum
            flgAccpet = 0;
            while flgAccpet==0
                tempDotPosX = round(rand*imageSize);
                tempDotPosY = round(rand*imageSize);
                tempDotCol = rand*(1 - minCol) + minCol;
                DotCol(1,iDot) =  tempDotCol;
                tempDotRad = rand*(maxRad - minRad) + minRad;
                %DotRad(1,iDot)= tempDotRad;
                tempZDot = (((xM - tempDotPosX).^2 + (yM - tempDotPosY).^2)<=tempDotRad^2);
                tempOverlap = tempZDot&(zFig(iFund).Fund~=0);
                tempOverEdge = ((tempDotPosX-tempDotRad)<=0)|((tempDotPosX+tempDotRad)>imageSize)|((tempDotPosY-tempDotRad)<=0)|((tempDotPosY+tempDotRad)>imageSize);
                
                if (nnz(tempOverlap)==0)&&(nnz(tempOverEdge)==0)
                    flgAccpet = 1;
                end
            end
            %zFig= struct;
            zFig(iFund).Fund = zFig(iFund).Fund+ tempDotCol*tempZDot;
        end
        
        dots=(find(zFig(iFund).Fund));
        zFig(iFund).Fund(dots) = zFig(iFund).Fund(dots)./range(zFig(iFund).Fund(dots(:)));
        zFig(iFund).Fund(dots)=zFig(iFund).Fund(dots)-min(zFig(iFund).Fund(dots));
        zFig(iFund).Fund(dots)=zFig(iFund).Fund(dots)-mean(zFig(iFund).Fund(dots));
        zFig(iFund).Fund(dots)=zFig(iFund).Fund(dots)/max(zFig(iFund).Fund(dots));
        zFig(iFund).Fund(dots)=zFig(iFund).Fund(dots)*125+127;
        image(iFund).Fund = uint8(round(zFig(iFund).Fund));
        meanImage(iFund).Fund = mean(image(iFund).Fund(dots(:)));
        % meanImage(iFund)
        
        if showFig ==1
            figure(1000+iFund) %this plots one fundamental region
            imshow(image(iFund).Fund)
        else
        end
    end
    herhangi = true;
    for k= 1:FundNum
        herhangi=herhangi & (abs(meanImage(k).Fund-128) < 1);
        
    end
    if herhangi
        fprintf BINGO!
        for kk=1:FundNum
            meanImage(kk).Fund
        end
        break
    end

end
fundamental=image;
%return fundamental
meanImage(iFund)
end
