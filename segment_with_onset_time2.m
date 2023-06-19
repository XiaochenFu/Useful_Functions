function [x1_all,trigger_time_remained,x1_time] = segment_with_onset_time2(Voltage, timepoint, trigger_time, timewindow)
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
closest_max_eq = @(x,y) min(x(x>=y)); 
num_channels = size(Voltage,2);
if num_channels == 1
%     itv = timepoint(2)-timepoint(1);
    %     x1_time = timewindow(1):itv:timewindow(2);
    trigger_time0 = closest_max_eq(timepoint,trigger_time(1));
    x1_time_idx = (timepoint>=(trigger_time0+timewindow(1))) & (timepoint<(trigger_time0+timewindow(end)));
    Number_Dots =sum(x1_time_idx);
    x1_time = timepoint(x1_time_idx)-trigger_time0;
    x1_all = zeros(Number_Dots,length(trigger_time));
    trigger_time_remained = zeros(length(trigger_time),1);
    for i = 1:length(trigger_time)
        trigger_time0 = closest_max_eq(timepoint,trigger_time(i));
        index = (timepoint>=(trigger_time0+timewindow(1))) & (timepoint<(trigger_time0+timewindow(end)));
        if sum(index)<Number_Dots-2
            trigger_time_remained(i) = NaN;
            x1_all(:,i) = NaN;
        elseif sum(index)<Number_Dots
            trigger_time_remained(i) = trigger_time(i);
            idx = find(index);
            v0 = Voltage(idx:(idx+Number_Dots-1),:);
            
            x1_all(:,i) = v0(1:Number_Dots);
        else
            trigger_time_remained(i) = trigger_time(i);
            v0 = Voltage(index,:);
            x1_all(:,i) = v0(1:Number_Dots);
        end

    end
    % Remove those NAN
    x1_all(:,isnan(trigger_time_remained)) = [];
    trigger_time_remained(isnan(trigger_time_remained)) = [];

else
%  itv = timepoint(2)-timepoint(1);
%     Number_Dots = floor((timewindow(2)-timewindow(1))/itv)-1;
%     x1_all = zeros(Number_Dots,num_channels,length(trigger_time));
%     trigger_time_remained = zeros(length(trigger_time),1);
%     for i = 1:length(trigger_time)
%         index = timepoint>=(trigger_time(i)+timewindow(1)) & timepoint<=(trigger_time(i)+timewindow(2));
%         if sum(index)<Number_Dots
%             trigger_time_remained(i) = NaN;
%             x1_all(:,i) = NaN;
%         else
%             trigger_time_remained(i) = 1;
%             v0 = Voltage(index,:);
%             x1_all(:,:,i) = v0(1:Number_Dots,:);
%         end
% 
%     end
%     % Remove those NAN
%     x1_all(:,isnan(trigger_time_remained)) = [];
%     trigger_time_remained(isnan(trigger_time_remained)) = [];
end
end