function[cook]=getOvershoot(cook)
%cook variable ==i
for i=1:numel(cook)
    check=ischar(cook(i).timetotemp);
    if check == 0
        j=cook(i).timetotemp+1:(cook(i).timetotemp+900);
        if cook(i).timetotemp+900>numel(cook(i).grateTemp)
            j=cook(i).timetotemp:numel(cook(i).grateTemp); % if cook ends soon after time to temp
        end
        cook(i).overshoot=max(rmoutliers(cook(i).grateTemp(j)))-cook(i).setPoint(1);
    else
        cook(i).overshoot='N/A';
    end
end