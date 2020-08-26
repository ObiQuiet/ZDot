; -------------------------
; ZDot - places two high-visibility "you are here" markers over the Zwift in-game map
; v0.8 ALPHA test
; Revision: 2020-08-23
; Author: ObiQuiet, quietjedi@gmail.com
; -------------------------
; Depends on AutoHotkey, from autohotkey.com

; -------------------------
; Limitations
; * Hard-coded to a maximized, not fullscreen, Zwift game window
;     - Hard-coded to 1920x1080 screens	
;     - ZDot will maximize the game window for you if it appears after ZDot starts
; * Hard-coded to the current version of the Zwift game interface  (version 1.0.53547)
;     - Zwift may well change elements of their game UI which ZDot is sensitive to, making this code obsolete
; * Accuracy and stability of the moving dot could be improved still
; * The dot in the center of the map is aligned for the zoomed-out map only, not the zoomed-in or perspective map
;     - in game, click on the map to cycle between its modes   
; 
; Bonus Feature
; * ZDot will move the mouse cursor off the screen if it's been left idle for while     - in game, click on the map to cycle between its modes   

#SingleInstance force

#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
#Warn   ; Enable warnings to assist with detecting common errors.

SetWorkingDir %A_ScriptDir%  ; This is where the image files and includes will be found

#InstallKeybdHook
#InstallMouseHook
#UseHook On

#include classMarker.ahk
#include classPlayerPosition.ahk
#include fnTooltips.ahk

; --------------------------------------------------------------------------------------------------
; Verify screen resolution.   
; This alpha version of ZDot is hard-coded to 1920x1080 and a maximized (not fullscreen) game window
; --------------------------------------------------------------------------------------------------

fResCheckPassed := false
while (not fResCheckPassed)
	{
	if (A_ScreenHeight != 1080) or (A_ScreenWidth != 1920)
		{
		MsgBox, 8214, ZDot Alpha Test, This pre-release version of ZDot needs a maximized (not full screen) game window and a screen resolution of 1920x1080.  The current resolution is %A_ScreenWidth%x%A_ScreenHeight%.
		IfMsgBox Cancel
			ExitApp
		IfMsgBox Continue
			fResCheckPassed := true
		}
	else
		{
		fResCheckPassed := true
		}
	}

; --------------------------------------------------------------------------------------------------
; Create the two overlays 
; --------------------------------------------------------------------------------------------------

; The "You Are Here" dot in the center of the map
pxYAHDotX := 1675
pxYAHDotY := 170
objYAHDot := New class_Marker("yah.png", "ffffff")
objYAHDot.SetXY(pxYAHDotX, pxYAHDotY)

; This class can detect the horizontal position of the little icon along profile view at the bottom of the map
objPlayerPosition := New class_PlayerPosition()

; The marker along the bottom of the map
objMovingDot := New class_Marker("yellowmarker.png", "1212f1", -20, 0)

; --------------------------------------------------------------------------------------------------
; Wait for the game to start
; --------------------------------------------------------------------------------------------------

StatusMsg("ZDot is WAITING for the Zwift game to start", 1470, 0)

WinWait, ahk_exe ZwiftApp.exe,,180
if (ErrorLevel == 0) 
	WinMaximize   ; in case the user hadn't doe it

; --------------------------------------------------------------------------------------------------
; Initialization for the main loop
; --------------------------------------------------------------------------------------------------

StatusMsg("ZDot Loaded")

fZwiftActive := false
fZwiftExists := false
GoSub CheckForZwift

; Prep to automatically close ZDot after the game is closed
msExitDelay := 3 * 60 * 1000
msExitTime := A_TickCount+msExitDelay

SetTimer, UpdatePlayerPosition, 511
SetTimer, CheckForZwift, 1000

; --------------------------------------------------------------------------------------------------
; Main loop
; --------------------------------------------------------------------------------------------------

loop
{
	if ((A_TimeIdleMouse > 2*60*1000) and fZwiftActive)   ; move the mouse so it's not annoying
		{
		Mousemove, A_ScreenWidth, A_ScreenHeight
		}

	if fZwiftExists   ; reset the ZDot exit delay
		msExitTime := A_TickCount + msExitDelay   


	if fZwiftActive   ; show or hide the YAH dot based on whether the moving dot is present
		{				
		StatusMsg("ZDot OK " . A_ScreenWidth . "x" . A_ScreenHeight)
		objYAHDot.ShowHide(objMovingDot.IsVisible())   
		}	
		
	else if (fZwiftExists and not fZwiftActive)   ; go into a waiting mode
		{
		StatusMsg("ZDot is WAITING for the Zwift game window to be active")
		objMovingDot.Hide()
		objYAHDot.Hide()
		}

	else if (not fZwiftExists)   ;  update status to show exit delay
		{
		secsInTens := Round((msExitTime-A_TickCount)/10000)*10
		StatusMsg("Zwift game is not running, ZDot will exit in " . secsInTens . " seconds")
		objMovingDot.Hide()
		objYAHDot.Hide()
		}
	
	if (A_TickCount > msExitTime)   ; exit delay has expired
		{
		ExitApp
		}
		
	sleep 2000
} 

UpdatePlayerPosition:

	objPlayerPosition.Find()
			
	if (not objPlayerPosition.Found()) or (not fZwiftActive)
		{
		objMovingDot.Hide()
		}
	else
		{
		; put the marker at the same horizontal position as the game's player icon, but at its own vertical position
		objMovingDot.Show(objPlayerPosition.X(), 296)		
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


