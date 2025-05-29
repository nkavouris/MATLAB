
function[cook]=getCookDetails(cook,cookdata)
FWnames={'J1000','J1001','J1002','J1003','J1004','J1005','04087','04076','J1007','J1008','EVT64','EVT63',"EVT64","EVT65","EVT66","EVT7","EVT81",'EVT82','Gimlet1','Gimlet2', ...
    'Gimlet3','Gimlet Test3','Gimlet4','Gimlet5','Gimlet6',"Gimlet 5 Test2","Canary0","Canary1", ...
    "Canary Test0","CanaryTest0","CanaryTest1","PreOOB1","PreOOB2","Alpha3","PreOOB3",...
    "RC2","RC3","RC4","RC5","RC6","RC7","RC8","RC9","RC10","RC12","RC13","RC15","MAD4","MAD5","MAD15","MAD14","MAD12","MAD11","MADalpha11",...
    "MADalpha12","MADalpha13","MADRC2","MADalpha17","RC7"};
grillNames={'Eagle','Emu','Hawk','Kiwi','Ostrich','Parrot','Penguin','Sparrow',"Pear",...
    "Carrot","Lettuce","Onion","Cabbage","Apple","Peach","Banana","PawPaw","Romanesco",...
    "Dragonfruit","Mango",'Puma','Lion','Tiger','Monkey','Ape','Jaguar','Lemur','Gorilla','Orangutan','SnowLeopard','Guina'...
    'Thanos','Joker','Bane','Sauron','Plankton','Shrek','Hulk','Superman','Batman','Thor','Idaho','Norway','Maryland','Ohio','Texas','Cuba','Peru'}; % must all be character or string array


    for m=1:length(FWnames)
        if contains(cookdata.dataName, FWnames{m},'IgnoreCase',true)==true
            cookdata.FW=string(FWnames{m}); % grill FW
            break
        else
            cookdata.FW='N/A';
        end
    end

    for m=1:length(grillNames)
        if contains(cookdata.dataName, grillNames{m},'IgnoreCase',true)==true
            cookdata.grillName=grillNames{m}; %grill name
            break
        else
            cookdata.grillName='N/A';
        end
    end

    if cookdata.FW=="Alpha12"
        if contains(cookdata.dataName,"Alpha125")==true
            cookdata.FW="Alpha12.5";
        elseif contains(cookdata.dataName,"Alpha123")==true
            cookdata.FW="Alpha12.3";
        elseif contains(cookdata.dataName,"Alpha126")==true
            cookdata.FW="RC1";
        elseif contains(cookdata.dataName,"Alpha124")==true
            cookdata.FW="Alpha12.4";
        elseif contains(cookdata.dataName,"newstartup")==true
            cookdata.FW="Alpha12 New Startup";
        end
    end

for k=1:length(cook)
    cook(k).FW=cookdata.FW;
    cook(k).grillName=cookdata.grillName;
    cook(k).grillModel=cookdata.grillModel;
    cook(k).date=cookdata.date;
    cook(k).grillSize=cookdata.grillSize;
end