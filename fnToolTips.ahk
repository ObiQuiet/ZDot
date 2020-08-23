
CoordMode, Tooltip, Screen

CenterToolTip(strText, msDuration)
	{
	ToolTip, %strText%,A_ScreenWidth/2,A_ScreenHeight/3, 2
	; Mousemove, 100, 100
	sleep %msDuration%		
	ToolTip ,, 2
	}

CountdownToolTip(strText, msDuration)
	{

	timeOut := A_TickCount+msDuration
	while A_TickCount < timeOut
		{
		secsLeft := ceil((timeOut - A_TickCount) / 1000)
		ToolTip, %strText% %secsLeft%,A_ScreenWidth/2,A_ScreenHeight/3, 2
		sleep 10000
		}
	ToolTip ,, 1
	}
	
StaticToolTip(strText, pctX, pctY)
	{
	ToolTip, %strText%,A_ScreenWidth*pctX,A_ScreenHeight*pctY, 1
	}
	
StatusMsg(strMsg)
	{
	static strLastMsg := ""
	if (strMsg != strLastMsg)
		{
		ToolTip, %strMsg%, 1470, 0 , 2
		strLastMsg := strMsg
		}
	}