function[cook,cookdata]=analysisV3(cookdata)





%% initialize
clear cook

[cookdata]=getTempSlope(cookdata);
if cookdata.grillModel=="Journey"
    [cook]=getStartAndStopV2(cookdata);
    [cook]=separateCooks(cook,cookdata);
    [cook]=getCookDetails(cook,cookdata);
elseif cookdata.grillModel=="GreenDay"
    [cook]=getStartAndStopV3(cookdata);
    [cook]=separateCooks(cook,cookdata);
    [cook]=getCookDetails_GD(cook,cookdata);
end

%%

[cook]=cleanDataV2(cook);
[cook]=getDuration(cook);
[cook]=getErrorCodes(cook);

%% temp change performance
[cook]=getSetTempV2(cook);
[cook]=getTimeToTempV3(cook,cookdata);
[cook]=getOvershoot(cook);
[cook]=getSetTempChangeV2(cook);
[cook]=getTimeToSteadyV2(cook);
[cook]=getTempChangeTimeV2(cook);
for k=1:length(cook)
    cook(k).cookdata=cookdata;
end
%% SS Performance
[cook]=getSteadyStateValues(cook);
%% reignition
[cook]=getReignition(cook);