function [x1_all,trigger_time_remained] = segment_with_onset_time(Voltage, timepoint, trigger_time, window)
% [x1_all,trigger_idx_remained] = segment_with_onset_time(Rawdata, trigger_time, window)
% 1. Segment Rawdata using trigger_time. Each segment contains minimum
% number of dots that fit the window
% 2. Remove osnet that could no tbe used (for example, at the very beginning or at the very end). Return remained onset

% Input:
%     Rawdata: Raw data, not segmented
%     timepont: timepoint of the voltage
%     trigger_time: time onset of each segmentation
%     window: time window of the interest

% Output:
%     x1_all: segmented data. 2D,  number of dots * number of trigger_time_remained
%     trigger_time_remained: remained onset

% Build an empty matrix for store result.
itv = timepoint(2)-timepoint(1);
Number_Dots = floor((window(2)-window(1))/itv)-1;
x1_all = zeros(Number_Dots,length(trigger_time));
trigger_time_remained = zeros(length(trigger_time),1);
for i = 1:length(trigger_time)
    index = timepoint>(trigger_time(i)+window(1)) & timepoint<(trigger_time(i)+window(2));
    if sum(index)<Number_Dots
        trigger_time_remained(i) = NaN;
        x1_all(:,i) = NaN;
    else
        trigger_time_remained(i) = 1;
        v0 = Voltage(index,:);
        x1_all(:,i) = v0(1:Number_Dots);
    end
    
end
% Remove those NAN
x1_all(:,isnan(trigger_time_remained)) = [];
trigger_time_remained(isnan(trigger_time_remained)) = [];
end