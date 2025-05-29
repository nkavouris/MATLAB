
function[merged_steady_state_start_indices,merged_steady_state_end_indices]=getSteadyStateBounds(cook)

temperature=cook.TempF; 


% Define parameters
min_steady_duration = 200; % Minimum number of measurements for steady state
min_delta_temperature = 0.005; % Minimum temperature change for steady state (Fahrenheit)
filter_window = 900; % Moving average filter window size
steady_tolerance = 0.02; % Tolerance for steady state (Fahrenheit)
transparency = 0.1; % Transparency of steady state regions


% Apply moving average filter to temperature data
temperature_filtered = movmean(temperature, filter_window);

% Find indices of steady state regions
steady_state_start_indices = [];
steady_state_end_indices = [];
steady_state_flag = false;
for i = 2:length(temperature_filtered)
    delta_temperature = temperature_filtered(i) - temperature_filtered(i-1);
    if abs(delta_temperature) < min_delta_temperature + steady_tolerance && ~steady_state_flag
        steady_state_start_indices(end+1) = i;
        steady_state_flag = true;
    elseif abs(delta_temperature) >= min_delta_temperature + steady_tolerance && steady_state_flag
        steady_state_end_indices(end+1) = i - 1;
        steady_state_flag = false;
    end
end
if steady_state_flag % End of steady state if data ends in steady state
    steady_state_end_indices(end+1) = length(temperature_filtered);
end

% Remove steady state regions shorter than minimum duration
short_region_indices = find(steady_state_end_indices - steady_state_start_indices < min_steady_duration);
steady_state_start_indices(short_region_indices) = [];
steady_state_end_indices(short_region_indices) = [];

% Check if dataset reaches steady state at all
if isempty(steady_state_start_indices)
    merged_steady_state_start_indices="N/A";
    merged_steady_state_end_indices="N/A";

else
    % Merge overlapping steady state regions
    merged_steady_state_start_indices = steady_state_start_indices(1);
    merged_steady_state_end_indices = steady_state_end_indices(1);
    for i = 2:length(steady_state_start_indices)
        if steady_state_start_indices(i) <= merged_steady_state_end_indices(end)
            merged_steady_state_end_indices(end) = steady_state_end_indices(i);
        else
            merged_steady_state_start_indices = [merged_steady_state_start_indices steady_state_start_indices(i)];
            merged_steady_state_end_indices = [merged_steady_state_end_indices steady_state_end_indices(i)];
        end
    end
end
    %% Plot temperature vs measurement index with steady state regions highlighted
%         SSindex=figure("Name","SS Index");
%         subplot(2,1,1)
%         plot(1:length(temperature), temperature);
%         hold on;
%         for i = 1:length(merged_steady_state_start_indices)
%             rectangle('Position', [merged_steady_state_start_indices(i), min(temperature)-5, merged_steady_state_end_indices(i)-merged_steady_state_start_indices(i), max(temperature)-min(temperature)+10], 'FaceColor', [0.8, 0.8, 0.8], ...
%                 'EdgeColor', 'none');
%         end
%         xlabel('Measurement Index');
%         ylabel('Temperature (C)');
%         title('Temperature vs Measurement Index with Steady State Regions Highlighted');
%     subplot(2,1,2)
%     plot(1:length(temperature), temperature);
% 
%     xlabel('Measurement Index');
%     ylabel('Temperature (F)');
    