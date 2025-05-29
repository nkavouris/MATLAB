function[cook]=getTempChangeTimeV2(cook)
for k=1:length(cook)
    if cook(k).SP_change == true
        for i=1:numel(cook(k).setPoint)-1
            cook(k).SPchangetime(i)=0;
            for m=1:numel(cook(k).SetTempF)-2
                if round(cook(k).SetTempF(m))==cook(k).setPoint(i)&&round(cook(k).SetTempF(m+1))==cook(k).setPoint(i)&&round(cook(k).SetTempF(m+2))==cook(k).setPoint(i+1)
                    cook(k).SPchangetime(i)=m+1;                
                end
                
            end
            cook(k).SPchangetime(i)= cook(k).SPchangetime(i)+cook(k).start;
        end
    else 
        cook(k).SPchangetime='N/A';
    end
end

