function[struct]=createMaster(GrillModel)
arguments
GrillModel {mustBeText}
end

GrillModel=string(GrillModel);

if strcmpi(GrillModel,"Journey")==1
fieldnames={'dataName';'number';'start';'stop';'startTemp';'grillState';'SetTempF';'TempF';'grateTemp';'displayTemp';'AugerRPM';'AugerPWM';'FanPWM';'GPstatus';'Errors';'P';'I';'D';'U';'fileName';'GPVoltage';'FuelLevel';...
    'FuelDistance';'FW';'grillName';'grillModel';'date';'duration';'errorCode';'setPoint';'timetotemp';'minstotemp';'overshoot';'SP_change';'tempSlope';'timetosteady';'minstosteady';...
    'SPchangetime';'cookdata';'startSS';'stopSS';'avgSSRPM';'avgSSPWM';'avgSSTemp';'avgSSgrateTemp';'avgSSGPVoltage'};

elseif strcmpi(GrillModel,"SmartValve")==1
    fieldnames={'Date'; 'CavityTemp'; 'CookMode'; 'TargetTemperature'; 'Burner1Status'; 'Burner2Status'; 'Burner3Status'; 'Burner4Status'; 'Burner5Status'; 'IRBurnerStatus'; 'Burner1Level'; 'Burner2Level'; 'Burner3Level';...
        'Burner4Level'; 'Burner5Level'; 'IRBurnerLevel'; 'TankScaleWeight'};
elseif strcmpi(GrillModel,"Model3")
    fieldnames={'placeholder'};
end

for k=1:length(fieldnames)
    struct.(fieldnames{k})=[];
end