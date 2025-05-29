function[cookdata]=getTempSlope(cookdata)
x=diff(cookdata.TempF);
cookdata.tempSlope=conv(x,ones(500,1),"same");