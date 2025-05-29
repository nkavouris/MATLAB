
addpath("R:\Nick Kavouris\MATLAB\INPUT")
addpath("R:\Nick Kavouris\MATLAB\ANALYSIS")
addpath('R:\PELLET GRILL PROGRAM 2023\JOURNEY\MATLAB analysis\')% add all folders to path


%% get files
[file,path]=uigetfile({'*.csv';'*.txt'},"MultiSelect","on");

%% choose grill model
cookdata=struct();
%%
if exist("LuminMasterStruct","var")==false
    load("R:\PELLET GRILL PROGRAM 2023\JOURNEY\MATLAB analysis\Master Data (dont touch)\GDMasterStruct.mat","LuminMasterStruct")
end
%%
if exist("LuminMasterStruct","var")==false
    load("R:\PELLET GRILL PROGRAM 2023\JOURNEY\MATLAB analysis\Master Data (dont touch)\GDEVTMasterDataStruct.mat","LuminMasterDataStruct")
end


cookdata.grillModel="Lumin";
%% one or multiple files extract and analyze
switch cookdata.grillModel
    case {"Lumin"}
        switch class(file)
            case 'cell' % multiple files
                for k=1:length(file)
                    cookdata=struct();
                    cookdata.grillModel="Lumin";
                    filename=fullfile(path,file{1,k});
                    [~,dataName,~]=fileparts(filename);
                    [cookdata]=extractDataFromCSVv5(filename,cookdata);
                    [cook,cookdata]=analysisLuminV1(cookdata);
                    %% append and move file to archive, do Not Append repeats
                    repeat=false;
                    for j=1:length(LuminMasterStruct)
                        if strcmp(LuminMasterStruct(j).dataName,cookdata.dataName)==1
                            repeat=true;
                            break
                        end
                    end
                    if repeat==false
                        diff=setdiff(fieldnames(LuminMasterStruct),fieldnames(cookdata));
                        for m=1:length(diff)
                            cookdata.(diff{m})=[];
                        end
                        diff=setdiff(fieldnames(cookdata),fieldnames(LuminMasterStruct));
                        for m=1:length(diff)
                            LuminMasterStruct(1).(diff{m})=[];
                        end
                        LuminMasterStruct=[LuminMasterStruct, cook];
                        LuminMasterDataStruct=[LuminMasterDataStruct, cookdata];
                        movefile(filename,fullfile('R:','PELLET GRILL PROGRAM 2023','JOURNEY','MATLAB analysis','4. Archive'));
                    end
                    clear cook
                    clear cookdata
                end
            case 'char' % one file
                %% extract and perform analysis
                filename=fullfile(path,file);
                [cookdata]=extractDataFromCSVv5(filename,cookdata);
                [cook,cookdata]=analysisLuminV1(cookdata);
                %% append and move file
                repeat=false;
                for j=1:length(LuminMasterStruct)
                    if strcmp(LuminMasterStruct(j).dataName,cookdata.dataName)==1
                        repeat=true;
                        break
                    end
                end
                if repeat==false
                    diff=setdiff(fieldnames(LuminMasterStruct),fieldnames(cookdata));
                    for m=1:length(diff)
                        cookdata.(diff{m})=[];
                    end
                    diff=setdiff(fieldnames(cookdata),fieldnames(LuminMasterStruct));
                    for m=1:length(diff)
                        LuminMasterStruct(1).(diff{m})=[];
                    end
                    LuminMasterStruct=[LuminMasterStruct, cook];
                    LuminMasterDataStruct=[LuminMasterDataStruct, cookdata];
                    movefile(filename,fullfile('R:','PELLET GRILL PROGRAM 2023','JOURNEY','MATLAB analysis','4. Archive'));
                end
                clear cook
                clear cookdata
            otherwise
                error('Unexpected file extension')
        end
end
%% Save Master
%saveMaster(MasterStruct,MasterDataStruct,cookdata)


save("R:\PELLET GRILL PROGRAM 2023\JOURNEY\MATLAB analysis\Master Data (dont touch)\LuminMasterDataStruct.mat",'LuminMasterDataStruct','-v7.3')
save("R:\PELLET GRILL PROGRAM 2023\JOURNEY\MATLAB analysis\Master Data (dont touch)\LuminMasterStruct.mat",'LuminMasterStruct','-v7.3')


