function[cook,cookdata]=getStartAndStopV2(cookdata)
startidx=1;
stopidx=1;
n=1;
cook=struct();
if isempty(cookdata.grillState)==false
    if cookdata.grillState(1)==1&&cookdata.grillState(2)==2
        cook(1).start=1;
        startidx=1+1;
    end
    if cookdata.grillState(1)==2&&cookdata.grillState(2)==2
        cook(1).start=1;
        startidx=1+1;
    end
    if cookdata.grillState(1)==4&&cookdata.grillState(2)==4
        cook(1).start=1;
        startidx=1+1;
    end
end
%%
grillState=[cookdata.grillState];

%% remove edge cases for interp1 to work
if grillState(1)==0||isnan(grillState(1))==true
    grillState(1)=1;
end
if grillState(end)==0||isnan(grillState(end))==true
    grillState(end)=5;
end
%% remove zero and nan values and replace with nearest real value
z=(grillState==0);
grillState(z)=interp1(find(~z), grillState(~z), find(z), 'nearest');

z=(isnan(grillState)==true);
grillState(z)=interp1(find(~z), grillState(~z), find(z), 'nearest');
%%
for k=1:length(grillState)-3
    if grillState(k)==1&&grillState(k+1)==2&&grillState(k+2)==2
        cook(startidx).start=k+1;
        startidx=startidx+1;
    elseif grillState(k)==5&&grillState(k+1)==2&&grillState(k+2)==2
        cook(startidx).start=k+1;
        startidx=startidx+1;
    elseif grillState(k)==4&&grillState(k+1)==4&&grillState(k+2)==5&&grillState(k+3)==5
        cook(stopidx).stop=k+1;
        stopidx=stopidx+1;
    elseif grillState(k)==1&&grillState(k+1)==4&&grillState(k+2)==5
        cook(stopidx).stop=k+1;
        stopidx=stopidx+1;
    elseif grillState(k)==2&&grillState(k+1)==5&&grillState(k+2)==1
        cook(stopidx).stop=k+1;
        stopidx=stopidx+1;
    end
    if isfield(cook,'stop')==0
        cook(stopidx).stop=numel(grillState);
    end
    if isfield(cook,'start')==0
        cook(startidx).start=1;
    end
end

    %% if start and stop are misaligned
    if numel(cook.start)>numel(cook.stop)
        if numel(cookdata.grillState)-cook(end).start>=900
            cook(end).stop=numel(cookdata.grillState);
        else
            cook(end)=[];
        end
    elseif numel(cook.stop)-numel(cook.start)==1
        A=[cook(1:end).start];
        A(end+1)=1;
        A=circshift(A,1); % shift values +1 index add cook(1).start as 1
        for k=1:length(A)
            cook(k).start=A(k);
        end
    end