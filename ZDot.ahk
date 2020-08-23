
#SingleInstance force

#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
#Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

#InstallKeybdHook
#InstallMouseHook
#UseHook On


#include classMarker.ahk
#include classPlayerPosition.ahk
#include fnRandBetween.ahk
#include fnTooltips.ahk

pxYAHDotX := 1675
pxYAHDotY := 170
objYAHDot := New class_Marker("yah.png", "ffffff")
objYAHDot.SetXY(pxYAHDotX, pxYAHDotY)

objPlayerPosition := New class_PlayerPosition()
objMovingDot := New class_Marker("yellowmarker.png", "1212f1", -20, 0)

StatusMsg("ZDot is WAITING for the Zwift game to start")
		
WinWait, ahk_exe ZwiftApp.exe,,180
if (ErrorLevel == 0) 
	WinMaximize

StatusMsg("ZDot Loaded")

fMenuOpen := true
fZwiftActive := false
fZwiftExists := true

fPrevZwiftActive := false
msExitDelay := 3 * 60 * 1000
msExitTime := A_TickCount+msExitDelay

SetTimer, UpdatePlayerPosition, 511
SetTimer, CheckForZwift, 1000


loop
{
	if ((A_TimeIdleMouse > 2*60*1000) and fZwiftActive)
		{
		Mousemove, A_ScreenWidth*0.90, A_ScreenHeight*0.90
		}

	if fZwiftExists
		msExitTime := A_TickCount + msExitDelay


	if fZwiftActive
		{				
		StatusMsg("ZDot OK")
		objYAHDot.ShowHide(objMovingDot.IsVisible())
		}	
		
	else if (fZwiftExists and not fZwiftActive)
		{
		StatusMsg("ZDot is WAITING for the Zwift game window to be active")
		objMovingDot.Hide()
		objYAHDot.Hide()
		}

	else if (not fZwiftExists)
		{
		secsInTens := Round((msExitTime-A_TickCount)/10000)*10
		StatusMsg("Zwift game is not running, ZDot will exit in " . secsInTens . " seconds")
		objMovingDot.Hide()
		objYAHDot.Hide()
		}
	
	if (A_TickCount > msExitTime)
		{
		ExitApp
		}
		
	sleep 2000
} 

UpdatePlayerPosition:

	objPlayerPosition.Update()
			
	if (not objPlayerPosition.Found()) or (not fZwiftActive)
		{
		objMovingDot.Hide()
		}
	else
		{
		pxCurrentX := objMovingDot.X()
		pxNewX := objPlayerPosition.X()
	;	pxNewX := 1401
	;	ToolTip XPos %pxNewX% %A_TickCount%,A_ScreenWidth*0.45,A_ScreenHeight*0.48, 5
 
		objMovingDot.Show(pxNewX, 296)		
	
		;if (pxNewX > pxCurrentX)
		;	   { pxNewX := pxCurrentX + (pxNewX - pxCurrentX)/2
		;	   }
		;else if (pxNewX < pxCurrentX)
		;	   { pxNewX := pxCurrentX - (pxCurrentX - pxNewX)/2
		;	   }
			
		}
	return

CheckForZwift:
	
	fZwiftExists := WinExist("ahk_exe ZwiftApp.exe")
	fZwiftActive := WinActive("ahk_exe ZwiftApp.exe")
	
	return


!3::
StatusMsg("ZDot EXITING")
Sleep 2000
Reload


