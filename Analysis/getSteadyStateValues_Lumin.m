function[cookdata]=getSteadyStateValues_Lumin(cookdata)

%%
for j=1:length(cookdata)
    [start,stop]=getSteadyStateBounds(cookdata(j));
    if isstring(start)==true
        cookdata(j).avgSSTemp=[];
        cookdata(j).avgSSgrateTemp=[];
        cookdata(j).avgSSburnerLevel=[];
        cookdata(j).startSS=[];
        cookdata(j).stopSS=[];
        
        continue
    end

    for k=1:length(start)
        if stop(k)>length(cookdata(j).TempF)
            stop(k)=length(cookdata(j).TempF);
        end
        cookdata(j).startSS(k)=start(k);
        cookdata(j).stopSS(k)=stop(k);
        cookdata(j).avgSSTemp(k)=round(nanmean(cookdata(j).TempF(start(k):stop(k))),1);
        cookdata(j).avgSSgrateTemp(k)=round(nanmean(cookdata(j).grateTemp(start(k):stop(k))),1);
        cookdata(j).avgSSburnerLevel(k)=round(nanmean(cookdata(j).burnerLevel(start(k):stop(k))),1);
    end
    for k=length(cookdata(j).avgSSTemp):-1:1
        if cookdata(j).avgSSTemp(k)<=100
            
            if numel(cookdata(j).avgSSTemp)<1
                cookdata(j).avgSSTemp(k)=0;
            else
                cookdata(j).avgSSTemp(k)=[];
            end
            cookdata(j).avgSSgrateTemp(k)=[];
            cookdata(j).startSS(k)=[];
            cookdata(j).stopSS(k)=[];
            cookdata(j).avgSSburnerLevel(k)=[];
        end
    end
end
%%
% test=vertcat(MasterStruct.setPoint);
% test=unique(test);
% test=sort(test);
