function [t,v] = read_value_from_time_point(timepoint, recording, recording_time)
t = zeros(1,length(timepoint));
v = zeros(1,length(timepoint));

switch nargin
    case 2
        fprintf('Sampling rate need to be 1kHz')
        recording_time = (1:length(recording))/1000;
    case 3
        
        
end
for kk = 1:length(timepoint)
    timepoint0 = timepoint(kk);
    time_from_timepoint = timepoint0 - recording_time;
    % find the index >= 0
    time_from_timepoint(time_from_timepoint<0) = [];
    index = length(time_from_timepoint);
    t0 = recording_time(index);
    v0 = recording(index);
    t(kk) = t0;
    v(kk) = v0;
end
end