; -------------------------
; Creates transparent GUI windows for marker icons, using image files
; Author: ObiQuiet, quietjedi@gmail.com
; -------------------------

class class_Marker
{
	idGUI := ""
	pxX := 0
	pxY := 0
	pxOffsetX := 0
	pxOffsetY := 0
	fIsVisible := false

	__New(strImageFileName, strRGBTransparent, pxOffsetX := 0, pxOffsetY := 0)
    {
	Random, idGUITemp , 10000000, 99999999
	this.idGUI := idGUITemp   ; generate a unique id for this window
	
	Gui, win%idGUITemp%:New
	Gui, win%idGUITemp%:Margin , 0, 0
	Gui, win%idGUITemp%:Add, Picture,, %strImageFileName%
	Gui, win%idGUITemp%:Color, ffffff
	Gui, win%idGUITemp%:+LastFound -Caption +AlwaysOnTop +ToolWindow -Border
	Winset, TransColor, %strRGBTransparent%
	
	this.pxOffsetX := pxOffsetX
	this.pxOffsetY := pxOffsetY
	
	}
	
	__Delete()
		{
		idGUITemp := this.idGUI
		Gui, win%idGuiTemp%:Destroy
		}
	
	SetXY(pxNewX := "", pxNewY:= "")
	{
	if pxNewX is number
		{
		this.pxX := Round(pxNewX)
		}

	if pxNewY is number
		{
		this.pxY := Round(pxNewY)
		}
	}
	
	Show(pxNewX := "", pxNewY:= "")
	{
	this.SetXY(pxNewX, pxNewY)
		
	idGUITemp := "win" . this.idGUI
	Gui, % idGUITemp ":Show", % "X" this.pxX+this.pxOffsetX " Y" this.pxY+this.pxOffsetY " NoActivate"
	this.fIsVisible := true
	}
	
	Hide()
	{
	idGUITemp := this.idGUI
	Gui, win%idGuiTemp%:Hide
	this.fIsVisible := false
	}

	ShowHide(fShow)
		{
		if (fShow)
			this.Show()
		else
			this.Hide()
		}

	X()
	{
	return this.pxX
	}

	Y()
	{
	return this.pxY
	}


	IsVisible()
	{
	return this.fIsVisible
	}


}