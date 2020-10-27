
imageSize= 100
minRad= 3
maxRad= 8
minCol= 0.1
dotNum=25
FundNum=5
showFig= 1
TileNum=5
TileFund = 2
numRepRows= 5
numRepCol=5
meanLum= 128

[fundamental, meanLumimage] = FunGenShf(imageSize,minRad,maxRad,minCol,dotNum,meanLum,FundNum,showFig)
[PMM] = TileGen(fundamental,TileNum,TileFund,showFig)


[PatternPMM] = WallPatternGen(PMM,numRepRows,numRepCol,showFig)
[PatternP2] = WallPatternGen(P2,numRepRows,numRepCol,showFig)
[PatternP1] = WallPatternGen(P1,numRepRows,numRepCol,showFig)
[PatternP4] = WallPatternGen(P4,numRepRows,numRepCol,showFig)
