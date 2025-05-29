function[master]=MasterCleaner(master)

e6_flag=false;

for k=length(master):-1:2
    if master(k).overshoot<-60
        master(k)=[];
    end

  
    if length(master(k-1).errorCode)>1
        e6_flag=false;
        continue
    elseif master(k-1).errorCode=="E6"
        e6_flag=true;
    elseif master(k-1).errorCode~="E6"
        e6_flag=false;
    end
    if length(master(k).errorCode)>1
        e6_flag=false;
        continue
    elseif master(k).errorCode(1)=="E6"&& e6_flag==true
        if length(master(k).errorCode)==1        
            master(k)=[];
        end
    end




end