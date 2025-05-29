function[cook]=getTimeToSteadyV2(cook) %% need to add for cases which never reach steady
for k=1:numel(cook)
    x=diff(cook(k).TempF);
    cook(k).tempSlope=conv(x,ones(300,1),"same");
    if ischar(cook(k).timetotemp)== false % only cooks which have reached SP
        %if any(cook(k).temp_slope(1:end))==0
        cook(k).timetosteady=0;
        for j=cook(k).timetotemp:numel(cook(k).tempSlope)
            if cook(k).tempSlope(j)>20|| cook(k).tempSlope(j)<-20
                cook(k).timetosteady=cook(k).timetosteady+1;
            else
                break
            end
        end
        cook(k).timetosteady=cook(k).timetosteady+cook(k).timetotemp;
        cook(k).minstosteady=cook(k).timetosteady/60;
    else
        cook(k).timetosteady='N/A';
        cook(k).minstosteady='N/A';
    end
end

%     elseif numel(cook(k).Set_Point)>0 && cook(k).SP_change== true %time to temp change
%         for j=1:numel(cook(k).Set_Point)
%             if j==1 % initial temp up
%                 for m=cook(k).timetotemp:cook(k).SPchangetime(j)
%                     if cook(k).temp_slope(m)<-20||cook(k).temp_slope(m)>20
%                         cook(k).timetosteady(j)=cook(k).timetosteady(j)+1;
%                     end
%                 end
%             elseif j<numel(cook(k).Set_Point)&& j>1  % middle temp change
%                 for m=cook(k).SPchangetime(j-1):cook(k).SPchangetime(j)
%                     if cook(k).temp_slope(m)<-20||cook(k).temp_slope(m)>20
%                         cook(k).timetosteady(j)=cook(k).timetosteady(j)+1;
%                     end
%                 end
%             else
%                 for m=cook(k).SPchangetime(j-1):numel(cook(k).TempF)-1 %% final SP change
%                     if cook(k).temp_slope(m)<-20||cook(k).temp_slope(m)>20
%                         cook(k).timetosteady(j)=cook(k).timetosteady(j)+1;
%                     end
%                 end
%             end
%         end
%     end
%     cook(k).timetoSS=cook(k).timetotemp+cook(k).timetosteady(1);
%     cook(k).timetotempchange=cook(k).timetosteady(2:end);
% end