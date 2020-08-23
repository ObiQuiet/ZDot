

#include fnColorSearch.ahk
	

MenuSearch()
; works
	{
	; orange route choice
	PixelSearch, Px, Py, A_ScreenWidth*0.45, A_ScreenHeight*0.80, A_ScreenWidth*.55, A_ScreenHeight*0.90, 0xf36c3d, 0, Fast RGB
	if (ErrorLevel==0) 
		{ 
		return true
		}

	; orange middle bottom
	PixelSearch, Px, Py, A_ScreenWidth*0.45, A_ScreenHeight*0.90, A_ScreenWidth*.55, A_ScreenHeight*0.95, 0xf36c3d, 0, Fast RGB
	if (ErrorLevel==0) 
		{ 
		return true
		}
	; grey centered cancel
	PixelSearch, Px, Py, A_ScreenWidth*0.45, A_ScreenHeight*0.90, A_ScreenWidth*.55, A_ScreenHeight*0.95, 0xe5e5e5, 0, Fast RGB
	if (ErrorLevel==0) 
		{ 
		return true
		}

	; dark centered cancel
	PixelSearch, Px, Py, A_ScreenWidth*0.45, A_ScreenHeight*0.90, A_ScreenWidth*.55, A_ScreenHeight*0.95, 0x4f4f4f, 0, Fast RGB
	if (ErrorLevel==0) 
		{ 
		return true
		}


	; orange end ride, middle of screen
	PixelSearch, Px, Py, A_ScreenWidth*0.45, A_ScreenHeight*0.45, A_ScreenWidth*.55, A_ScreenHeight*0.55, 0xf36c3d, 0, Fast RGB
	if (ErrorLevel==0) 
		{ 
		return true
		}
		
	;  group message window
	PixelSearch, Px, Py, A_ScreenWidth*0.45, A_ScreenHeight*0.80, A_ScreenWidth*.55, A_ScreenHeight*0.90, 0xececec, 0, Fast RGB
	if (ErrorLevel==0) 
		{ 
		return true
		}
	
	; blue launcher window background, but not the camera menu
	PixelSearch, Px, Py, A_ScreenWidth*0.45, A_ScreenHeight*0.80, A_ScreenWidth*.45, A_ScreenHeight*0.85, 0x1192cc, 0, Fast RGB
	if (ErrorLevel==0) 
		{ 
		return true
		}

	}
	
	
MenuSearch3()
	
	{
	
	rgbOrange := 0xf36c3d
	rgbBlue  := 0x1192cc 
	rgbBlack := 0xececec
	rgbWhite := 0xffffff
	
	; orange route choice
	If ColorSearch(A_ScreenWidth*0.45, A_ScreenHeight*0.80, rgbOrange) 
		return true

	If DoubleColorSearch(640,  1040,  100, rgbWhite)  ; Message and Promo
		return true

	If DoubleColorSearch(880,  1040,  140, rgbOrange)  ; Settings
	or DoubleColorSearch(850,  1032,  200, rgbOrange)  ; Garage
	or DoubleColorSearch(870,   912,  200, rgbOrange)  ; Searching while Pairing
	or DoubleColorSearch(1050,  650,  200, rgbOrange)  ; Are you Sure, no paired devices
	or DoubleColorSearch(840,   980,  240, rgbOrange)  ; Badges
	or DoubleColorSearch(1100, 1022,  300, rgbOrange)  ; End Ride Pause
	or DoubleColorSearch(845,   609,  240, rgbOrange)  ; End Ride Confirmation
	or DoubleColorSearch(650,   130,  600, rgbBlack)  ; Paired Devices
  ; or DoubleColorSearch(500,    70, 1000, rgbBlack)  ; Training and Workout reviews
	or DoubleColorSearch(500,   500, 1000, rgbBlue)   ; Loading screen
	or DoubleColorSearch(750,   850,   50, rgbWhite)  ; Log in
	or DoubleColorSearch(1200,  970,   50, rgbOrange)   ; Select Route
	or DoubleColorSearch(600,   910,   20, rgbWhite)  ; Next Up
	or DoubleColorSearch(900,   990,   25, rgbBlue)  ; Blue pop up view and gesture menu
		{ 
		return true
		}
	return false
	}
	



CheckForMenus:
	{
	fMenuFound := MenuSearch3()
	fLastZwiftActive := fZwiftActive
	
	fZwiftActive := WinActive("ahk_exe ZwiftApp.exe")
	
	if WinExist("ahk_exe ZwiftApp.exe")
		{
		msExitTime := A_TickCount + msExitDelay
		}
	
	fMenuOpen := fMenuFound or (not fZwiftActive)
	
	if (not WinExist("ahk_exe ZwiftApp.exe"))
		{
		secs := Round((msExitTime-A_TickCount)/1000)
		StatusMsg("Zwift is not running, ZCameraDriver will exit in " . secs . " seconds")
		}
	
	else if (not WinActive("ahk_exe ZwiftApp.exe"))
		{
		StatusMsg("ZCameraDriver WAITING for Zwift Window")
		}	
	else if (fMenuFound)
		{
		StatusMsg("ZCameraDriver AUTO-PAUSED")
		}
	
	else
		{
		StatusMsg("ZCameraDriver Running")
		}


if (fZwiftActive and not fLastZwiftActive)  	
	{
	CreateDots()
	

	;Gui, Dot:Show, X1675 Y170 NoActivate
	;Gui, Dot2:Show, X1451 Y240 NoActivate
	
	}
else if (not fZwiftActive and fLastZwiftActive) 
	{
	Gui, Dot:Hide
	Gui, Dot2:Hide
	}
	
if (A_TickCount > msExitTime)
	{
	ExitApp
	}

	}
