function[cook]=getTimeToTempV3(cook,cookdata)
% if nuc
for k=1:numel(cook) %%% add in sear
    cook(k).timetotemp=0;
    for i=cook(k).start:cook(k).stop %proper time range of cook
        if isempty(cook(k).setPoint)==true
            cook(k).timetotemp='N/A';
            cook(k).minstotemp='N/A';
            continue
        elseif cook(k).setPoint(1) >= 450 %% sear
            if cook(k).setPoint(1)-max(cookdata.grateTemp)>75
                cook(k).timetotemp='Temp Not Reached';
                cook(k).minstotemp='Temp Not Reached';
                break
            end
            if cook(k).setPoint(1)-cookdata.grateTemp(i)<=75
                break %stop time to temp calc
            elseif cook(k).setPoint(1)-cookdata.grateTemp(i)>75
                cook(k).timetotemp=cook(k).timetotemp+1;
            end
        elseif cook(k).setPoint(1)<450&&cook(k).setPoint(1)>=300 %% roast
            if cook(k).setPoint(1)-max(cook(k).grateTemp)>75
                cook(k).timetotemp='Temp Not Reached';
                cook(k).minstotemp='Temp Not Reached';
                break
            end
            if cook(k).setPoint(1)-cookdata.grateTemp(i)<=50 %includes lack of SP offset right now
                break  %stop time to temp calc
            elseif cook(k).setPoint(1)-cookdata.grateTemp(i)>50
                cook(k).timetotemp=cook(k).timetotemp+1;
            end
        elseif cook(k).setPoint(1)<300 %% smoke
            if cook(k).setPoint(1)-max(cookdata.grateTemp)>75
                cook(k).timetotemp='Temp Not Reached';
                cook(k).minstotemp='Temp Not Reached';
                break
            end

            if cook(k).setPoint(1)-cookdata.grateTemp(i)<=25 %includes lack of SP offset right now
                break  %stop time to temp calc
            elseif cook(k).setPoint(1)-cookdata.grateTemp(i)>25
                cook(k).timetotemp=cook(k).timetotemp+1;
            end
           
        end
        if ischar(cook(k).timetotemp)== false
            cook(k).minstotemp=cook(k).timetotemp/60;
        end
    end
    if cook(k).timetotemp==numel(cook(k).grateTemp)
        cook(k).timetotemp='Temp Not Reached';
        cook(k).minstotemp='Temp Not Reached';

    end
    if cook(k).timetotemp==0
        cook(k).timetotemp=1;
        cook(k).minstotemp=1;
    end
    if ischar(cook(k).minstotemp)==false
    cook(k).minstotemp=cook(k).minstotemp+0.5;
    end
end
