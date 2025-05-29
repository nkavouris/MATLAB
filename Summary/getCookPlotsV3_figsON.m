function [Grill_Status,Component_Performance,PID_Performance,GP_Performance,FuelLevel,Temp_Performance]=getCookPlotsV3_figsON(cookdata)
[~,~,ext]=fileparts(cookdata.fileName);
if cookdata.grillModel=="JX6"||cookdata.grillModel=="JX4"||cookdata.grillModel=="Journey"||cookdata.grillModel=="GreenDay"
    switch lower(ext)
        case '.csv'
            Component_Performance=figure('Name','Component Performance','WindowState','normal','Visible','on');
            grid on;
            xlabel('Time (s)');
            yyaxis left;
            if isfield(cookdata,'grateTemp')==false
                b=20;
                a=0.1;
                for j=1:length(cookdata.TempF)
                    cookdata.grateTemp(j)=(cookdata.TempF(j)+b)/(1-a);
                end
                for j=1:length(cookdata.TempF)
                    cookdata.grateTemp(j)=(cookdata.TempF(j)+b)/(1-a);
                end
            end
            plot(cookdata.TempF,'Color','r','LineWidth',1,"DisplayName","Probe Temp F");
            hold on;
            plot(cookdata.grateTemp,'Color','k','LineWidth',1,'LineStyle','--',"DisplayName","Grate Temp F");
            plot(cookdata.SetTempF,'Color','g','DisplayName','Set Temp F','LineWidth',1,'LineStyle','-')
            ylim([0 max(cookdata.grateTemp)+50])

            yticks('auto');

            title('Component Performance',string(cookdata.dataName))
            ylabel('Temperature (F)',Color="r");
            set(gca,'YColor','r');
            yyaxis right;
            yticks('auto');
            ylim([0 max(cookdata.AugerPWM./100)+0.5])
            ylabel('PWM/100 || RPM','Color','#FAA533');
            set(gca,'YColor','#FAA533')
            plot(cookdata.AugerPWM./100,'LineStyle','-','Color','#FAA533',"DisplayName","Auger PWM");
            plot(cookdata.AugerRPM./1000,'LineStyle','-','Color','#21ABDE',"DisplayName","Auger RPM");
            plot(cookdata.FanPWM./100,'LineStyle','-','Color','#94918D',"DisplayName","Fan PWM");
            legend('Location','southoutside');
            %% Temp Performance
            Temp_Performance=figure('Name','Temp Performance','WindowState','normal','Visible','on');
            grid on;
            xlabel('Time (s)');
            if isfield(cookdata,'grateTemp')==false
                b=20;
                a=0.1;
                for j=1:length(cookdata.TempF)
                    cookdata.grateTemp(j)=(cookdata.TempF(j)+b)/(1-a);
                end
            end
            plot(cookdata.TempF,'Color','r','LineWidth',1,"DisplayName","Probe Temp F");
            hold on;
            plot(cookdata.grateTemp,'Color','r','LineWidth',1,'LineStyle','--',"DisplayName","Grate Temp F");
            plot(cookdata.SetTempF,'Color','g','DisplayName','Set Temp F','LineWidth',1,'LineStyle','-')
            if isfield(cookdata,"displayTemp")==true
                if isempty(cookdata.displayTemp)==false
                    plot(cookdata.displayTemp,'Color','b','DisplayName','Display Temp F','LineWidth',1,'LineStyle','-')
                end
            end
            %ylim([0 max(cookdata.grateTemp)+50])
            yticks('auto');
            title('Temperature Performance',string(cookdata.dataName))
            ylabel('Temperature (F)');
            grid on
            %         set(gca,'YColor','r');
            %         yyaxis right;
            %         yticks('auto');
            %         ylim([0 max(cookdata.AugerPWM./100)+0.5])
            %         ylabel('PWM/100 || RPM','Color','#FAA533');
            %         set(gca,'YColor','#FAA533')
            %         plot(cookdata.AugerPWM./100,'LineStyle','-','Color','#FAA533',"DisplayName","Auger PWM");
            %         plot(cookdata.AugerRPM./1000,'LineStyle','-','Color','#21ABDE',"DisplayName","Auger RPM");
            %         plot(cookdata.FanPWM./100,'LineStyle','-','Color','#94918D',"DisplayName","Fan PWM");
            legend('Location','southoutside');
            %% GP Peformance
            GP_Performance=figure('Name','GlowPlug Performance','WindowState','normal','Visible','on');
            grid on;
            xlabel('Time (s)');
            yyaxis left;
            hold on;
            plot(cookdata.TempF,'Color','r','LineWidth',1,"DisplayName","Probe Temp F");
            hold on;
            plot(cookdata.SetTempF,'Color','g','DisplayName','Set Temp F','LineWidth',1,'LineStyle','-')

            yticks('auto');

            title('Glowplug Performance',string(cookdata.dataName))
            ylabel('Temperature (F)',Color="r");
            set(gca,'YColor','r');
            yyaxis right;
            yticks('auto');
            ylim([0 max(cookdata.GPVoltage)+0.1])
            ylabel('GP mV','Color','#FAA533');
            set(gca,'YColor','#FAA533')
            plot(cookdata.GPVoltage,'LineStyle','-','Color','#FAA533',"DisplayName","GlowPlug mV");
            plot(cookdata.GPstatus,'LineStyle','-','Color','#0eb05f',"DisplayName","GlowPlug Status")
            legend('Location','southoutside');
            %% Grill Status
            Grill_Status=figure('Name','Grill Status','WindowState','minimized','Visible','off');
            grid on;
            title('Grill Status',string(cookdata.dataName))

            plot(cookdata.grillState,'DisplayName','Grill State','Color','#D95319');
            hold on;
            plot(cookdata.GPstatus,'DisplayName','Glowplug Status','LineStyle','--','Color','#77AC30');
            xlabel('Time (s)');
            yticks(0:1:5)
            legend('Location','southoutside','Orientation','horizontal')
            %% PID Performance
            PID_Performance=figure('Name','PID Performance','WindowState','normal','Visible','off');
            title('PID Performance',string(cookdata.dataName))
            hold on;
            yyaxis left
            ylim([-2 2])
            xlabel('Time (s)');
            ylabel('PID Value');
            yticks('auto');
            plot(cookdata.P,'DisplayName','P','Color', [.13 .13 .13],'LineStyle','-');
            plot(cookdata.I,'DisplayName','I','Color',[0.9290 0.6940 0.1250],'LineStyle','-');
            plot(cookdata.D,'DisplayName','D','Color',[0 0.4480 0.7410],'LineStyle','-');
            plot(cookdata.U,'DisplayName','U','Color','r','LineStyle','-');
            yyaxis right;
            plot(cookdata.TempF,'DisplayName','Temp F','Color','#E0932C','LineWidth',1);
            plot(cookdata.grateTemp,'Color','r','LineWidth',1,'LineStyle','--',"DisplayName","Grate Temp F");
            plot(cookdata.SetTempF,'Color','g','DisplayName','Set Temp F','LineWidth',1,'LineStyle','-')
            ylabel('Temperature (F)');
            grid on;
            legend('Location','southoutside','Orientation', 'vertical');
            hold off;
            %% Fuel Level

            FuelLevel=figure('Name','Fuel Level','WindowState','normal','Visible','off');
            title('Fuel Level',string(cookdata.dataName))
            grid on;
            xlabel('Time (s)');
            yyaxis left;
            if isfield(cookdata,'FuelLevel')==true
                plot(cookdata.FuelLevel,'Color','r','LineWidth',1,"DisplayName","Fuel Level");
            end
            hold on;
            yyaxis right;
            if isfield(cookdata,'FuelDistance')==true
            plot(cookdata.FuelDistance,'Color','k','LineWidth',1,"DisplayName","FuelDistance");
            end
            yticks('auto');
            legend('Location','southoutside','Orientation', 'vertical');

        case '.txt'
            Component_Performance=figure('Name','Component Performance','WindowState','normal','Visible','off');
            grid on;
            xlabel('Time (s)');
            yyaxis right;
            plot(cookdata.TempF,'Color','#E0932C','LineWidth',1,"DisplayName","Probe Temp F");
            hold on;
            ylabel('Temperature (F)')
            yyaxis left;
            yticks(0:50:max(cookdata.AugerRPM.*100));
            ylabel('PWM/RPM');
            plot(cookdata.AugerPWM./10,'LineStyle','-','Color','#FAA533',"DisplayName","Auger PWM");
            plot(cookdata.AugerRPM.*100,'LineStyle','-','Color','#21ABDE',"DisplayName","Auger RPM");
            plot(cookdata.FanPWM,'LineStyle','-','Color','#94918D',"DisplayName","Fan PWM");
            legend('Location','southoutside','Orientation','horizontal')
        otherwise
            error('Unexpected File Type')
    end
    %%
elseif cookdata.grillModel=="SmartValve"
    %%
    Component_Performance=figure('Name','Burner Performance','WindowState','normal','Visible','on');
    ylabel("Burner Level")
    yyaxis left;
    title("Burner Performance")
    grid on
    % ylim([0 13]);
    yticks([1:13]);
    plot(cookdata.Burner1Level,DisplayName="Burner 1",Color='k');
    hold on;
    plot(cookdata.Burner2Level,DisplayName="Burner 2",Color='#dbac02');
    % plot(cookdata.Burner3Level,DisplayName="Burner 3",Color='#0923e8');
    % plot(cookdata.Burner4Level,DisplayName="Burner 4",Color='#a69799');
    plot(cookdata.Burner5Level,DisplayName="Burner 5",Color='b');
    plot(cookdata.BurnerIRLevel,'Color','#a836cf','LineWidth',1,"DisplayName","IR Burner")
    yyaxis right;
    ylim padded
    ylabel(["Temp "+char(176)+"F"]); %#ok<*NBRAK>
    plot(cookdata.SetTempF,DisplayName="Set Temp",Color='g');
    plot(cookdata.TempF,DisplayName="Probe Temp",Color='r',LineStyle='-');
    legend('Location','southoutside','Orientation','horizontal');

    Temp_Performance=figure('Name','Temp Performance','WindowState','normal','Visible','on');
    grid on;
    xlabel('Time (s)');
    plot(cookdata.TempF,'Color','r','LineWidth',1,"DisplayName","Probe Temp F");
    hold on;
    plot(cookdata.grateTemp,'Color','r','LineWidth',1,'LineStyle','--',"DisplayName","Grate Temp F");
    plot(cookdata.SetTempF,'Color','g','DisplayName','Set Temp F','LineWidth',1,'LineStyle','-')
    if isfield(cookdata,"displayTemp")==true
        if isempty(cookdata.displayTemp)==false
            plot(cookdata.displayTemp,'Color','b','DisplayName','Display Temp F','LineWidth',1,'LineStyle','-')
        end
    end
    ylim padded
    yticks('auto');
    title('Temperature Performance',string(cookdata.dataName))
    ylabel('Temperature (F)');
    legend location southoutside
    grid on
%%
burner1=[cookdata.Burner1Status];
burner1(burner1==1)=1;
burner2=[cookdata.Burner2Status];
burner2(burner2==1)=2;
burner3=[cookdata.Burner3Status];
burner3(burner3==1)=3;
burner4=[cookdata.Burner4Status];
burner4(burner4==1)=4;
burner5=[cookdata.Burner5Status];
burner5(burner5==1)=5;
IRBurner=[cookdata.BurnerIRStatus];
IRBurner(IRBurner==1)=6;
    Grill_Status=figure('Name','Grill Status','WindowState','normal','Visible','on');
    grid on;
    title('Grill Status',string(cookdata.dataName))
    plot(burner1,'DisplayName','Burner 1','Color','#D95319');
    hold on;
    plot(burner2,'DisplayName','Burner 2','LineStyle','--','Color','#77AC30');
    plot(burner3,'DisplayName','Burner 3','LineStyle','-','Color','r');
    plot(burner4,'DisplayName','Burner 4','LineStyle','-.','Color','g');
    plot(burner5,'DisplayName','Burner 5','LineStyle',':','Color','k');
    plot(IRBurner,'DisplayName','IR Burner','LineStyle',':','Color','b');
    xlabel('Time (s)');
    yticks(0:1:7)
    ylim padded
    ylabel("Burner Status")
    legend('Location','southoutside','Orientation','horizontal')
    GP_Performance=false;
    FuelLevel=false;
    PID_Performance=false;
elseif cookdata.grillModel=="Lumin"
    Component_Performance=figure('Name','Heater Performance','WindowState','normal','Visible','on');
    title("Burner Performance",cookdata.dataName)
    yyaxis left;
    if isfield(cookdata,"SetTempF")==true
    plot(cookdata.SetTempF,DisplayName="Set Temp",Color='g');
    end
    hold on
    plot(cookdata.TempF,DisplayName="Probe Temp",Color='r',LineStyle='-');
    plot(cookdata.grateTemp,DisplayName="Grate Temp",Color='r',LineStyle='--');
    ylabel(["Temp "+char(176)+"F"]); %#ok<*NBRAK>
    ylim padded

    yyaxis right;
    grid on
  shortingrelay=cookdata.ShortingRelay.*50;
  plot(shortingrelay,DisplayName="Shorting Relay Status",Color='#0eb05f')

    plot(cookdata.burnerLevel,DisplayName="Heater Level",Color='k');
    hold on;
    ylabel("Heater Level")

    legend('Location','southoutside','Orientation','horizontal');

    %%
    PID_Performance=figure('Name','PID Performance','WindowState','normal','Visible','on');
    title('PID Performance',string(cookdata.dataName))
    hold on;
    yyaxis left
    ylim([-2 2])
    xlabel('Time (s)');
    ylabel('PID Value');
    yticks('auto');
    plot(cookdata.P,'DisplayName','P','Color', [.13 .13 .13],'LineStyle','-');
    plot(cookdata.I,'DisplayName','I','Color','#db34eb','LineStyle','-');
    plot(cookdata.D,'DisplayName','D','Color',[0 0.4480 0.7410],'LineStyle','-');
    plot(cookdata.U,'DisplayName','U','Color','r','LineStyle','-');
    yyaxis right;
    plot(cookdata.TempF,'DisplayName','Temp F','Color','#E0932C','LineWidth',1);
if isfield(cookdata,"setTempF")==true
    plot(cookdata.SetTempF,'Color','g','DisplayName','Set Temp F','LineWidth',1,'LineStyle','-')
end
    ylabel('Temperature (F)');
    grid on;
    legend('Location','southoutside','Orientation', 'vertical');
    hold off;
    %% Lumin Temp Performance
    Temp_Performance=figure('Name','Temp Performance','WindowState','normal','Visible','on');
    grid on;
    xlabel('Time (s)');
    if isfield(cookdata,'grateTemp')==false
        b=20;
        a=0.1;
        for j=1:length(cookdata.TempF)
            cookdata.grateTemp(j)=(cookdata.TempF(j)+b)/(1-a);
        end
    end
    plot(cookdata.TempF,'Color','r','LineWidth',1,"DisplayName","Probe Temp F");
    hold on;
    plot(cookdata.grateTemp,'Color','r','LineWidth',1,'LineStyle','--',"DisplayName","Grate Temp F");

    if isfield(cookdata,"setTempF")==true
    plot(cookdata.SetTempF,'Color','g','DisplayName','Set Temp F','LineWidth',1,'LineStyle','-')
    end
    if isfield(cookdata,"displayTemp")==true
        if isempty(cookdata.displayTemp)==false
            plot(cookdata.displayTemp,'Color','b','DisplayName','Display Temp F','LineWidth',1,'LineStyle','-')
        end
    end
    %ylim([0 max(cookdata.grateTemp)+50])
    yticks('auto');
    title('Temperature Performance',string(cookdata.dataName))
    ylabel('Temperature (F)');
    grid on
    %         set(gca,'YColor','r');
    %         yyaxis right;
    %         yticks('auto');
    %         ylim([0 max(cookdata.AugerPWM./100)+0.5])
    %         ylabel('PWM/100 || RPM','Color','#FAA533');
    %         set(gca,'YColor','#FAA533')
    %         plot(cookdata.AugerPWM./100,'LineStyle','-','Color','#FAA533',"DisplayName","Auger PWM");
    %         plot(cookdata.AugerRPM./1000,'LineStyle','-','Color','#21ABDE',"DisplayName","Auger RPM");
            %         plot(cookdata.FanPWM./100,'LineStyle','-','Color','#94918D',"DisplayName","Fan PWM");
            legend('Location','southoutside');
            %%
    Grill_Status=false;
    GP_Performance=false;
    FuelLevel=false;

end

