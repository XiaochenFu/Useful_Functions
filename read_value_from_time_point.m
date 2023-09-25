function [t,v] = read_value_from_time_point(timepoint, recording, recording_time)
% read_value_from_time_point: Extracts values from a recording at specified time points.
%
% INPUT:
% timepoint: An array of time points from which values need to be extracted.
% recording: The recording signal from which values will be extracted.
% recording_time (optional): Time array corresponding to the recording.
%                            If not provided, it is assumed to be sampled at 1kHz.
%
% OUTPUT:
% t: Extracted time points from recording_time which are closest to the given timepoint.
% v: Values from recording corresponding to the extracted time points.

% Check the number of input arguments
if nargin < 2 || nargin > 3
    error('Invalid number of input arguments. Provide 2 or 3 inputs.');
end

% If recording_time is not provided, assume a sampling rate of 1kHz.
if nargin == 2
    fprintf('Sampling rate is assumed to be 1kHz\n');
    recording_time = (1:length(recording))/1000;
end

% Initialize the output arrays
t = zeros(1, length(timepoint));
v = zeros(1, length(timepoint));

% Loop through each specified time point
for kk = 1:length(timepoint)
    % Find the index of the closest value in recording_time to timepoint(kk)
    [~, index] = min(abs(recording_time - timepoint(kk)));

    t(kk) = recording_time(index);
    v(kk) = recording(index);
end
end


% function [t,v] = read_value_from_time_point(timepoint, recording, recording_time)
% t = zeros(1,length(timepoint));
% v = zeros(1,length(timepoint));
%
% switch nargin
%     case 2
%         fprintf('Sampling rate need to be 1kHz')
%         recording_time = (1:length(recording))/1000;
%     case 3
%
%
% end
% for kk = 1:length(timepoint)
%     timepoint0 = timepoint(kk);
%     time_from_timepoint = timepoint0 - recording_time;
%     % find the index >= 0
%     time_from_timepoint(time_from_timepoint<0) = [];
%     index = length(time_from_timepoint);
%     t0 = recording_time(index);
%     v0 = recording(index);
%     t(kk) = t0;
%     v(kk) = v0;
% end
% end