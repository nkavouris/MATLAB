
addpath("R:\Nick Kavouris\MATLAB\INPUT")
addpath("R:\Nick Kavouris\MATLAB\ANALYSIS")
addpath('R:\PELLET GRILL PROGRAM 2023\JOURNEY\MATLAB analysis\')% add all folders to path
addpath("R:\MATLAB\MASTER DATA")

%% get files
[file,path]=uigetfile({'*.csv';'*.txt'},"MultiSelect","on");

%% choose grill model
%selectGrillProperties();
%% Create Cookdata struct// get build and grill model
cookdata=struct();

cookdata.grillModel='GreenDay';
cookdata.buildVersion='EVT';

%% one or multiple files extract and analyze
switch cookdata.grillModel
    case {'Journey','GreenDay'} 
        switch class(file)
            case 'cell' % multiple files
                for k=1:length(file)
                    filename=fullfile(path,file{1,k});
                    [~,dataName,~]=fileparts(filename);
                    [cookdata]=extractDataFromCSVv5(filename,cookdata);
                    [cook,cookdata]=analysisV3(cookdata);
                    %% append and move file to archive, do Not Append repeats
                    repeat=false;
                    for j=1:length(MasterStruct)
                        if strcmp(MasterStruct(j).dataName,cookdata.dataName)==1
                            repeat=true;
                            break
                        end
                    end
                    if repeat==false
                        MasterStruct=[MasterStruct, cook];
                        %MasterDataStruct=[MasterDataStruct, cookdata];
                        movefile(filename,fullfile('R:','PELLET GRILL PROGRAM 2023','JOURNEY','MATLAB analysis','4. Archive'));
                    end
                end
            case 'char' % one file
                %% extract and perform analysis
                filename=fullfile(path,file);
                [cookdata]=extractDataFromCSVv5(filename);
                [cook,cookdata]=analysisV3(cookdata);
                %% append and move file
                repeat=false;
                for j=1:length(MasterStruct)
                    if strcmp(MasterStruct(j).dataName,cookdata.dataName)==1
                        repeat=true;
                        break
                    end
                end
                if repeat==false
                    MasterStruct=[MasterStruct, cook];
                    %MasterDataStruct=[MasterDataStruct, cookdata];
                    movefile(filename,fullfile('R:','PELLET GRILL PROGRAM 2023','JOURNEY','MATLAB analysis','4. Archive'));
                end
            otherwise
                error('Unexpected file extension')
        end
        %% SV
    case 'SmartValve'
        switch class(file)
            case 'cell' % multiple files
                for k=1:length(file)
                    filename=fullfile(path,file{1,k});
                    [~,dataName,~]=fileparts(filename);
                    [cookdata]=extractDatafromSmartValve(filename,cookdata);

                    %% append and move file to archive, do Not Append repeats
                    repeat=false;
                    for j=1:length(MasterStruct)
                        if strcmp(MasterStruct(j).dataName,cookdata.dataName)==1
                            repeat=true;
                            break
                        end
                    end
                    if repeat==false
                        MasterStruct=[MasterStruct, cook];
                        %MasterDataStruct=[MasterDataStruct, cookdata];
                        movefile(filename,fullfile('R:','PELLET GRILL PROGRAM 2023','JOURNEY','MATLAB analysis','4. Archive'));
                    end
                end
            case 'char' % one file
                %% extract and perform analysis
                filename=fullfile(path,file);
                [cookdata]=extractDatafromSmartValve(filename,cookdata);

                %% append and move file
                repeat=false;
                for j=1:length(MasterStruct)
                    if strcmp(MasterStruct(j).dataName,cookdata.dataName)==1
                        repeat=true;
                        break
                    end
                end
                if repeat==false
                    MasterStruct=[MasterStruct, cook];
                    %MasterDataStruct=[MasterStruct, cookdata];
                    %movefile(filename,fullfile('R:','PELLET GRILL PROGRAM 2023','JOURNEY','MATLAB analysis','4. Archive'));
                end
        end
    
            otherwise
                error('Unexpected file extension')
end

%% Save Master
%saveMaster(MasterStruct,MasterDataStruct,cookdata)


% save("R:\PELLET GRILL PROGRAM 2023\JOURNEY\MATLAB analysis\Master Data (dont touch)\DVTMasterDataStruct.mat",'MasterDataStruct','-v7.3')
 save("R:\PELLET GRILL PROGRAM 2023\JOURNEY\MATLAB analysis\Master Data (dont touch)\MasterStruct.mat",'MasterStruct','-v7.3')

 %% Summary Figures 
% [TimetoTemp,TimetoSteady,bySizeSummary,byTempSummary,byAmbientSummary,MasterTable,byFWSummary,byMeanTempSummary,TempPerformanceSummary,MotorPerformanceSummary,CookTotals,PWMvsRPMSummary,errorTable,overshootSummary]=getSummaryFigures(MasterStruct);
% 
% summaryFile="R:\PELLET GRILL PROGRAM 2023\JOURNEY\MATLAB analysis\3. Summary\PVT Summary.xlsx";
% writetable(bySizeSummary,summaryFile);
% errorFile="R:\PELLET GRILL PROGRAM 2023\JOURNEY\MATLAB analysis\3. Summary\PVT Error Summary.xlsx";
% writetable(errorTable,errorFile)
% MasterFile="R:\PELLET GRILL PROGRAM 2023\JOURNEY\MATLAB analysis\3. Summary\PVT Master Log.xlsx";
% 
% 
%% Save Figures
% saveas(TimetoTemp,"R:\PELLET GRILL PROGRAM 2023\JOURNEY\MATLAB analysis\3. Summary\PVT Summary Time to Temp","png");
% saveas(TimetoSteady,"R:\PELLET GRILL PROGRAM 2023\JOURNEY\MATLAB analysis\3. Summary\PVT Summary Time to Steady","png");
% saveas(byTempSummary,"R:\PELLET GRILL PROGRAM 2023\JOURNEY\MATLAB analysis\3. Summary\PVT Summary by Set Temp","png");
% saveas(byAmbientSummary,"R:\PELLET GRILL PROGRAM 2023\JOURNEY\MATLAB analysis\3. Summary\PVT Summary by Ambient Temp","png");
% saveas(TempPerformanceSummary,"R:\PELLET GRILL PROGRAM 2023\JOURNEY\MATLAB analysis\3. Summary\PVT Summary Temp Performance","png");
% saveas(MotorPerformanceSummary,"R:\PELLET GRILL PROGRAM 2023\JOURNEY\MATLAB analysis\3. Summary\PVT Summary Motor Performance","png");
% saveas(CookTotals,"R:\PELLET GRILL PROGRAM 2023\JOURNEY\MATLAB analysis\3. Summary\PVT Summary Cook Duration by Grill","png");
% saveas(PWMvsRPMSummary,"R:\PELLET GRILL PROGRAM 2023\JOURNEY\MATLAB analysis\3. Summary\PVT Summary PWM vs RPM","png");
% saveas(overshootSummary,"R:\PELLET GRILL PROGRAM 2023\JOURNEY\MATLAB analysis\3. Summary\PVT Summary Overshoot","png");
% writetable(MasterTable,MasterFile)
%%
