
imageSize=100
minRad= 3
maxRad= 8
minCol= 0.1
dotNum=25
FundNum=10
showFig=1
TileNum=10
TileFund = 2
numRepRows= 5
numRepCol=5

fundamental = FunGen(imageSize,minRad,maxRad,minCol,dotNum,FundNum,showFig)
[PMM P2 P1 P4] = TileGen(fundamental,TileNum,TileFund,showFig)


[PatternPMM] = WallPatternGen(PMM,numRepRows,numRepCol,showFig)
[PatternP2] = WallPatternGen(P2,numRepRows,numRepCol,showFig)
[PatternP1] = WallPatternGen(P1,numRepRows,numRepCol,showFig)
[PatternP4] = WallPatternGen(P4,numRepRows,numRepCol,showFig)
