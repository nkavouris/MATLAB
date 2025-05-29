function[struct]=createMasterData(GrillModel)
arguments
GrillModel {mustBeText}
end

GrillModel=string(GrillModel);

if strcmpi(GrillModel,"Journey")==1
fieldnames={'dataName';'grillState';'setTempF';'TempF';'grateTemp';'displayTemp';'AugerRPM';'AugerPWM';'FanPWM';'GPstatus';'Errors';'P';'I';'D';'U';'fileName';'GPVoltage';'fuelLevel';...
    'fuelDistance';'FW';'grillName';'grillModel';'buildVersion';'date';'dateTime'};
elseif strcmpi(GrillModel,"SmartValve")==1
    fieldnames={'fileName';'dataName';'Date';'FW';'grillName';'build'; 'TempF'; 'CookMode'; 'TargetTemperature'; 'Burner1Status'; 'Burner2Status'; 'Burner3Status'; 'Burner4Status'; 'Burner5Status'; 'IRBurnerStatus'; 'Burner1Level'; 'Burner2Level'; 'Burner3Level';...
        'Burner4Level'; 'Burner5Level'; 'IRBurnerLevel'; 'TankScaleWeight'};
elseif strcmpi(GrillModel,"Model3")
    fieldnames={'placeholder'};
end

for k=1:length(fieldnames)
    struct.(fieldnames{k})=[];
end