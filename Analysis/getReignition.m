function [cook]=getReignition(cook)
%% initialize
for k=1:length(cook)
    cook(k).reignition=false;
    cook(k).reignitionStart=[];
    cook(k).reignitionEnd=[];
    cook(k).reignitionCount=0;
    gp=cook(k).GPstatus;
    setpoint=cook(k).SetTempF;
    ignition_flag=false;
    gp_on_duration=0;
    start=600;
    %% find reignitions

    if length(gp)<=600
        cook(k).reignition=false;
        cook(k).reignitionStart=[];
        cook(k).reignitionEnd=[];
        cook(k).reignitionCount=0;
        start=1;
    end
    gp_on=find(gp(start:end));
    gp_off=find(~gp(start:end));
    if isempty(gp_on)==true
        cook(k).reignition=false;
        cook(k).reignitionStart=[];
        cook(k).reignitionEnd=[];
        cook(k).reignitionCount=0;
    end
    for j=2:length(gp_on)
        if gp_on(j)==gp_on(j-1)+1
            gp_on_duration=gp_on_duration+1;
            if gp_on_duration>=10&&~ignition_flag
                ignition_flag=true;
                cook(k).reignitionCount=cook(k).reignitionCount+1;
                cook(k).reignitionStart(end+1)=gp_on(j-10);
                cook(k).reignition=true;
            end
        elseif gp_on(j)~=gp_on(j-1)+1&&ignition_flag
            gp_on_duration=0;
            ignition_flag=false;
            cook(k).reignitionEnd(end+1)=gp_on(j-1);
        end
        if j==length(gp_on)&&ignition_flag
            cook(k).reignitionEnd(end+1)=gp_on(j);
        end
    end
end


