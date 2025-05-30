
 function[cookdata]=extractDataFromCSVv5(filename,cookdata)

%  [file,path]=uigetfile({'*.csv';'*.txt'},"MultiSelect","on");
% filename=fullfile(path,file);


%% Set up the Import Options and import the data
opts = delimitedTextImportOptions();
opts.VariableNamesLine=1;
warning('off','MATLAB:table:ModifiedAndSavedVarnames')
opts.VariableNamingRule='modify';

% Specify range and delimiter
opts.DataLines = [2, Inf];
opts.Delimiter = ",";


%% Import the data
tbl = readtable(filename, opts);
variableNames=tbl.Properties.VariableNames;

trueVariableNames=["Date_Time", "FanPower","FanSpeed", "AugerSpeed", "CavityTemperature","EffectiveTemperature","DisplayTemperature","BoardTemperature","LuminTargetTemperature", "AugerPower", "GlowPlugStatus", "Errors", "TargetTemperature", "GlowPlugVoltage",...
    "GlowPlugResistance","FuelSensorStatus", "FuelSensorDistance", "FuelSensorAmbientRate", "FuelSensorSignal", "FuelSensorSPAD", "FuelSensorSigma","EffectiveFuelLevel", "GrillState", "GrillSubstate", "Conditions",...
    "PIDOutput", "PTerm", "ITerm", "DTerm","RequestedAugerPWM","Element1ShortingRelayStatus","ShortingRelayStatus","Element1HeatingElementPower","HeatingElementPower","ProbeOneTemperature","ProbeTwoTemperature"];

trueVariableTypes=["string", "double", "double","double","double","double","double", "double","double", "double", "logical", "string", "double", "double",...
    "double","categorical", "double", "double", "double", "categorical", "string","double", "string", "categorical", "double",...
    "double", "double", "double", "double","double","string","string","double","string","double","double"];

%% remove variables if not present


for k=length(variableNames):-1:1
    if strcmp(variableNames{k},'ProbeOne')==true||strcmp(variableNames{k},'ProbeTwo')==true
        variableNames{k}=[];
    end
end

x=find(ismember(variableNames,trueVariableNames)==true,1);

for k=length(trueVariableNames):-1:1
    if isempty(x)==true
        continue
    end
    if ismember(trueVariableNames(k),variableNames)==false
        trueVariableNames(k)=[];
        trueVariableTypes(k)=[];
    end
end
emptyFields=["Date_Time", "GlowPlugStatus", "FuelSensorStatus", "FuelSensorDistance", "FuelSensorAmbientRate", "FuelSensorSignal", "FuelSensorSPAD", "FuelSensorSigma", "GrillState", "GrillSubstate"];
thousandSeperator=["FanPower", "FanSpeed","AugerSpeed", "CavityTemperature","EffectiveTemperature", "AugerPower", "TargetTemperature","GlowPlugVoltage", "GlowPlugResistance", "Conditions", "PIDOutput", "PTerm", "ITerm", "DTerm"];

for k=length(emptyFields):-1:1
    if ismember(emptyFields(k),trueVariableNames)==false
        emptyFields(k)=[];
    end
end

for k=length(thousandSeperator):-1:1
    if ismember(thousandSeperator(k),trueVariableNames)==false
        thousandSeperator(k)=[];
    end
end

%% Specify file level properties

opts.ExtraColumnsRule = "ignore";
opts.EmptyLineRule = "read";
%opts.ConsecutiveDelimitersRule = "join";

opts.VariableNames=trueVariableNames;
opts.VariableTypes=trueVariableTypes;

opts = setvaropts(opts, "Date_Time", "WhitespaceRule", "preserve");
opts = setvaropts(opts, emptyFields, "EmptyFieldRule", "auto");
opts = setvaropts(opts, thousandSeperator, "ThousandsSeparator", ",");


tbl = readtable(filename, opts);

%% grill state name to number
if cookdata.grillModel=="GreenDay"||cookdata.grillModel=="Journey"
    k=randi(numel(tbl.GrillState)-50);

    if isnan(str2double(tbl.GrillState(k)))==true
        state=zeros(length(tbl.GrillState),1);
        for k=1:numel(tbl.GrillState)
            if tbl.GrillState(k)=="Home"
                state(k)=1;
                continue
            elseif tbl.GrillState(k)=="Diagnostic"
                state(k)=2;
                continue
            elseif tbl.GrillState(k)=="Preheat"
                state(k)=3;
                continue
            elseif tbl.GrillState(k)=="Cooking"
                state(k)=4;
                continue
            elseif tbl.GrillState(k)=="Shutdown"
                state(k)=5;
                continue
            else
                state(k)=nan;
            end

        end
    end
end
%% Convert to output type
columns=tbl.Properties.VariableNames;

[~,dataName,~]=fileparts(filename);
cookdata.fileName=filename;
cookdata.dataName=string(dataName);
cookdata.dateTime = tbl.Date_Time;
cookdata.grillState=state;
if cookdata.grillModel=="GreenDay"
    if ismember("FanPower",columns)==true
        cookdata.FanPWM = tbl.FanPower;
    end
    if ismember("FanSpeed",columns)==true
        cookdata.FanRPM=tbl.FanSpeed;
    end
    if ismember("AugerSpeed",columns)==true
        cookdata.AugerRPM = tbl.AugerSpeed;
    end
    if ismember("GlowPlugResistance",columns)==true
        cookdata.GPVoltage=tbl.GlowPlugResistance;
    elseif ismember("GlowPlugVoltage",columns)==true
        cookdata.GPVoltage=tbl.GlowPlugVoltage;
    end
    if ismember("AugerPower",columns)==true
        cookdata.AugerPWM = tbl.AugerPower;
    end
    cookdata.GPstatus = tbl.GlowPlugStatus;
    cookdata.SetTempF=tbl.TargetTemperature;
    if ismember("RequestedAugerPWM",columns)==true
        cookdata.requestedPWM=tbl.RequestedAugerPWM;
    end
end
cookdata.TempF = tbl.CavityTemperature;

if ismember("DisplayTemperature",columns)==true
    cookdata.displayTemp=tbl.DisplayTemperature;
end




if ismember("EffectiveTemperature",columns)==true
    cookdata.grateTemp=tbl.EffectiveTemperature;
end

cookdata.Errors = tbl.Errors;

if cookdata.grillModel=="Lumin"
    cookdata.SetTempF=tbl.LuminTargetTemperature;
end

if cookdata.grillModel=="GreenDay"
    cookdata.P=tbl.PTerm./1000000;
    cookdata.I=tbl.ITerm./1000000;
    cookdata.D=tbl.DTerm./1000000;
    cookdata.U=tbl.PIDOutput./1000000;
elseif cookdata.grillModel=="Lumin"
    cookdata.P=tbl.PTerm./1000;
    cookdata.I=tbl.ITerm./1000;
    cookdata.D=tbl.DTerm./1000;
    cookdata.U=tbl.PIDOutput./1000;
end

if ismember("EffectiveFuelLevel",columns)==true
    cookdata.FuelLevel=tbl.EffectiveFuelLevel;
    cookdata.FuelDistance=tbl.FuelSensorDistance;
end
%% heating element power
if cookdata.grillModel=="Lumin"
    if ismember("Element1HeatingElementPower",columns)==true
        cookdata.burnerLevel=tbl.Element1HeatingElementPower;
    elseif ismember("HeatingElementPower",columns)==true
        cookdata.burnerLevel=tbl.HeatingElementPower;
        for k=1:length(cookdata.burnerLevel)
            level=regexp(cookdata.burnerLevel(k),'(?<=Element1: )\d*','match');
            if isempty(level)==true
                cookdata.burnerLevel(k)=nan;
            else
                cookdata.burnerLevel(k)=str2double(level);
            end
        end
    end
    %% shorting relay
    if ismember("Element1ShortingRelayStatus",columns)==true
        cookdata.ShortingRelay=tbl.Element1ShortingRelayStatus;
        for k=1:length(cookdata.ShortingRelay)
            if contains(cookdata.ShortingRelay(k),"ON",IgnoreCase=true)==true
                cookdata.ShortingRelay(k)=1;
            else
                cookdata.ShortingRelay(k)=0;
            end
        end
        cookdata.ShortingRelay=str2double(cookdata.ShortingRelay);
    elseif ismember("ShortingRelayStatus",columns)==true
        cookdata.ShortingRelay=tbl.ShortingRelayStatus;

        for k=1:length(cookdata.ShortingRelay)
            if contains(cookdata.ShortingRelay(k),"ON",IgnoreCase=true)==true
                cookdata.ShortingRelay(k)=1;
            else
                cookdata.ShortingRelay(k)=0;
            end
        end
        cookdata.ShortingRelay=str2double(cookdata.ShortingRelay);
    end
end
%% clean temp F
cookdata.TempF=filloutliers(cookdata.TempF,"previous","movmean",5);
for k=1:length(cookdata.TempF)-1
    if cookdata.TempF(k)>1000
        cookdata.TempF(k)=nan;
    end
    if cookdata.TempF(k)<=20
        cookdata.TempF(k)=nan;
    end
end
while any(cookdata.TempF(:)==0)
    ii1=cookdata.TempF==0;
    ii2=circshift(ii1,[-1 0]);
    cookdata.TempF(ii1)=cookdata.TempF(ii2);
end
for k=1:length(cookdata.TempF)-1
    if abs(cookdata.TempF(k)-cookdata.TempF(k+1))>20
        cookdata.TempF(k+1)=cookdata.TempF(k);
    end
end
%% clean display temp
cookdata.displayTemp=filloutliers(cookdata.displayTemp,"previous","movmean",5);
for k=1:length(cookdata.displayTemp)-1
    if cookdata.displayTemp(k)>1000
        cookdata.displayTemp(k)=nan;
    end
    if cookdata.displayTemp(k)<=20
        cookdata.displayTemp(k)=nan;
    end
end
while any(cookdata.displayTemp(:)==0)
    ii1=cookdata.displayTemp==0;
    ii2=circshift(ii1,[-1 0]);
    cookdata.displayTemp(ii1)=cookdata.displayTemp(ii2);
end
for k=1:length(cookdata.displayTemp)-1
    if abs(cookdata.displayTemp(k)-cookdata.displayTemp(k+1))>20
        cookdata.displayTemp(k+1)=cookdata.displayTemp(k);
    end
end
%% clean grate temp
% cookdata.grateTemp=filloutliers(cookdata.grateTemp,"previous","movmean",5);
% for k=1:length(cookdata.grateTemp)-1
%     if cookdata.grateTemp(k)>1000
%         cookdata.grateTemp(k)=nan;
%     end
%     if cookdata.grateTemp(k)<=20
%         cookdata.grateTemp(k)=nan;
%     end
% end
% while any(cookdata.grateTemp(:)==0)
%     ii1=cookdata.grateTemp==0;
%     ii2=circshift(ii1,[-1 0]);
%     cookdata.grateTemp(ii1)=cookdata.grateTemp(ii2);
% end
% for k=1:length(cookdata.grateTemp)-1
%     if abs(cookdata.grateTemp(k)-cookdata.grateTemp(k+1))>20
%         cookdata.grateTemp(k+1)=cookdata.grateTemp(k);
%     end
% end
%% clean Set Temp
if isfield(cookdata,"setTempF")==true
    for k=1:length(cookdata.SetTempF)
        x=find(cookdata.SetTempF==0);
        for j=1:length(x)
            cookdata.SetTempF(x(j))=nan;
        end
        x=find(cookdata.SetTempF>650);
        for j=1:length(x)
            cookdata.SetTempF(x(j))=nan;
        end
    end
    while any(cookdata.SetTempF(:)==0)
        ii1=cookdata.SetTempF==0;
        ii2=circshift(ii1,[-1 0]);
        cookdata.SetTempF(ii1)=cookdata.SetTempF(ii2);
    end
end
%% clean fan PWM
if cookdata.grillModel=="GreenDay"
    x=find(cookdata.FanPWM==0);
    for j=1:length(x)
        cookdata.FanPWM(x(j))=nan;
    end

%% clean GP voltage

    x=find(cookdata.GPVoltage>=10);
    for j=1:length(x)
        cookdata.GPVoltage(x(j))=nan;
    end
end

%% clean PWM/RPM
% for j=3:length(cookdata.AugerPWM)
%     if cookdata.AugerPWM(j)>650||cookdata.AugerPWM(j)==0
%         cookdata.AugerPWM(j)=cookdata.AugerPWM(j-1);
%     elseif cookdata.AugerPWM(j-1)>650||cookdata.AugerPWM(j-1)==0
%         cookdata.AugerPWM(j)=cookdata.AugerPWM(j-2);
%     end
% end
% for j=3:length(cookdata.AugerRPM)
%     if cookdata.AugerRPM(j)>41000||cookdata.AugerRPM(j)==0
%         cookdata.AugerRPM(j)=cookdata.AugerRPM(j-1);
%     elseif cookdata.AugerRPM(j-1)>4100||cookdata.AugerRPM(j-1)==0
%         cookdata.AugerRPM(j)=cookdata.AugerRPM(j-2);
%     end

% end
%% clean grill state
% bad=~cookdata.grillState; %find all instances of grill state==0
% badIndicies=find(bad);
% goodIndicies=setdiff(1:numel(cookdata.grillState),badIndicies)';
% for k=1:length(badIndicies)
%     temp=abs(badIndicies(k)-goodIndicies);
%     closest=goodIndicies(temp==min(abs(badIndicies(k)-goodIndicies)),1);
%     cookdata.grillState(badIndicies(k))=cookdata.grillState(goodIndicies(closest(1)));
% end
%
if cookdata.grillModel=="GreenDay"||cookdata.grillModel=="Journey"
    if numel(unique(cookdata.grillState))<=3
        cookdata.grillState=interp1(1:nnz(cookdata.grillState), cookdata.grillState(cookdata.grillState ~= 0), cumsum(cookdata.grillState ~= 0), 'previous');
    end
end


cookdata.date=datetime(cookdata.dateTime(20),'InputFormat','eee MMM d HH:mm:ss yyyy');
cookdata.date.Format="dd-MMM-yyyy";
cookdata.date=string(cookdata.date);


%% Clear temporary variables
clear opts tbl