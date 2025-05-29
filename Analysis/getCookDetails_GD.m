
function[cook]=getCookDetails_GD(cook,cookdata)
FWnames={'Alpha21','Alpha22,','Alpha20','Alpha19','Alpha47','7770','7755','7735','7742','main.1','Alpha56a','Alpha58','7814','7825','7873','Alpha62','7862'};
grillNames={'Toad','Ariel','Aurora','Desdemona','Cindy','Otto','Stuart','LadyMacbeth','Peach','Toadette','Daisy','Toad','Sage','Salt','Pepper','Hawk','Kiwi','Ostrich','Parrot','Penguin','Sparrow',"Pear",...
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
if contains(cookdata.dataName,"X6","IgnoreCase",true)==true
    cookdata.grillSize="JX6";
    
elseif contains(cookdata.dataName,"X4","IgnoreCase",true)==true 
    cookdata.grillSize="JX4";
else 
    cookdata.grillSize="JX4";
   
end

for k=1:length(cook)
    cook(k).FW=cookdata.FW;
    cook(k).grillName=cookdata.grillName;
    cook(k).grillModel=cookdata.grillModel;
    cook(k).date=cookdata.date;
    cook(k).grillSize=cookdata.grillSize;
    cook(k).date_time=datetime(cookdata.date,'InputFormat','dd-MMM-uuuu');
end