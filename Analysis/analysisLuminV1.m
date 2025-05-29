function [cookdata]=LuminAnalysisV=1ta)

% [cookdata]=getTempSlope(cookdata);
% [cook]=getStartAndStopV2(cookdata);
% [cook]=separateCooks(cook,cookdata);
[cookdata]=getSteadyStateValues_Lumin(cookdata);
[cookdata]=getCookDetails_Lumin(cookdata);
% [cook]=cleanDataV2(cook);
% [cook]=getDuration(cook);