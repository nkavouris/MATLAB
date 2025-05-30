function[cookdata]=extractDataFromSnorkel(filename,cookdata)
% 
% [file,path]=uigetfile("MultiSelect","on");
% filename=fullfile(path,file);
cookdata.grillModel="Snorkel";

%% Set up the Import Options and import the data
opts = detectImportOptions(filename);


% Specify sheet and range
opts.VariableNamingRule="modify";
opts.Sheet = 1;
opts.DataRange = [2, Inf];

 opts.VariableNamesRange=1;
% Import the data
tbl = readtable(filename, opts, "UseExcel", false);

%%
%opts = setvaropts(opts, "Date_Time", "WhitespaceRule", "preserve");
opts = setvaropts(opts, ["Date_Time", "AugerSpeed", "AugerPower", "GlowPlugStatus", "Errors", "TargetTemperature", "GlowPlugResistance", "GrillState", "GrillSubstate", "ShortingRelayStatus", "HeatingElementPower", "ProbeOneTemperature", "ProbeTwoTemperature"], "EmptyFieldRule", "auto");


variableNames=tbl.Properties.VariableNames;

trueVariableNames=["Date_Time", "FanPower","FanSpeed", "AugerSpeed", "CavityTemperature","EffectiveTemperature","DisplayTemperature","BoardTemperature","LuminTargetTemperature", "AugerPower", "GlowPlugStatus", "Errors", "TargetTemperature", "GlowPlugVoltage",...
    "GlowPlugResistance","FuelSensorStatus", "FuelSensorDistance", "FuelSensorAmbientRate", "FuelSensorSignal", "FuelSensorSPAD", "FuelSensorSigma","EffectiveFuelLevel", "GrillState", "GrillSubstate", "Conditions",...
    "PIDOutput", "PTerm", "ITerm", "DTerm","Element1ShortingRelayStatus","ShortingRelayStatus","Element1HeatingElementPower","HeatingElementPower","ProbeOneTemperature","ProbeTwoTemperature"];

trueVariableTypes=["string", "double", "double","double","double","double","double", "double","double", "double", "logical", "string", "double", "double",...
    "double","categorical", "double", "double", "double", "categorical", "string","double", "string", "categorical", "double",...
    "double", "double", "double", "double","string","string","double","string","double","double"];

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
thousandSeperator=["FanPower", "FanSpeed", "CavityTemperature","EffectiveTemperature", "TargetTemperature", "Conditions", "PIDOutput", "PTerm", "ITerm", "DTerm"];

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
%%
opts.SelectedVariableNames=trueVariableNames;
unused=setdiff(opts.VariableNames,opts.SelectedVariableNames);

VariableTypes= ["string", "double", "double", "categorical", "double", "double", "double", "double", "categorical", "categorical", "categorical", "double", "categorical", "categorical", "categorical", "double", "double", "double", "double", "double", "categorical", "categorical", "categorical", "categorical"];

% match variable types with desired variables to be imported
unused_idx=zeros(1,length(unused));
for k=1:length(unused)
    temp=strcmp(opts.VariableNames,unused{k});
    unused_idx(k)=find(temp);   
end

unused_idx=sort(unused_idx);

for k=1:length(unused)
VariableTypes=[VariableTypes(1:unused_idx(k)-1) "char" VariableTypes(unused_idx(k):end)];
end
opts.VariableTypes=VariableTypes;




opts = setvaropts(opts, "Date_Time", "WhitespaceRule", "preserve");
opts = setvaropts(opts, emptyFields, "EmptyFieldRule", "auto");
opts = setvaropts(opts, thousandSeperator, "ThousandsSeparator", ",");


tbl = readtable(filename, opts);
%%
% k=randi(numel(tbl.GrillState)-50);
% 
% if isnan(str2double(tbl.GrillState(k)))==true
%     for k=1:numel(tbl.GrillState)
%         if tbl.GrillState(k)=="Home"
%             tbl.GrillState(k)=1;
%             continue
%         elseif tbl.GrillState(k)=="Diagnostic"
%             tbl.GrillState(k)=2;
%             continue
%         elseif tbl.GrillState(k)=="Preheat"
%             tbl.GrillState(k)=3;
%             continue
%         elseif tbl.GrillState(k)=="Cooking"
%             tbl.GrillState(k)=4;
%             continue
%         elseif tbl.GrillState(k)=="Shutdown"
%             tbl.GrillState(k)=5;
%             continue
%         else
%             tbl.GrillState(k)=nan;
%         end
%     end
%     tbl.GrillState=str2double(tbl.GrillState);
%     for k=length(tbl.GrillState):-1:1
%         if abs(tbl.GrillState(k))>5
%             tbl(k,:)=[];
%         end
%     end
% end

%% Convert to output type
columns=tbl.Properties.VariableNames;

[~,dataName,~]=fileparts(filename);
cookdata.fileName=filename;
cookdata.dataName=string(dataName);
cookdata.dateTime = tbl.Date_Time;
cookdata.grillState=tbl.GrillState;

if ismember("FanPower",columns)==true
    cookdata.FanPWM = tbl.FanPower;
end
if ismember("FanSpeed",columns)==true
    cookdata.FanRPM=tbl.FanSpeed;
end
if ismember("AugerSpeed",columns)==true
    cookdata.AugerRPM = tbl.AugerSpeed;
end

cookdata.TempF = tbl.CavityTemperature;

if ismember("DisplayTemperature",columns)==true
    cookdata.displayTemp=tbl.DisplayTemperature;
end

if ismember("EffectiveTemperature",columns)==true
    cookdata.grateTemp=tbl.EffectiveTemperature;
end
if ismember("AugerPower",columns)==true
    cookdata.AugerPWM = tbl.AugerPower;
end

cookdata.GPstatus = tbl.GlowPlugStatus;
cookdata.Errors = tbl.Errors;

if cookdata.grillModel=="Lumin"
    cookdata.SetTempF=tbl.LuminTargetTemperature;
elseif cookdata.grillModel=="GreenDay"
    cookdata.SetTempF=tbl.TargetTemperature;
end

if ismember("BoardTemperature",columns)==true
    cookdata.boardTemp=tbl.BoardTemperature;
end

if ismember("GlowPlugResistance",columns)==true
    cookdata.GPVoltage=tbl.GlowPlugResistance;
elseif ismember("GlowPlugVoltage",columns)==true
    cookdata.GPVoltage=tbl.GlowPlugVoltage;
end

if contains(cookdata.fileName,"GD","IgnoreCase",false)==true
    cookdata.P=tbl.PTerm./1000000;
    cookdata.I=tbl.ITerm./1000000;
    cookdata.D=tbl.DTerm./1000000;
    cookdata.U=tbl.PIDOutput./1000000;
elseif contains(cookdata.fileName,'Lumin',"IgnoreCase",true)==true
    cookdata.P=tbl.PTerm./1000;
    cookdata.I=tbl.ITerm./1000;
    cookdata.D=tbl.DTerm./1000;
    cookdata.U=tbl.PIDOutput./1000;
end

if ismember("EffectiveFuelLevel",columns)==true
    cookdata.FuelLevel=tbl.EffectiveFuelLevel;
    cookdata.FuelDistance=tbl.FuelSensorDistance;
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
for k=1:length(cookdata.FanPWM)
    x=find(cookdata.FanPWM==0);
    for j=1:length(x)
        cookdata.FanPWM(x(j))=nan;
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

%%
% cookdata.date=datetime(cookdata.dateTime(20),'InputFormat','eee MMM d HH:mm:ss yyyy');
% cookdata.date.Format="dd-MMM-yyyy";
% cookdata.date=string(cookdata.date);
cookdata.date="N/A";

%% Clear temporary variables
clear opts tbl
