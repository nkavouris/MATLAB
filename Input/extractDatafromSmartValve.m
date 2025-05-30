function [cookdata]=extractDatafromSmartValve(filename)


opts=detectImportOptions(filename);
%% Set up the Import Options and import the data

opts = delimitedTextImportOptions();

% Specify range and delimiter
opts.DataLines = [2, Inf];
opts.Delimiter = ",";

% Specify column names and types
opts.VariableNames = ["DateTime", "CavityTemp","EffectiveTemperature","DisplayTemperature", "CookMode", "TargetTemperature",'TargetTemperatureUI', "Burner1Status", "Burner2Status", "Burner3Status", "Burner4Status", "Burner5Status", "IRBurnerStatus", "Burner1Level", "Burner2Level", "Burner3Level", "Burner4Level", "Burner5Level", "IRBurnerLevel",...
    "Burner1Reignition", "Burner2Reignition", "Burner3Reignition", "Burner4Reignition", "Burner5Reignition", "IRReignition","TankScaleWeight","Errors"];
opts.VariableTypes = ["string", "double", "double", "double", "categorical", "double","double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double","double", "double", "double", "double", "double", "double","string"];

% Specify file level properties
opts.ExtraColumnsRule = "ignore";
opts.EmptyLineRule = "read";
opts.ConsecutiveDelimitersRule = "join";

% Specify variable properties
opts = setvaropts(opts, "DateTime", "WhitespaceRule", "preserve");
opts = setvaropts(opts, ["DateTime", "CookMode", "TargetTemperature", "Burner1Level", "Burner2Level", "Burner3Level", "Burner4Level", "Burner5Level", "IRBurnerLevel"], "EmptyFieldRule", "auto");
opts = setvaropts(opts, ["CavityTemp", "Burner1Status", "Burner2Status", "Burner3Status", "Burner4Status", "Burner5Status", "IRBurnerStatus", "TankScaleWeight"], "ThousandsSeparator", ",");

% Import the data
tbl = readtable(filename, opts);


%% Clear temporary variables
columns=tbl.Properties.VariableNames;

[~,dataName,~]=fileparts(filename);
cookdata.fileName=filename;
cookdata.dataName=string(dataName);
cookdata.DateTime = tbl.DateTime;
if ismember("GrillState", columns)
    cookdata.GrillState=tbl.GrillState;
end
cookdata.CookMode=tbl.CookMode;
cookdata.SetTempF = tbl.TargetTemperature;

cookdata.Burner1Status=tbl.Burner1Status;
cookdata.Burner1Level=tbl.Burner1Level;

cookdata.Burner2Status=tbl.Burner2Status;
cookdata.Burner2Level=tbl.Burner2Level;

cookdata.Burner3Status=tbl.Burner3Status;
cookdata.Burner3Level=tbl.Burner3Level;

cookdata.Burner4Status=tbl.Burner4Status;
cookdata.Burner4Level=tbl.Burner4Level;

cookdata.Burner5Status=tbl.Burner5Status;
cookdata.Burner5Level=tbl.Burner5Level;

cookdata.BurnerIRStatus=tbl.IRBurnerStatus;
cookdata.BurnerIRLevel=tbl.IRBurnerLevel;
cookdata.TankScaleWeight=tbl.TankScaleWeight;

if ismember("AugerSpeed",columns)==true
    cookdata.AugerRPM = tbl.AugerSpeed;
end

cookdata.TempF = tbl.CavityTemp;

if ismember("DisplayTemperature",columns)==true
    cookdata.displayTemp=tbl.DisplayTemperature;
end

if ismember("EffectiveTemperature",columns)==true
    cookdata.grateTemp=tbl.EffectiveTemperature;
end
if ismember("AugerPower",columns)==true
    cookdata.AugerPWM = tbl.AugerPower;
end


if ismember("Errors", columns)==true
cookdata.Errors = tbl.Errors;
end

cookdata.SetTempF = tbl.TargetTemperature;

if ismember("GlowPlugResistance",columns)==true
    cookdata.GPVoltage=tbl.GlowPlugResistance;
    cookdata.GPstatus = tbl.GlowPlugStatus;
end

if ismember("P",columns)==true
    cookdata.P=tbl.PTerm./1000000;
    cookdata.I=tbl.ITerm./1000000;
    cookdata.D=tbl.DTerm./1000000;
    cookdata.U=tbl.PIDOutput./1000000;
end

if ismember("EffectiveFuelLevel",columns)==true
    cookdata.FuelLevel=tbl.EffectiveFuelLevel;
    cookdata.FuelDistance=tbl.FuelSensorDistance;
end
cookdata.Errors=tbl.Errors;
%%
clear opts tbl



end