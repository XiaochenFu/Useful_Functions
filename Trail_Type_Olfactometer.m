function [trail_onset,trail_type] = Trail_Type_Olfactometer(Voltage_line1, Voltage_line2, threshold_line1, threshold_line2, fs, varargin)
%


&&& not finished
Trail_Type_Olfactometer(Voltage_line1, Voltage_line2, threshold_line1, threshold_line2, fs, varargin)
% by xiaochen fu
% Convert voltage data to trail type using threshold. 
%% input
% voltage might be flacuating
% Threshold: for n types of trails, [baseline, thre 1, thre 2, ..., thre n]
% signal below baseline is defined as baseline
% signal between thre 1 and thre 2 are defined as trail type 1
% fs: sampling rate
% varargin: minimum pulse duration in second, 
%% output 
% trail_onset in second
% trail_type from 1 to n
%%
if sum(Voltage_line1<min(threshold_line1))<1
    threshold0 = threshold_line1;
    threshold_line1 = threshold_line1(threshold_line1>min(threshold_line1));
end
number_trail_type = length(threshold_line1);
t = (1:length(Voltage_line1))/fs;
trail_onset = [];
trail_offset = [];
trail_type = [];
for jj = 1:number_trail_type
    threshold_low = threshold_line1(jj);
    if jj == number_trail_type
        threshold_high = max(max(Voltage_line1))+1;
    else
        threshold_high = threshold_line1(jj+1);
    end
    voltage_copy = Voltage_line1;
    voltage_copy(Voltage_line1>threshold_high) = 0;
    voltage_copy(Voltage_line1<threshold_low) = 0;
    voltage_jj_bi = sign(voltage_copy);
    % find when data change
    voltage_jj_bi_diff = diff(voltage_jj_bi);
    voltage_jj_onset_index = find((voltage_jj_bi_diff>0));
    trail_onset_jj = t(voltage_jj_onset_index);
    trail_onset = [trail_onset,trail_onset_jj];
    voltage_jj_offset_index = find((voltage_jj_bi_diff<0));
    trail_offset_jj = t(voltage_jj_offset_index);
    trail_offset = [trail_offset,trail_offset_jj];
    trail_type_jj = ones(1, length(trail_onset_jj))*jj;
    trail_type = [trail_type,trail_type_jj];
end

if length(trail_offset)>length(trail_onset)
    trail_onset = [1 trail_onset];
end
if length(trail_offset)<length(trail_onset)
    trail_offset = [trail_offset length(Voltage_line1)];
end
 if nargin ==4
     min_pulse_duration = varargin{1};
     trail_duration_second = trail_offset-trail_onset;
     trail_onset(trail_duration_second<min_pulse_duration) = [];
     trail_type(trail_duration_second<min_pulse_duration) = [];
     % sort data according to time
     [trail_onset,I] = sort(trail_onset);
     trail_type = trail_type(I);
 end
  if nargin ==5
     min_pulse_duration = varargin{1};
     min_trail_duration = varargin{2};
     trail_duration_second = trail_offset-trail_onset;
     trail_onset(trail_duration_second<min_pulse_duration) = [];
     trail_type(trail_duration_second<min_pulse_duration) = [];
     % sort data according to time
     [trail_onset,I] = sort(trail_onset);
     trail_type = trail_type(I);
     trail_type_pulse_train = trail_type(1);
     trail_onset_pulse_train = trail_onset(1);
     last_onset_pulse_train = trail_onset(1);
     last_type_pulse_train = trail_type(1);

     for ii = 2:length(trail_type)
         current_onset_pulse_train = trail_onset(ii);
         current_onset_type_train = trail_type(ii);
         if current_onset_pulse_train - last_onset_pulse_train > min_trail_duration
             trail_type_pulse_train = [trail_type_pulse_train current_onset_type_train];
             trail_onset_pulse_train = [trail_onset_pulse_train current_onset_pulse_train];
             last_onset_pulse_train = current_onset_pulse_train;
             last_type_pulse_train = current_onset_type_train;
         end
     end
     trail_onset = trail_onset_pulse_train;
     trail_type = trail_type_pulse_train;
     if exist(threshold0)
         trail_onset = [1 trail_onset];
         trail_type = [0 trail_type];
         trail_type = trail_type+1;
     end
  end
 
  
%  % show result
%  newDefaultColors = jet(number_trail_type);
%  figure
%  plot(t, voltage)
%  hold on
%  for ii  = 1:length(trail_type)
%      color_jj = newDefaultColors(trail_type(ii),:);
%      xline(trail_onset(ii),'--','Color',color_jj);
%  end
%  xlabel('time(s)')
%  ylabel('voltage(V)')
