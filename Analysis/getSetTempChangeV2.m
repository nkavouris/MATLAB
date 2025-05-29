function[cook]=getSetTempChangeV2(cook)
for k=1:numel(cook)
    j=numel(cook(k).setPoint);
    if j>1

        cook(k).SP_change= true;

    else
        cook(k).SP_change= false;
    end
end