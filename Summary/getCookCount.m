function [bySetTemp,byGrillSize]=getCookCount(structure)
bySetTemp=zeros(1,3);
byGrillSize=zeros(2,4);
for k=1:length(structure)
    if structure(k).duration<20
        continue
    end
    if structure(k).grillSize=="JX4"
        if structure(k).setPoint(1)<280
            byGrillSize(1,1)=byGrillSize(1,1)+1;
        elseif structure(k).setPoint(1)>280&& structure(k).setPoint(1)<=450
            byGrillSize(1,2)=byGrillSize(1,2)+1;
        elseif structure(k).setPoint(1)>450
            byGrillSize(1,3)=byGrillSize(1,3)+1;
        end
    end
    if structure(k).grillSize=="JX6"
        if structure(k).setPoint(1)<280
            byGrillSize(2,1)=byGrillSize(2,1)+1;
        elseif structure(k).setPoint(1)>280&& structure(k).setPoint(1)<=450
            byGrillSize(2,2)=byGrillSize(2,2)+1;
        elseif structure(k).setPoint(1)>450
            byGrillSize(2,3)=byGrillSize(2,3)+1;
        end
    end
end
% byGrillSize(1,4)='JX4';
% byGrillSize(2,4)='JX6';

bySetTemp(1,1)=byGrillSize(1,1)+byGrillSize(2,1);
bySetTemp(1,2)=byGrillSize(1,2)+byGrillSize(2,2);
bySetTemp(1,3)=byGrillSize(1,3)+byGrillSize(2,3);
