function[cook]=getDuration(cook) %% must have clean data input, equal number of starts and stops

for k=1:numel(cook)

    cook(k).duration=((cook(k).stop-cook(k).start))/60;    % make cook duration number of elements(1 element/s) between start and stop // add 15 minutes for shutdown

end