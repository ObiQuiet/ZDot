ColorSearch(x, y, rgb)
	{
	PixelSearch, CPx, CPy, x, y, x+15, y+15, rgb, 0, Fast RGB
	return (ErrorLevel=0)
	}
	
DoubleColorSearch(x1, y1, width, rgb)
	{
	PixelGetColor, rgbAtXY, x1, y1, RGB
	fFound1 := (rgbAtXY=rgb)

	PixelGetColor, rgbAtXY, x1+width, y1, RGB
	fFound2 := (rgbAtXY=rgb)

	return (fFound1 and fFound2)
	}