; -------------------------
; Convenience functions for searching the screen for pixels of specific colors
;
; Author: ObiQuiet, quietjedi@gmail.com
; -------------------------

ColorSearch(x, y, rgb)  ; returns true if the color is found within a small area, (x,y) are the upper left corner
	{
	PixelSearch, CPx, CPy, x, y, x+15, y+15, rgb, 0, Fast RGB
	return (ErrorLevel=0)
	}
	
DoubleColorSearch(x1, y1, width, rgb)
; Looks for the given color at two points, horizontally offset from each other
; This is more reliable than a single search when looking for e.g. a button/message/dialog against a variagated background
; and is faster than searching a rectangular area 
	{
	PixelGetColor, rgbAtXY, x1, y1, RGB
	fFound1 := (rgbAtXY=rgb)

	PixelGetColor, rgbAtXY, x1+width, y1, RGB
	fFound2 := (rgbAtXY=rgb)

	return (fFound1 and fFound2)
	}