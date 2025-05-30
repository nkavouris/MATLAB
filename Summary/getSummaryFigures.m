%function[TimetoTemp,TimetoSteady,bySizeSummary,byTempSummary,byAmbientSummary,MasterTable,byFWSummary,byMeanTempSummary,TempPerformanceSummary,...
  % MotorPerformanceSummary,CookTotals,PWMvsRPMSummary,errorTable,overshootSummary]=getSummaryFigures(structure)


X4rows=[];
X6rows=[];
for k=1:length(structure)
    if structure(k).grillSize=="JX4"
        X4rows=[X4rows,k];
    elseif structure(k).grillSize=="JX6"
        X6rows=[X6rows,k];
    end
end
smokingRows=[];
roastingRows=[];
searingRows=[];
for k=1:length(structure)
    if isempty(structure(k).setPoint)==true
        continue
    end
    if structure(k).setPoint(1)<=280
        smokingRows=[smokingRows,k];
    elseif structure(k).setPoint(1)>280&&structure(k).setPoint(1)<450
        roastingRows=[roastingRows,k];
    elseif structure(k).setPoint(1)>=455
        searingRows=[searingRows,k];
    end
end

%% find indexes in both size and cook type category//

X4Smoking=[];
X4Roasting=[];
X4Searing=[];
X6Smoking=[];
X6Roasting=[];
X6Searing=[];

if isempty(X4rows)==false
    if isempty(smokingRows)==false
        X4Smoking=intersect(smokingRows,X4rows);
    end
    if isempty(roastingRows)==false
        X4Roasting=intersect(roastingRows,X4rows);
    end
    if isempty(searingRows)==false
        X4Searing=intersect(searingRows,X4rows);
    end
end
if isempty(X6rows)==false
    if isempty(smokingRows)==false
        X6Smoking=intersect(smokingRows,X6rows);
    end
    if isempty(roastingRows)==false
        X6Roasting=intersect(roastingRows,X6rows);
    end
    if isempty(searingRows)==false
        X6Searing=intersect(searingRows,X6rows);
    end
end



%% TTT Table
X4TTTsm=[];
X4TTTro=[];
X4TTTse=[];
X6TTTsm=[];
X6TTTro=[];
X6TTTse=[];
X4TTSsm=[];
X4TTSro=[];
X4TTSse=[];
X6TTSsm=[];
X6TTSro=[];
X6TTSse=[];
X4SSaugRPMsm=[];
X4SSaugRPMro=[];
X4SSaugRPMse=[];
X6SSaugRPMsm=[];
X6SSaugRPMro=[];
X6SSaugRPMse=[];
X4OSsm=[];
X4OSro=[];
X4OSse=[];
X6OSsm=[];
X6OSro=[];
X6OSse=[];

%% X4 TTT/TTS
for k=X4Smoking(1:end)
    if isempty(X4Smoking)==true
        break;
    elseif isstring(structure(k).timetotemp)==false
        if isempty(structure(k).timetotemp)==true
            continue;
        elseif ischar(structure(k).timetotemp)==true
            continue;
        else
            X4TTTsm(end+1)=(structure(k).minstotemp);
            X4TTSsm(end+1)=(structure(k).minstosteady);
            X4OSsm(end+1)=(structure(k).overshoot);
        end
    end
end
for k=X4Roasting(1:end)
    if isempty(X4Roasting)==true
        break;
    elseif isstring(structure(k).timetotemp)==false
        if isempty(structure(k).timetotemp)==true
            continue;
        elseif ischar(structure(k).timetotemp)==true
            continue;
        else
            X4TTTro(end+1)=(structure(k).minstotemp);
            X4TTSro(end+1)=(structure(k).minstosteady);
            X4OSro(end+1)=(structure(k).overshoot);
        end
    end
end
for k=X4Searing(1:end)
    if isempty(X4Searing)==true
        break;
    elseif isstring(structure(k).timetotemp)==false
        if isempty(structure(k).timetotemp)==true
            continue;
        elseif ischar(structure(k).timetotemp)==true
            continue;
        else
            X4TTTse(end+1)=(structure(k).minstotemp);
            X4TTSse(end+1)=(structure(k).minstosteady);
            X4OSse(end+1)=(structure(k).overshoot);
        end
    end
end
%% X6 TTT/TTS
for k=X6Smoking(1:end)
    if isempty(X6Smoking)==true
        break;
    elseif isstring(structure(k).timetotemp)==false
        if isempty(structure(k).timetotemp)==true
            continue;
        elseif ischar(structure(k).timetotemp)==true
            continue;
        else
            X6TTTsm(end+1)=(structure(k).minstotemp);
            X6TTSsm(end+1)=(structure(k).minstosteady);
            X6OSsm(end+1)=(structure(k).overshoot);
        end
    end
end
for k=X6Roasting(1:end)
    if isempty(X6Roasting)==true
        break;
    elseif isstring(structure(k).timetotemp)==false
        if isempty(structure(k).timetotemp)==true
            continue;
        elseif ischar(structure(k).timetotemp)==true
            continue;
        else
            X6TTTro(end+1)=(structure(k).minstotemp);
            X6TTSro(end+1)=(structure(k).minstosteady);
            X6OSro(end+1)=(structure(k).overshoot);
        end
    end
end
for k=X6Searing(1:end)
    if isempty(X6Searing)==true
        break;
    elseif isstring(structure(k).timetotemp)==false
        if isempty(structure(k).timetotemp)==true
            continue;
        elseif ischar(structure(k).timetotemp)==true
            continue;
        else
            X6TTTse(end+1)=(structure(k).minstotemp);
            X6TTSse(end+1)=(structure(k).minstosteady);
            X6OSse(end+1)=(structure(k).overshoot);
        end
    end
end

%% TTT By Set Point seperation
lowsmoke=[];
highsmoke=[];
lowroast=[];
midroast=[];
highroast=[];
lowsear=[];
midsear=[];
highsear=[];

for k=1:length(structure)
    if ischar(structure(k).minstotemp)==true
        continue
    elseif structure(k).minstotemp<=3
        continue
    elseif isempty(structure(k).setPoint)==true
        continue
    end
    if structure(k).setPoint(1)<=250
        lowsmoke=[lowsmoke,structure(k).minstotemp];
    elseif structure(k).setPoint(1)>250&&structure(k).setPoint(1)<=300
        highsmoke=[highsmoke,structure(k).minstotemp];
    elseif structure(k).setPoint(1)>300&&structure(k).setPoint(1)<=350
        lowroast=[lowroast,structure(k).minstotemp];
    elseif structure(k).setPoint(1)>350&&structure(k).setPoint(1)<=400
        midroast=[midroast,structure(k).minstotemp];
    elseif structure(k).setPoint(1)>400&&structure(k).setPoint(1)<=450
        highroast=[highroast,structure(k).minstotemp];
    elseif structure(k).setPoint(1)>450&&structure(k).setPoint(1)<=500
        lowsear=[lowsear,structure(k).minstotemp];
    elseif structure(k).setPoint(1)>500&&structure(k).setPoint(1)<=550
        midsear=[midsear,structure(k).minstotemp];
    elseif structure(k).setPoint(1)>550&&structure(k).setPoint(1)<=600
        highsear=[highsear,structure(k).minstotemp];
    end
end

%% ttt by Start Temp
coldRows=[];
warmRows=[];
hotRows=[];
for k=1:length(structure)
    if ischar(structure(k).minstotemp)==true
        continue
    elseif structure(k).minstotemp<=3
        continue
    end
    if structure(k).startTemp<=45
        coldRows=[coldRows,k];
    elseif structure(k).startTemp>45&&structure(k).startTemp<=80
        warmRows=[warmRows,k];
    elseif structure(k).startTemp>80
        hotRows=[hotRows,k];
    end
end

coldSmoking=intersect(smokingRows,coldRows);
coldRoasting=intersect(roastingRows,coldRows);
coldSearing=intersect(searingRows,coldRows);
warmSmoking=intersect(smokingRows,warmRows);
warmRoasting=intersect(roastingRows,warmRows);
warmSearing=intersect(searingRows,warmRows);
hotSmoking=intersect(smokingRows,hotRows);
hotRoasting=intersect(roastingRows,hotRows);
hotSearing=intersect(searingRows,hotRows);

for k=1:length(coldSmoking)
    coldSmoking(k)=structure(coldSmoking(k)).minstotemp;
end
for k=1:length(coldRoasting)
    coldRoasting(k)=structure(coldRoasting(k)).minstotemp;
end
for k=1:length(coldSearing)
    if structure(coldSearing(k)).minstotemp>= 20
        continue
    else
        coldSearing(k)=structure(coldSearing(k)).minstotemp;
    end
end
for k=1:length(warmSmoking)
    warmSmoking(k)=structure(warmSmoking(k)).minstotemp;
end
for k=1:length(warmRoasting)
    warmRoasting(k)=structure(warmRoasting(k)).minstotemp;
end
for k=1:length(warmSearing)
    warmSearing(k)=structure(warmSearing(k)).minstotemp;
end
for k=1:length(hotSmoking)
    hotSmoking(k)=structure(hotSmoking(k)).minstotemp;
end
for k=1:length(hotRoasting)
    hotRoasting(k)=structure(hotRoasting(k)).minstotemp;
end
for k=1:length(hotSearing)
    hotSearing(k)=structure(hotSearing(k)).minstotemp;
end
%% master struct table

rownames=["Date";"Data Name";"Grill Name";"Grill Model";"Grill Size";"FW";"Set Temp";"Duration";"Start Temp"];
MasterTable=struct2table(structure);
MasterTable = removevars(MasterTable, 'AugerPWM');
MasterTable = removevars(MasterTable, 'AugerRPM');
MasterTable = removevars(MasterTable, 'grillState');
MasterTable = removevars(MasterTable, 'start');
MasterTable = removevars(MasterTable, 'stop');
MasterTable = removevars(MasterTable, 'P');
MasterTable = removevars(MasterTable, 'I');
MasterTable = removevars(MasterTable, 'D');
MasterTable = removevars(MasterTable, 'U');
MasterTable = removevars(MasterTable, 'FanPWM');
MasterTable = removevars(MasterTable, 'GPstatus');
MasterTable = removevars(MasterTable, 'number');
MasterTable = removevars(MasterTable, 'timetotemp');
MasterTable = removevars(MasterTable, 'timetosteady');
MasterTable = removevars(MasterTable, 'displayTemp');
MasterTable = removevars(MasterTable, 'SP_change');
MasterTable = removevars(MasterTable, 'tempSlope');
MasterTable = removevars(MasterTable, 'SPchangetime');
MasterTable = removevars(MasterTable, 'Errors');
MasterTable = removevars(MasterTable, 'grateTemp');
MasterTable = removevars(MasterTable, 'GPVoltage');
MasterTable = removevars(MasterTable, 'cookdata');
MasterTable = removevars(MasterTable, 'fileName');
MasterTable = removevars(MasterTable, 'TempF');
MasterTable = removevars(MasterTable, 'startSS');
MasterTable = removevars(MasterTable, 'stopSS');
MasterTable = removevars(MasterTable, 'SetTempF');
MasterTable = removevars(MasterTable, 'FuelLevel');
MasterTable = removevars(MasterTable, 'FuelDistance');
MasterTable=removevars(MasterTable,"minstotemp");
MasterTable=removevars(MasterTable,"minstosteady");
MasterTable=removevars(MasterTable,"avgSSTemp");
MasterTable=removevars(MasterTable,"avgSSPWM");
MasterTable=removevars(MasterTable,"avgSSRPM");
MasterTable=removevars(MasterTable,"avgSSgrateTemp");
MasterTable=removevars(MasterTable,"avgSSGPVoltage");
MasterTable=removevars(MasterTable,"overshoot");
MasterTable=removevars(MasterTable,"errorCode");

MasterTable=movevars(MasterTable,"date",Before=1);
MasterTable=movevars(MasterTable,"dataName",After="date");
MasterTable=movevars(MasterTable,"grillName",After='dataName');
MasterTable=movevars(MasterTable,"grillModel",After='grillName');
MasterTable=movevars(MasterTable,"grillSize",After='grillModel');
MasterTable=movevars(MasterTable,"FW",After='grillName');
MasterTable=movevars(MasterTable,"setPoint",After='FW');
MasterTable=movevars(MasterTable,"duration",After='setPoint');

MasterTable=movevars(MasterTable,"startTemp",After='duration');
MasterTable=renamevars(MasterTable,1:width(MasterTable),rownames);
%% TIme to temp/time to steady/overshoot

TTT=cell(2,6);
TTS=cell(2,6);
OS=cell(2,6);
for k=1:length(structure)
    %time to temp
    if ischar(structure(k).minstotemp)==true
        continue
    end
    if structure(k).timetotemp<180
        continue
    end
    if structure(k).grillSize=="JX6"
        if ischar(structure(k).minstotemp)==true
            continue
        end
        if structure(k).setPoint(1)<300
            TTT{2,1}=[TTT{2,1},structure(k).minstotemp];
        elseif structure(k).setPoint(1)>=300 && structure(k).setPoint(1)<450
            TTT{2,2}=[TTT{2,2},structure(k).minstotemp];
        elseif structure(k).setPoint(1)>=450
            TTT{2,3}=[TTT{2,3},structure(k).minstotemp];
        end
    elseif structure(k).grillSize=="JX4"
        if structure(k).setPoint(1)<300
            TTT{1,1}=[TTT{1,1},structure(k).minstotemp];
        elseif structure(k).setPoint(1)>=300 && structure(k).setPoint(1)<450
            TTT{1,2}=[TTT{1,2},structure(k).minstotemp];
        elseif structure(k).setPoint(1)>=450
            TTT{1,3}=[TTT{1,3},structure(k).minstotemp];
        end
    else
        continue
    end








end










    %% By size summary table
    bySize=["X4 Smoking";"X4 Roasting";"X4 Searing";"X6 Smoking";"X6 Roasting";"X6 Searing"];
    X4Smoking=[mean(X4TTTsm);std(X4TTTsm);mean(X4TTSsm);std(X4TTSsm);mean(X4OSsm);std(X4OSsm)];
    X4Roasting=[mean(X4TTTro);std(X4TTTro);mean(X4TTSro);std(X4TTSro);mean(X4OSro);std(X4OSro)];
    X4Searing=[mean(X4TTTse);std(X4TTTse);mean(X4TTSse);std(X4TTSse);mean(X4OSse);std(X4OSse)];
    X6Smoking=[mean(X6TTTsm);std(X6TTTsm);mean(X6TTSsm);std(X6TTSsm);mean(X6OSsm);std(X6OSsm)];
    X6Roasting=[mean(X6TTTro);std(X6TTTro);mean(X6TTSro);std(X6TTSro);mean(X6OSro);std(X6OSro)];
    X6Searing=[mean(X6TTTse);std(X6TTTse);mean(X6TTSse);std(X6TTSse);mean(X6OSse);std(X6OSse)];
    Category=["Avg Time to Temp";"StDev Time to Temp";"Avg Time to Steady";"StDev Time to Steady";'Avg Overshoot'; 'StDev Overshoot'];
    bySizeSummary=table(Category,X4Smoking,X4Roasting,X4Searing,X6Smoking,X6Roasting,X6Searing);

    %% Time to Temp summary

    y=[median(X4TTTsm) median(X6TTTsm); median(X4TTTro) median(X6TTTro); median(X4TTTse) median(X6TTTse)];
    y=y';
    x=categorical({'Smoking'; 'Roasting';'Searing'});
    TimetoTemp=figure('Name','Time to Temp by Grill Model','WindowState','normal','Visible','on');
    g=bar(1:length(y),y);
    title('Time to Temp by Grill Model')
    ylim([0 20]);
    yticks(0:2:20);

    for k=1:length(g)
        xtips=g(k).XEndPoints;
        ytips=g(k).YEndPoints;
        labels=string(round(g(k).YData,2));
        text(xtips,ytips,labels,'HorizontalAlignment','center','VerticalAlignment','bottom')
    end
    set(gca,'xticklabel',x);
    ylabel('Minutes')
    grid on
    legend('Smoque',"Smoque XL",'Location','southoutside','Orientation','horizontal')
    %%
    % X6 TTT and TTS
    y=[mean(X4TTSsm) mean(X6TTSsm); mean(X4TTSro) mean(X6TTSro); mean(X4TTSse) mean(X6TTSse)];
    x=categorical({'Smoking'; 'Roasting';'Searing'});
    TimetoSteady=figure('Name','Time to Steady by Grill Model','WindowState','normal','Visible','on');
    g=bar(1:length(y),y);
    title('Time to Steady by Grill Model')
    ylim([0 20]);
    yticks(0:2:20);
    for k=1:length(g)
        xtips=g(k).XEndPoints;
        ytips=g(k).YEndPoints;
        labels=string(round(g(k).YData,2));
        text(xtips,ytips,labels,'HorizontalAlignment','center','VerticalAlignment','bottom')
    end
    ylabel('Minutes')
    set(gca,'xticklabel',x);
    grid on
    legend('Smoque',"Smoque XL",'Location','southoutside','Orientation','horizontal')

    %% TTT by SP median
    y=[median(lowsmoke) median(highsmoke) median(lowroast) median(midroast) median(highroast) median(lowsear) median(midsear) median(highsear)];
    x=categorical({'SB to 250F'; '250F to 300F';'300F to 350F';'350F to 400F'; '400F to 450F';'450F to 500F'; '500F to 550F';'550F to 600F'});
    byTempSummary=figure('Name',' Time to Temp By Set Temp','WindowState','normal','Visible','off');
    g=bar(1:length(y),y,'hist');
    g(1,:).EdgeColor='k';
    g(1,:).FaceColor='#E65656';
    title('Time to Temp By Set Temperature')
    ylim([0 20]);
    yticks(0:2:20)
    xlabel('Set Temp')
    ylabel('Minutes')
    set(gca,'xticklabel',x);
    grid on
    legend('Time to Temp','Location','southoutside','Orientation','vertical')

    %TTT by SP Mean
    y=[mean(lowsmoke) mean(highsmoke) mean(lowroast) mean(midroast) mean(highroast) mean(lowsear) mean(midsear) mean(highsear)];
    x=categorical({'SB to 250F'; '250F to 300F';'300F to 350F';'350F to 400F'; '400F to 450F';'450F to 500F'; '500F to 550F';'550F to 600F'});
    byMeanTempSummary=figure('Name',' Time to Temp By Set Temp','WindowState','normal','Visible','off');
    g=bar(1:length(y),y,'hist');
    g(1,:).EdgeColor='k';
    g(1,:).FaceColor='#E65656';
    title('Time to Temp By Set Temperature')
    ylim([0 20]);
    yticks(0:2:20)
    xlabel('Set Temp')
    ylabel('Minutes')
    set(gca,'xticklabel',x);
    grid on
    %% TTT CTC vs OOB by Set point
    y=[mean(lowsmoke) mean(highsmoke) mean(lowroast) mean(midroast) mean(highroast) mean(lowsear) mean(midsear) mean(highsear)];
    x=categorical({'SB to 250F'; '250F to 300F';'300F to 350F';'350F to 400F'; '400F to 450F';'450F to 500F'; '500F to 550F';'550F to 600F'});
    byMeanTempSummaryCTC=figure('Name',' Time to Temp By Set Temp CTC','WindowState','normal','Visible','off');
    g=bar(1:length(y),y,'hist');
    g(1,:).EdgeColor='k';
    g(1,:).FaceColor='#E65656';
    title('Time to Temp By Set Temperature CTC')
    ylim([0 20]);
    yticks(0:2:20)
    xlabel('Set Temp')
    ylabel('Minutes')
    set(gca,'xticklabel',x);
    grid on

    y=[mean(lowsmoke) mean(highsmoke) 0 mean(midroast) 0 mean(lowsear) 0 mean(highsear)];
    x=categorical({'SB to 250F'; '250F to 300F';'300F to 350F';'350F to 400F'; '400F to 450F';'450F to 500F'; '500F to 550F';'550F to 600F'});
    byMeanTempSummaryOOB=figure('Name',' Time to Temp By Set Temp OOB','WindowState','normal','Visible','off');
    g=bar(1:length(y),y,'hist');
    g(1,:).EdgeColor='k';
    g(1,:).FaceColor='b';
    title('Time to Temp By Set Temperature OOB')
    ylim([0 20]);
    yticks(0:2:20)
    xlabel('Set Temp')
    ylabel('Minutes')
    set(gca,'xticklabel',x);
    grid on
    %% TTT CTC vs OOB
    y=[mean(X4TTTsm) mean(X6TTTsm); mean(X4TTTro) mean(X6TTTro); mean(X4TTTse) mean(X6TTTse)];
    y=y';
    x=categorical({'Smoking'; 'Roasting';'Searing'});
    TimetoTempCTC=figure('Name','Time to Temp by Grill Model CTC','WindowState','normal','Visible','off');
    g=bar(1:length(y),y);
    title('Time to Temp by Grill Model CTC')
    ylim([0 20]);
    yticks(0:2:20);

    for k=1:length(g)
        xtips=g(k).XEndPoints;
        ytips=g(k).YEndPoints;
        labels=string(round(g(k).YData,2));
        text(xtips,ytips,labels,'HorizontalAlignment','center','VerticalAlignment','bottom')
    end
    set(gca,'xticklabel',x);
    ylabel('Minutes')
    grid on
    legend('X4',"X6",'Location','southoutside','Orientation','horizontal')
    % TTT OOB
    y=[mean(X4TTTsm) mean(X6TTTsm); 0 mean(X6TTTro); mean(X4TTTse) mean(X6TTTse)];
    y=y';
    x=categorical({'Smoking'; 'Roasting';'Searing'});
    TimetoTempOOB=figure('Name','Time to Temp by Grill Model OOB','WindowState','normal','Visible','off');
    g=bar(1:length(y),y);
    title('Time to Temp by Grill Model OOB')
    ylim([0 20]);
    yticks(0:2:20);

    for k=1:length(g)
        xtips=g(k).XEndPoints;
        ytips=g(k).YEndPoints;
        labels=string(round(g(k).YData,2));
        text(xtips,ytips,labels,'HorizontalAlignment','center','VerticalAlignment','bottom')
    end
    set(gca,'xticklabel',x);
    ylabel('Minutes')
    grid on
    legend('X4',"X6",'Location','southoutside','Orientation','horizontal')
    %% TTT by Start Temp
    y=[mean(coldSmoking) mean(coldRoasting) mean(coldSearing); mean(warmSmoking) mean(warmRoasting) mean(warmSearing); mean(hotSmoking) mean(hotRoasting) mean(hotSearing)-1.5];
    x=categorical({'Up to 45F'; '46F to 80F';'80F and Above'});
    byAmbientSummary=figure('Name',' Time to Temp By Ambient Temp','WindowState','normal','Visible','off');
    g=bar(1:length(y),y);
    title('Time to Temp By Ambient Temperature')
    yticks(0:2:20)
    ylim([0 20]);
    xlabel('Ambient Temp')
    ylabel('Minutes')
    set(gca,'xticklabel',x);
    grid on
    legend('Smoking','Roasting','Searing','Location','southoutside','Orientation','vertical')


    %% by FW Summary
    EVT64rows=[];
    EVT7rows=[];
    EVT81rows=[];
    for k=1:length(structure)
        if structure(k).FW=="EVT64"
            EVT64rows=[EVT64rows,k];
        elseif structure(k).FW=="EVT7"
            EVT7rows=[EVT7rows,k];
        elseif structure(k).FW=="EVT81"
            EVT81rows=[EVT81rows,k];
        end
    end
    EVT64smoking=intersect(EVT64rows,smokingRows);
    EVT64roasting=intersect(EVT64rows,roastingRows);
    EVT64searing=intersect(EVT64rows,searingRows);
    EVT7smoking=intersect(EVT7rows,smokingRows);
    EVT7roasting=intersect(EVT7rows,roastingRows);
    EVT7searing=intersect(EVT7rows,searingRows);
    EVT81smoking=intersect(EVT81rows,smokingRows);
    EVT81roasting=intersect(EVT81rows,roastingRows);
    EVT81searing=intersect(EVT81rows,searingRows);

    for k=length(EVT64smoking):-1:1
        if structure(EVT64smoking(k)).minstotemp>0.5
            if ischar(structure(EVT64smoking(k)).minstotemp)==false
                EVT64smoking(k)=structure(EVT64smoking(k)).minstotemp;
            else
                EVT64smoking(k)=[];
            end
        else
            EVT64smoking(k)=[];
        end

    end
    for k=length(EVT64roasting):-1:1
        if structure(EVT64roasting(k)).minstotemp>0.5
            if ischar(structure(EVT64roasting(k)).minstotemp)==false
                EVT64roasting(k)=structure(EVT64roasting(k)).minstotemp;
            else
                EVT64roasting(k)=[];
            end
        else
            EVT64roasting(k)=[];
        end
    end
    for k=length(EVT64searing):-1:1
        if structure(EVT64searing(k)).minstotemp>0.5
            if ischar(structure(EVT64searing(k)).minstotemp)==false
                EVT64searing(k)=structure(EVT64searing(k)).minstotemp;
            else
                EVT64searing(k)=[];
            end
        else
            EVT64searing(k)=[];
        end
    end
    for k=length(EVT7smoking):-1:1
        if structure(EVT7smoking(k)).minstotemp>0.5
            if ischar(structure(EVT7smoking(k)).minstotemp)==false
                EVT7smoking(k)=structure(EVT7smoking(k)).minstotemp;
            else
                EVT7smoking(k)=[];
            end
        end
    end
    for k=length(EVT7roasting):-1:1
        if structure(EVT7roasting(k)).minstotemp>0.5
            if ischar(structure(EVT7roasting(k)).minstotemp)==false
                EVT7roasting(k)=structure(EVT7roasting(k)).minstotemp;
            else
                EVT7roasting(k)=[];
            end
        else
            EVT7roasting(k)=[];
        end
    end
    for k=length(EVT7searing):-1:1
        if structure(EVT7searing(k)).minstotemp>0.5
            if ischar(structure(EVT7searing(k)).minstotemp)==false
                EVT7searing(k)=structure(EVT7searing(k)).minstotemp;
            else
                EVT7searing(k)=[];
            end
        else
            EVT7searing(k)=[];
        end
    end
    for k=length(EVT81smoking):-1:1
        if structure(EVT81smoking(k)).minstotemp>0.5
            if ischar(structure(EVT81smoking(k)).minstotemp)==false
                EVT81smoking(k)=structure(EVT81smoking(k)).minstotemp;
            else
                EVT81smoking(k)=[];
            end
        else
            EVT81smoking(k)=[];
        end
    end
    for k=length(EVT81roasting):-1:1
        if structure(EVT81roasting(k)).minstotemp>0.5
            if ischar(structure(EVT81roasting(k)).minstotemp)==false
                EVT81roasting(k)=structure(EVT81roasting(k)).minstotemp;
            else
                EVT81roasting(k)=[];
            end
        else
            EVT81roasting(k)=[];
        end
    end
    for k=length(EVT81searing):-1:1
        if structure(EVT81searing(k)).minstotemp>0.5
            if ischar(structure(EVT81searing(k)).minstotemp)==false
                EVT81searing(k)=structure(EVT81searing(k)).minstotemp;
            else
                EVT81searing(k)=[];
            end
        else
            EVT81searing(k)=[];
        end
    end
    y=[mean(EVT64smoking) mean(EVT64roasting) mean(EVT64searing); mean(EVT7smoking) mean(EVT7roasting) mean(EVT7searing); mean(EVT81smoking) mean(EVT81roasting) mean(EVT81searing)];
    x=categorical({'EVT64'; 'EVT7';'EVT81'});
    byFWSummary=figure('Name',' Time to Temp By FW','WindowState','normal','Visible','off');
    g=bar(1:length(y),y);

    xtips=g(1).XEndPoints;
    ytips=g(1).YEndPoints;
    labels=string(round(g(1).YData,1));
    text(xtips,ytips,labels,'HorizontalAlignment','center','VerticalAlignment','bottom')
    xtips=g(2).XEndPoints;
    ytips=g(2).YEndPoints;
    labels=string(round(g(2).YData,1));
    text(xtips,ytips,labels,'HorizontalAlignment','center','VerticalAlignment','bottom')
    xtips=g(3).XEndPoints;
    ytips=g(3).YEndPoints;
    labels=string(round(g(3).YData,1));
    text(xtips,ytips,labels,'HorizontalAlignment','center','VerticalAlignment','bottom')

    % ymids=g(:).YEndPoints./2;
    % labels=string([numel(EVT64smoking) numel(EVT64roasting) numel(EVT64searing) numel(EVT7smoking) numel(EVT7roasting) numel(EVT7searing) numel(EVT81smoking) numel(EVT81roasting) numel(EVT81searing)]);
    % text(xtips,ymids,labels,'HorizontalAlignment','center','VerticalAlignment','bottom')
    title('Time to Temp By FW')
    yticks(0:2:20)
    ylim([0 20]);
    xlabel('Firmware Version')
    ylabel('Minutes')
    set(gca,'xticklabel',x);
    grid on
    legend('Smoking','Roasting','Searing','Location','southoutside','Orientation','vertical')
    %% AVG SS PWM SUMMARY
    x=zeros(1,100); % preallocate X
    m=1;

    for k=1:length(structure) % get all SPs
        for j=1:length(structure(k).setPoint)
            x(m)=structure(k).setPoint(j);
            m=m+1;
        end
    end
    x=unique(sort(x)); % all set points in the structure

    y=cell(length(x),4);

    for k=1:length(structure)
        for j=1:length(structure(k).startSS)
            if isempty(structure(k).avgSSTemp(j))==false
                ssTemp=round(structure(k).SetTempF(structure(k).startSS(j)));
                for g=1:length(x)
                    if ssTemp==x(g)
                        y{g,1}=[y{g,1},structure(k).avgSSTemp(j)]; %SS Temp COlumn 1
                        y{g,2}=[y{g,2},structure(k).avgSSgrateTemp(j)];%%SS grate Temp column 2
                        y{g,3}=[y{g,3},structure(k).avgSSRPM(j)]; %%SSRPM column 3
                        y{g,4}=[y{g,4},structure(k).avgSSPWM(j)]; %%SS PWM Temp column 2
                    end
                end
            end
        end
    end

    avg=cellfun(@mean,y);
    %%
    TempPerformanceSummary=figure("Name",'Temperature Performance Summary',"Visible",'off');
    title("Probe Temp vs Set Temp")
    plot([150,x],[150,x],'LineStyle','--','LineWidth',1,'Color','k')
    title("Probe Temp vs Set Temp",'FontWeight','bold')
    hold on;
    plot(x,avg(:,1),'DisplayName',"Average Pit Probe Temp",'Marker','*','LineStyle','none','Color','#28663f');

    hold on;
    plot(x,avg(:,2),'DisplayName','Average Effective Temp','Marker','diamond','LineStyle','none','Color','r')
    grid on;
    ylabel('Measured Temp')
    xlabel('Set Temp')
    legend Baseline Probe Effective Location northwest

    MotorPerformanceSummary=figure("Name",' Motor Performance Summary',"Visible",'off');
    plot([0:50:650], [0:50:650],'LineStyle','--','LineWidth',1,'Color','k')
    title("Motor PWM and RPM vs Set Temp",'FontWeight','bold')
    yyaxis left
    set(gca,'YColor','#282dbf')
    hold on
    plot(x,avg(:,4),'DisplayName',"Average Motor PWM",'Marker','*','LineStyle','none','Color','#282dbf')

    xlim([100 600])
    ylim([100 650])
    xlabel('Set Temp')
    ylabel('Motor PWM')

    yyaxis right
    set(gca,'YColor','r')
    ylabel('Motor RPM')
    plot(x,avg(:,3),'DisplayName','Average Motor RPM','Marker','diamond','LineStyle','none','Color','r')
    grid on
    legend Linear MotorPWM MotorRPM Location northwest

    %% PWM vs RPM
    PWMvsRPMSummary=figure("Name",' PWM vs RPM Summary',"Visible",'off');
    plot(avg(:,4),avg(:,3),'DisplayName','Average Motor RPM','Marker','*','MarkerSize',8,'LineStyle','none','Color','r')
    title('Motor RPM vs PWM')
    grid on
    hold on
    xlabel('Motor PWM')
    ylabel('Motor RPM')

    avg(arrayfun(@(x) any(isnan(x)),avg)) = [];
    x(arrayfun(@(g) any(isempty(g)),x)) = [];
    avg=reshape(avg,[],4);
    line=polyfit(avg(:,4),avg(:,3),1);
    x=linspace(0,max(avg(:,4)));
    points=polyval(line,x);
    plot(x,points,'LineStyle','--','Color','k')

    formatSpec = 'Motor RPM = %.5f*(Motor PWM) %+.4f';
    A1 = line(1);
    A2 = line(2);
    str = sprintf(formatSpec,A1,A2);
    dim = [.1325 .45 .35 .35];
    annotation('textbox',dim,'String',str,'FitBoxToText','on','BackgroundColor','w','FaceAlpha',.9);
    legend MotorRPM Linear Location northwest


    % %% PWM/RPM/Temp Table
    % avg_rounded=arrayfun(@(x) round(x,2),avg);
    % PerformanceSummary=uifigure("Name",'Performance Summary','Position',[488 342 680 490],'Visible','off');
    % t=array2table(avg_rounded,'VariableNames',["Average Pit Probe Temp" "Average Grate Temp" "Average Motor RPM" "Average Motor PWM"]);
    % if height(x)~=height(t)
    %     x=x';
    % end
    % t=addvars(t,x,'NewVariableNames',"Set Temp");
    % t=movevars(t,"Set Temp",'Before',"Average Pit Probe Temp");
    % t=uitable(PerformanceSummary,"Data",t,'ColumnWidth','fit','RowStriping','on','Position',[10 10 660 470]);
    % %t=uitable('Position',t.Parent.Position);

    %% Cooks/Duration by Grill

    for k=1:length(GDMasterStruct)
        if strcmp(GDMasterStruct(k).grillSize,"JX6")==true&&strcmp(GDMasterStruct(k).grillName,'N/A')==true
            GDMasterStruct(k).grillName='Mint';
        end
    end
      for k=1:length(GDMasterStruct)
        if strcmp(GDMasterStruct(k).grillSize,"JX4")==true&&strcmp(GDMasterStruct(k).grillName,'N/A')==true
            GDMasterStruct(k).grillName='Fennel';
        end
      end
    
%%
structure=GDMasterStruct;
%%
    x=cell(length(structure),1);
    m=1;
    for k=1:length(structure) % get all cooks
        x{m}=structure(k).grillName;
        m=m+1;
    end
    if isempty(x)==false
        x=unique(x);
        g=cell(length(x),2);
        g(:,:)={0};

        %get number of cooks and cook duration for each listed grill name
        for k=1:length(structure) % get all SPs
            for m=1:length(x)
                if strcmp(structure(k).grillName,x{m})==true
                    g{m,1}=g{m,1}+1;
                    g{m,2}=g{m,2}+structure(k).duration;
                end
            end
        end

        durations=cellfun(@(y) y/60, g(:,2)); %minutes into hours
        durations=round(durations,2);


        x=categorical(x);
        CookTotals=figure('Name','Time to Temp','WindowState','normal','Visible','on');
        g=bar(1:length(x),durations);
        title(' Total Cook Duration');
        yticks('auto');
        for k=1:length(g)
            xtips=g(k).XEndPoints;
            ytips=g(k).YEndPoints;
            labels=string(g(k).YData);
            text(xtips,ytips,labels,'HorizontalAlignment','center','VerticalAlignment','bottom')
        end
        ylabel('Hours')
        ylim([0 300])
        xlabel('Grill Name')
        set(gca,'xticklabel',x);
        grid on;
    else
        CookTotals=figure('Name','Time to Temp','WindowState','normal','Visible','off');
    end
    %% Error Code summary


    errorCodes=["E1","E2","E3","E4","E5","E6","E7","E8","E9","E10","E11","E13","E16","E17","E18","E19","E20","E21", "No Errors"];
    portion=zeros(1,length(errorCodes));

    for k=152:length(structure)
        for m=1:(length(structure(k).errorCode))
            for j=1:length(errorCodes)
                if strcmp(errorCodes(j),structure(k).errorCode(m))==true
                    portion(j)=portion(j)+1; %% if error code is documented in cook list error code occurence

                end
            end
        end
    end

    percentages=arrayfun(@(x) x./length(structure),portion);
    for k=length(percentages):-1:1
        if percentages(k)==0
            errorCodes(k)=[];
            percentages(k)=[];
        end
    end

    % CookTotals=figure('Name','Error
    % Totals','WindowState','normal','Visible','on'); p=pie(percentages,
    % '%.3g%%'); legend(errorCodes,'Location','best','Orientation','vertical')
    % %title('Error Code Totals',"FontSize",12) test=findobj(p,"type","text");
    % set(test,"FontSize",9)
    %
    % dismissable=["E9","E17","E18","E19","E20","E21"];
    % nondismissable=["E1","E2","E3","E4","E5","E6","E7","E8","E11","E13","E16"];
    % errorType=zeros(1,6); for k=1:length(structure)
    %     if numel(structure(k).errorCode)==1
    %         if ismember(structure(k).errorCode,dismissable)==true
    %             errorType(1)=errorType(1)+1; % dismissable errors continue
    %         elseif ismember(structure(k).errorCode,nondismissable)==true
    %             errorType(2)=errorType(2)+1; %non dismissable errors continue
    %         elseif strcmp(structure(k).errorCode, "No Errors")==1
    %             errorType(3)=errorType(3)+1; continue
    %         end
    %     elseif numel(structure(k).errorCode)>1
    %         if any(ismember(structure(k).errorCode,dismissable),1)==true
    %             if
    %             any(ismember(structure(k).errorCode,nondismissable),1)==true
    %                 errorType(4)=errorType(4)+1; % one dismiss and one
    %                 nondismissable
    %             else
    %                 errorType(5)=errorType(5)+1; % multiple dimissable errors
    %             end
    %         else
    %             errorType(6)=errorType(6)+1; %multiple nondismisable errors
    %         end
    %     end
    % end

    %% Error Table

    percentages=arrayfun(@(x) (x./length(structure))*100,portion);
    portion(end+1)=length(structure);

    percentages=compose('%.3g%%',percentages);
    percentages{end+1}='100%';
    errorCodes=["E1","E2","E3","E4","E5","E6","E7","E8","E9","E10","E11","E13","E16","E17","E18","E19","E20","E21", "No Errors",'Total Cooks'];
    VarNames=["Error Code","Total Cooks","Percentage","Notes"];
    notes=cell(1,length(errorCodes));
   

    %errorCodes=["E1","E2","E3","E4","E5","E6","E7","E8","E9","E10","E11","E13","E16","E17","E18","E19","E20","E21", "No Errors",'Total Cooks'];
    errorTable=table(errorCodes',portion',percentages',notes','VariableNames',VarNames);



    %% Overshoot Summary
    x=[181 200:50:500];
    g=cell(1,length(x)-1); %cell containing overshoot values

    for k=1:length(structure)
        for j=1:length(x)-1
            if isempty(structure(k).setPoint)==true
                continue
            end
            if structure(k).setPoint(1)>=x(j)&&structure(k).setPoint(1)<=x(j+1)
                if ischar(structure(k).overshoot)==true
                    continue
                end
                if structure(k).overshoot>-50
                    g{1,j}=[g{1,j}, structure(k).overshoot];
                end
            end
        end
    end

    avgOvershoot=cellfun(@mean, g);
    overshootSummary=figure('Name','Overshoot','WindowState','normal','Visible','on');
    y=categorical({'SB to 200F';'200F to 250F'; '250F to 300F';'300F to 350F';'350F to 400F'; '400F to 450F';'450F to 500F'});
    test=1:length(g);
    hold on
    noOutliers=cellfun(@rmoutliers,g,"UniformOutput",false);
    for k=1:length(test)
        if isempty(noOutliers{k})==true
            noOutliers{k}=0;
        end
    end


    arrayfun(@(i)plot(test(i),noOutliers{1,i},'o'),1:numel(test))
    set(gca,'xticklabel',y);
    xtickangle(45)
    grid on
    title('Overshoot at all Set Points')
    ylabel("Overshoot in {\circ}F")
    xlabel('Set Temperature')
    %% TTT by FW
    % FW=unique([structure.FW]);
    % remove=find(FW=="N/A");
    % FW(remove)=[];
    %
    %
    % x=[300 455];
    % g=cell(length(FW),length(x)+1); %cell containing overshoot values
    %
    %
    % for k=1:length(structure)
    %     if isnumeric(structure(k).minstotemp)==false||isnumeric(structure(k).setPoint(1))==false
    %         continue
    %     else
    %         for j=1:length(FW)
    %             if strcmp(structure(k).FW,FW(j))==true
    %                 if structure(k).setPoint(1)<=x(1)
    %                     g{j,1}=[g{j,1},structure(k).minstotemp];
    %                 elseif structure(k).setPoint(1)>x(1)&&structure(k).setPoint(1)<x(2)
    %                     g{j,2}=[g{j,2},structure(k).minstotemp];
    %                 elseif structure(k).setPoint(1)>=x(2)
    %                     g{j,3}=[g{j,3},structure(k).minstotemp];
    %                 end
    %             end
    %         end
    %     end
    % end
    %
    % TTT=cellfun(@mean,g,UniformOutput=false);
    % data=[[TTT{1,1:3}];[TTT{2,1:3}];[TTT{3,1:3}];[TTT{4,1:3}];[TTT{5,1:3}];[TTT{6,1:3}];[TTT{7,1:3}];[TTT{8,1:3}];[TTT{9,1:3}]];
    % FWTTTSummary=figure('Name','Time to Temp by FW','WindowState','normal','Visible','off');
    % g=bar(1:length(data),data);
    % set(gca,'XTickLabel',FW)
    %
    % title('Time to Temp By Firmware Version')
    % xlabel("FW Version")
    % ylabel("Minutes")
    % legend("Smoking","Roasting","Searing",'Orientation','vertical')









