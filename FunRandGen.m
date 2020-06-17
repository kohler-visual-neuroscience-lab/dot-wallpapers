function [fundRand, meanLumimage] = FunRandGen(imageSize,minRad,maxRad,minCol,dotNum,meanLum,FundNum)
x = 1:imageSize;
y = 1:imageSize;
[xM,yM] = meshgrid(x,y);

zFig = struct;
zFig1 = struct;

asl=0;
aslif=0;

if meanLum~=128;
        meanLum=meanLum;
    else
    meanLum = 128;
end

DotCol = zeros(1,dotNum);
while true
    for iFund=1:FundNum
        for im=1:dotNum
            %     fprintf('Generated image is starting %d\n',im);
            zFig=0;
            for iDot=1:dotNum
                flgAccpet = 0;
                while flgAccpet==0
                    asl=asl+1;
                    tempDotPosX = round(rand*imageSize);
                    tempDotPosY = round(rand*imageSize);
                    tempDotCol = rand*(1 - minCol) + minCol;
                    DotCol(1,iDot) =  tempDotCol;
                    tempDotRad = rand*(maxRad - minRad) + minRad;
                    %DotRad(1,iDot)= tempDotRad;
                    tempZDot = (((xM - tempDotPosX).^2 + (yM - tempDotPosY).^2)<=tempDotRad^2);
                    tempOverlap = tempZDot&(zFig~=0);
                    tempOverEdge = ((tempDotPosX-tempDotRad)<=0)|((tempDotPosX+tempDotRad)>imageSize)|((tempDotPosY-tempDotRad)<=0)|((tempDotPosY+tempDotRad)>imageSize);
                    if (nnz(tempOverlap)==0)&&(nnz(tempOverEdge)==0)
                        flgAccpet = 1;
                        aslif=aslif+1;
                    end
                end
                zFig = zFig + tempDotCol*tempZDot;
                %         figure;
                %         imagesc(zFig)
            end
            asl;
            aslif;
            asl=0;
            aslif=0;
            
            C{im,1}=zFig;
            A=cell2struct(C,'f',dotNum);
            %clear zFig
            
            %  fprintf('Generated image is completed %d\n',im);
            
            %dots = cell2struct(C,'f',dotNum)
            
            %dots(im).f = find(A(im).f(:)); %dots{im}=(find(C{im,:}));
            
            dots(im).f=(find(A(im).f(:)));     
            nonDots(im).f= find(A(im).f==0)
            
            
            %figure;
            % Combimage=cat(3,image(:).f);
        end
        A(iFund).f(dots(iFund).f) = A(iFund).f(dots(iFund).f)./range(A(iFund).f(dots(iFund).f)); %C(dots{im,:})
        A(iFund).f(dots(iFund).f)=A(iFund).f(dots(iFund).f)-min(A(iFund).f(dots(iFund).f));
        A(iFund).f(dots(iFund).f)=A(iFund).f(dots(iFund).f)-mean(A(iFund).f(dots(iFund).f));
        A(iFund).f(dots(iFund).f)=A(iFund).f(dots(iFund).f)/max(A(iFund).f(dots(iFund).f));
        A(iFund).f(dots(iFund).f)=A(iFund).f(dots(iFund).f)*125+127;
        A(iFund).f(nonDots(iFund).f)= A(iFund).f(nonDots(iFund).f);
        
        image(iFund).Fund = uint8(round(A(iFund).f));
        meanImage(iFund).Fund = mean(image(iFund).Fund(dots(iFund).f));
        
         image(iFund).Fund = uint8(round(A(iFund).f));
            meanImagedots(iFund).f = mean(image(iFund).Fund(dots(iFund).f));
            if meanLum==128;
                 A(iFund).f(nonDots(iFund).f)= meanLum;
                 image(iFund).Fund = uint8(round(A(iFund).f))
            else
            A(iFund).f(nonDots(iFund).f)= meanImagedots(iFund).f; %zFig(iFund).Fund(nonDots)
            image(iFund).Fund = uint8(round(A(iFund).f));
            end
            meanImage(iFund).Fund = mean(image(iFund).Fund(:));
        
        figure(1000+iFund) %this plots one fundamental region
        imshow(image(iFund).Fund)
        
    end
    herhangi = true;
    for k= 1:FundNum
        herhangi=herhangi & (abs(meanImage(k).Fund-128) < 10);
        
    end
    if herhangi
        fprintf BINGO!
        for kk=1:FundNum
            meanImage(kk).Fund
        end
        break
    end
end
fundRand=image;
%return fundamental
meanImage(iFund);
meanLumimage=meanImage;
end


