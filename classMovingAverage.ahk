class class_SMA
{
	arySamples := []
	countSamples := 0
	maxSamples := 0
	idxCurrent := 0

	__New(maxSamples)
		{
		this.maxSamples := maxSamples
		}
	
	Add(numSample)
		{
		if (numSample == "")
			return
		
		if (this.CountSamples < this.maxSamples)
			{
			tempIdx	  := this.idxCurrent
		;	ToolTip add %numSample% @ %tempIdx% ,A_ScreenWidth*0.45,A_ScreenHeight*0.48, 6

			this.arySamples[this.idxCurrent] := numSample
			this.countSamples++
			this.idxCurrent := mod(this.idxCurrent+1, this.maxSamples)
			}
		else
			{
			tempIdx	  := this.idxCurrent
		;	ToolTip add %numSample% @ %tempIdx% ,A_ScreenWidth*0.45,A_ScreenHeight*0.48, 6
			this.arySamples[this.idxCurrent] := numSample
			this.idxCurrent := mod(this.idxCurrent+1, this.maxSamples)
			}
		
		tempCount := this.countSamples
		tempIdx	  := this.idxCurrent
		; ToolTip buf %tempCount% %tempIdx% ,A_ScreenWidth*0.45,A_ScreenHeight*0.54, 5

			
		}
		
	Min()
		{
		if (this.countSamples == 0)
			return 0
			
		numMin := this.arySamples[0]
		
		For idx, numValue in this.arySamples	
			{
			numMin := min(numMin, numValue)
			}
	
		ToolTip min %numMin% ,A_ScreenWidth*0.45,A_ScreenHeight*0.52, 4
		

	return numMin
		}
	
	Max()
		{
		if (this.countSamples == 0)
			return 0
			
		numMax := this.arySamples[0]
		
		For idx, numValue in this.arySamples	
			{
			numMax := max(numMax, numValue)
			}
			
		ToolTip max %numMax% ,A_ScreenWidth*0.45,A_ScreenHeight*0.5, 3
	
		return numMax
		}

	Mid()
		{
		if (this.countSamples == 0)
			return 0
			
		numMin := this.arySamples[0]
		numMax := this.arySamples[0]
		
		For idx, numValue in this.arySamples	
			{
			numMin := min(numMin, numValue)
			numMax := max(numMax, numValue)
			}

		return (numMin+numMax) / 2
		}

	Average()
		{
		if (this.countSamples == 0)
			return 0
			
		numTotal := 0
		
		For idx, numValue in this.arySamples	
			{
			numTotal := numTotal+numValue
			}
		
		return numTotal/this.CountSamples
		}


		
	Clear()
		{
		this.arySamples := []
		this.countSamples := 0
		this.idxCurrent := 0
		}
}