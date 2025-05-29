function[cook]=separateCooks(cook,cookdata)


for k=numel(cook):-1:1

    y=cook(k).start;
    z=cook(k).stop+900; % Add 15 mins for shutdown
    j=y:z; % start to stop + shutdown 1 full cook duration

    if max(j)>length(cookdata.grillState)
        j=cook(k).start:length(cookdata.grillState);
    end

    cook(k).number=k;
    cook(k).dataName=string(cookdata.dataName);

    x=find(~isnan(cookdata.TempF(j)),1,'first');
    cook(k).startTemp=cookdata.TempF(y);
%     for x=j
%         if isnan(cookdata.TempF(x))==false
%             cook(k).startTemp=cookdata.TempF(x);
%             break
%         end
%     end

    cook(k).grillState=cookdata.grillState(j) ;
    cook(k).SetTempF=cookdata.SetTempF(j);
    cook(k).TempF=cookdata.TempF(j);
    cook(k).grateTemp=cookdata.grateTemp(j);

    if isfield(cookdata,'displayTemp')==false
        cook(k).displayTemp=[];
    else
        cook(k).displayTemp=cookdata.displayTemp(j);
    end

    cook(k).AugerRPM=cookdata.AugerRPM(j);
    cook(k).AugerPWM=cookdata.AugerPWM(j);
    cook(k).FanPWM=cookdata.FanPWM(j);
    cook(k).GPstatus=cookdata.GPstatus(j);
    cook(k).Errors=cookdata.Errors(j);
    cook(k).P=cookdata.P(j);
    cook(k).I=cookdata.I(j);
    cook(k).D=cookdata.D(j);
    cook(k).U=cookdata.U(j);
    cook(k).fileName=cookdata.fileName;
    cook(k).GPVoltage=cookdata.GPVoltage(j);

    if isfield(cookdata,'FuelLevel')==false
        cook(k).FuelLevel=[];
        cook(k).FuelDistance=[];
        cookdata.FuelLevel=[];
        cookdata.FuelDistance=[];
    end
    if isempty(cookdata.FuelLevel)==false
        cook(k).FuelLevel=cookdata.FuelLevel(j);
        cook(k).FuelDistance=cookdata.FuelDistance(j);
    end
end