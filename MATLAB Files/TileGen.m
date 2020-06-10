
%Fundimage should be the fundamental region 
%TileNum how many different tiles you want to generate *this cannot be more than FundNum in FunGen.m. 
%TileFund this is actually only used by P4 if this = 1 it will tile the
%same fundamental region across the plane else it will pick 4 different one.
%If you want to generate figure set showFig = 1

function [PMM] = TileGen(Fundimage,TileNum,TileFund,showFig)%,WallpaperType

% if WallpaperType == WallpaperType

%generate Tile for PMM
data = Fundimage;
for iTile=1:TileNum
    
    image2(iTile).Fund = flipud(data(iTile).Fund);
    image3(iTile).Fund = fliplr(image2(iTile).Fund);
    image6(iTile).Fund = [image2(iTile).Fund,image3(iTile).Fund];
    image7(iTile).Fund = flipud(image6(iTile).Fund);%
    
    imagePMM(iTile).Fund=[image6(iTile).Fund;image7(iTile).Fund];
    
    
    %generate Tile for P2
    imageSize=100; % by default
    image0(iTile).Fund = zeros(imageSize,imageSize);
    image1(iTile).Fund = imrotate(data(iTile).Fund,90);
    
    imageA(iTile).Fund = flipud(image1(iTile).Fund);
    imageB(iTile).Fund = fliplr(imageA(iTile).Fund);
    imageC(iTile).Fund = flipud(imageB(iTile).Fund);
    
    image4(iTile).Fund = flipud(image3(iTile).Fund);
    image9(iTile).Fund=[image0(iTile).Fund,image2(iTile).Fund;image4(iTile).Fund,image0(iTile).Fund];
    image14(iTile).Fund=[image0(iTile).Fund,imageA(iTile).Fund;imageC(iTile).Fund,image0(iTile).Fund];
    imageP2Half(iTile).Fund=fliplr(image14(iTile).Fund);
    imageP2(iTile).Fund=[image9(iTile).Fund+imageP2Half(iTile).Fund];
    
    
    
    %generate Tile for P1
    numRepRows=2;
    numRepCol=2;
    if TileFund == 1
        imageX(iTile).Fund = data(iTile).Fund;
        imageP1(iTile).Fund=repmat(imageX(iTile).Fund,numRepRows,numRepCol)
    else
        if iTile<8
            imageP1(iTile).Fund=[data(iTile).Fund,data(iTile+1).Fund;data(iTile+2).Fund,data(iTile+3).Fund]
        else
            imageP1(iTile).Fund=[data(iTile).Fund,data(iTile-1).Fund;data(iTile-2).Fund,data(iTile-3).Fund]
        end
    end
    
    imageP4(iTile).Fund = [imrotate(data(iTile).Fund,-90),imrotate(data(iTile).Fund,180);data(iTile).Fund,imrotate(data(iTile).Fund,90)]
    
    if showFig == 1
        figure(2000+iTile) %this plots one fundamental region
        imshow(imagePMM(iTile).Fund)
        
        figure(3000+iTile) %this plots one fundamental region
        imshow(imageP2(iTile).Fund)
        
        figure(4000+iTile) %this plots one fundamental region
        imshow(imageP1(iTile).Fund)
        
         figure(5000+iTile) %this plots one fundamental region
        imshow(imageP4(iTile).Fund)
    else
    end
    
end

% elseif WallpaperType ~= WallpaperType
% end
PMM = imagePMM
P2  = imageP2
P1  = imageP1
P4  = imageP4
end