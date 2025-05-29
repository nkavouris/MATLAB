function[cook]=getSetTempV2(cook)
for k=1:numel(cook)
    cook(k).setPoint=unique(cook(k).SetTempF,'stable');
    j=numel(cook(k).setPoint);
    for n=j:-1:1 %% remove NaN
        if isnan(cook(k).setPoint(n)) == true
            cook(k).setPoint(n)=[];
        end
    end
    j=numel(cook(k).setPoint);
    for n=j:-1:1
        if cook(k).setPoint(n)<=179 %index of SP must match index of start
            cook(k).setPoint(n)=[];
        elseif cook(k).setPoint(n)>600
            cook(k).setPoint(n)=[];
        end
    end
    j=numel(cook(k).setPoint); % remove set points that are set for less than 5 mins
    for n=j:-1:1
        if numel(find(cook(k).SetTempF==cook(k).setPoint(n)))<300
            cook(k).setPoint(n)=[];
        end
    end
end
for k=1:length(cook)
    if isempty(cook(k).setPoint)==false
        cook(k).setPoint=round(cook(k).setPoint);
    end
end
