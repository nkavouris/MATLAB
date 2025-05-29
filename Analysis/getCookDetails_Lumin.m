
function[cookdata]=getCookDetails_Lumin(cookdata)
% cookdata.grillSize
% cookdata.grillVoltage
% cookdata.grillName
% cookdata.FW
%%
FWnames={'7706','7703','alpha28','alpha30','alpha27','7722','7805','7783','7811','7779','7790','7770','7760','7747','alpha43'};
grillNames={}; % must all be character or string array

%% grill size
if contains(cookdata.dataName,'Compact',"IgnoreCase",true)==true
    cookdata.grillSize="Compact";
elseif contains(cookdata.dataName,'Medium',"IgnoreCase",true)==true
    cookdata.grillSize="Medium";
end
%% grill voltage
if contains(cookdata.dataName,'230',"IgnoreCase",true)==true
    cookdata.grillVoltage=230;
elseif contains(cookdata.dataName,'120',"IgnoreCase",true)==true
    cookdata.grillVoltage=120;
    elseif contains(cookdata.dataName,'100',"IgnoreCase",true)==true
    cookdata.grillVoltage=100;
end
%% grill name
for m=1:length(grillNames)
    if contains(cookdata.dataName, grillNames{m},'IgnoreCase',true)==true
        cookdata.grillName=grillNames{m}; %grill name
        break
    else
        cookdata.grillName="N/A";
    end
end
%% FW nam
    for m=1:length(FWnames)
        if contains(cookdata.dataName, FWnames{m},'IgnoreCase',true)==true
            cookdata.FW=string(FWnames{m}); % grill FW
            break
        else
            cookdata.FW="N/A";
        end
    end


% for k=1:length(cook)
%     %cook(k).FW=cookdata.FW;
%     %cook(k).grillName=cookdata.grillName;
%     cook(k).grillModel=cookdata.grillModel;
%     cook(k).date=cookdata.date;
% end
