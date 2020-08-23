
#include fnColorSearch.ahk
#include classMovingAverage.ahk

class class_PlayerPosition
	{
	pxSearchWidth := 10
	pxSearchHeight := 10
	
	MaxSearchAreaX1 := 1460
	MaxSearchAreaY1 := 240

	MaxSearchAreaX2 := 1910
	MaxSearchAreaY2 := 310
	; 1460, 240, to 1460+449, 240+70
	
	countMisses := 5

	objSMA := ""

	pxX := 0
	pxY := 0

	pxPrevFoundAtX := 0
	pxPrevFoundAtY := 0

	countshort := 101 
	countlong := 0

	rgbColorToFind := 0xf5855e

	msTime := 0
	interval := 2000
	pxAvgX := 0

	__New()
		{
		this.objSMA := new class_SMA(5)
		}


Update()
	{
	msStart := A_TickCount
	
	pxUpperLeftX := this.pxPrevFoundAtX-this.pxSearchWidth
	pxUpperLeftY := this.pxPrevFoundAtY-this.pxSearchHeight
	
	pxLowerRightX := this.pxPrevFoundAtX+this.pxSearchWidth
	pxLowerRightY := this.pxPrevFoundAtY+this.pxSearchHeight
	
	rgbColorToFind := this.rgbColorToFind
	
	PixelSearch, pxFoundAtX, pxFoundAtY, %pxUpperLeftX%, %pxUpperLeftY%, %pxLowerRightX%, %pxLowerRightY%, %rgbColorToFind%, 2, Fast RGB
	fFound := (ErrorLevel == 0)
	this.countshort++

	if (not fFound)
		{
		this.countlong++
		PixelSearch, pxFoundAtX, pxFoundAtY, % this.MaxSearchAreaX1, % this.MaxSearchAreaY1, % this.MaxSearchAreaX2, % this.MaxSearchAreaY2, %rgbColorToFind%, 2, Fast RGB
		fFound := (ErrorLevel == 0)
		}
	
	if (not fFound)
		{
		this.countMisses++
		; ToolTip DotPos . %pxPrevFoundAtX% ,A_ScreenWidth*0.45,A_ScreenHeight*0.5, 3
		; ToolTip DotPos %pxAvgX% %A_TickCount%,A_ScreenWidth*0.45,A_ScreenHeight*0.52, 40

		}
	else	
		{
		this.countMisses := 0

		if (abs(pxFoundAtX-this.pxAvgX) > 10)
			{
			this.pxAvgX := pxFoundAtX
			this.objSMA.Clear()
			}
			
		this.objSMA.Add(pxFoundAtX)
			
		this.pxAvgX := this.objSMA.Mid()
		; this.pxAvgX := this.objSMA.Average()
		; this.pxAvgX := (this.pxAvgX * 0.90) + ((pxFoundAtX) * 0.1)
		; this.pxAvgX :=(pxFoundAtX)
		}
		
	this.msTime := this.msTime+A_TickCount-msStart	
	}

X()
	{
	return this.pxAvgX
	}

Found()
	{
	return (this.countMisses <= 5)
	}
	
}