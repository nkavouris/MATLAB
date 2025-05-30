%% Import data from text file
function[cookdata]=extractDatafromLuminConnect(filename)

cookdata=struct();
%% Set up the Import Options and import the data
opts = delimitedTextImportOptions("NumVariables", 9, "Encoding", "UTF-8");

% Specify range and delimiter
opts.DataLines = [2, Inf];
opts.Delimiter = ",";

% Specify column names and types
opts.VariableNames = ["time", "temp_tc", "temp_eff", "temp_target", "burner", "u", "p", "i", "d"];
opts.VariableTypes = ["double", "double", "double", "double", "double", "double", "double", "double", "double"];

% Specify file level properties
opts.ExtraColumnsRule = "ignore";
opts.EmptyLineRule = "read";
opts.ExtraColumnsRule = "ignore";
opts.EmptyLineRule = "read";
opts.ConsecutiveDelimitersRule = "join";


%opts = setvaropts(opts, emptyFields, "EmptyFieldRule", "auto");
%opts = setvaropts(opts, thousandSeperator, "ThousandsSeparator", ",");


% Import the data
tbl = readtable(filename, opts);


%% Clear temporary variables
clear opts
[~,dataName,~]=fileparts(filename);
cookdata.fileName=filename;
cookdata.dataName=string(dataName);
cookdata.dateTime = tbl.time;


cookdata.grillModel="Lumin";
cookdata.grillSize=[];
cookdata.grillVoltage=[];
cookdata.TempF=tbl.temp_tc;
cookdata.grateTemp=tbl.temp_eff;
cookdata.SetTempF=tbl.temp_target;
cookdata.burnerLevel=tbl.burner;
cookdata.P=tbl.p/1000;
cookdata.I=tbl.i/1000;
cookdata.D=tbl.d/1000;
cookdata.U=tbl.u/1000;


cookdata.TempF=((cookdata.TempF/10)*(9/5)+32);
cookdata.grateTemp=((cookdata.grateTemp/10)*(9/5)+32);
cookdata.SetTempF=((cookdata.SetTempF/10)*(9/5)+32);
end
