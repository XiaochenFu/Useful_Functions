function [trial_onset,trial_type] = Trail_Type_From_voltage(voltage, threshold, fs, varargin)
% [trial_onset,trial_type] = Trail_Type_From_voltage(voltage, threshold)
% by xiaochen fu
% Convert voltage data to trial type using threshold. 
%% input
% voltage might be flacuating
% Threshold: for n types of trials, [baseline, thre 1, thre 2, ..., thre n]
% signal below baseline is defined as baseline
% signal between thre 1 and thre 2 are defined as trial type 1
% fs: sampling rate
% varargin: minimum pulse duration in second
%% output 
% trial_onset in second
% trial_type from 1 to n
%%
if sum(voltage<min(threshold))<1
    threshold0 = threshold;
    threshold = threshold(threshold>min(threshold));
end
number_trial_type = length(threshold);
t = (1:length(voltage))/fs;
trial_onset = [];
trial_offset = [];
trial_type = [];
for jj = 1:number_trial_type
    threshold_low = threshold(jj);
    if jj == number_trial_type
        threshold_high = max(max(voltage))+1;
    else
        threshold_high = threshold(jj+1);
    end
    voltage_copy = voltage;
    % ignore the other parts
    voltage_copy(voltage>threshold_high) = 0;
    voltage_copy(voltage<threshold_low) = 0;
    voltage_jj_bi = sign(voltage_copy);
    % find when data change
    voltage_jj_bi_diff = diff(voltage_jj_bi);
    voltage_jj_onset_index = (voltage_jj_bi_diff>0);
    trial_onset_jj = t(voltage_jj_onset_index);
    trial_onset = [trial_onset,trial_onset_jj];
    voltage_jj_offset_index = (voltage_jj_bi_diff<0);
    trial_offset_jj = t(voltage_jj_offset_index);
    trial_offset = [trial_offset,trial_offset_jj];
    trial_type_jj = ones(1, length(trial_onset_jj))*jj;
    trial_type = [trial_type,trial_type_jj];
end

if length(trial_offset)>length(trial_onset)
    trial_onset = [1 trial_onset];
end
if length(trial_offset)<length(trial_onset)
    trial_offset = [trial_offset length(voltage)];
end
 if nargin ==4
     min_pulse_duration = varargin{1};
     trial_duration_second = trial_offset-trial_onset;
     trial_onset(trial_duration_second<min_pulse_duration) = [];
     trial_type(trial_duration_second<min_pulse_duration) = [];
     % sort data according to time
     [trial_onset,I] = sort(trial_onset);
     trial_type = trial_type(I);
 end
  if nargin ==5
     min_pulse_duration = varargin{1};
     min_trial_duration = varargin{2};
     trial_duration_second = trial_offset-trial_onset;
     trial_onset(trial_duration_second<min_pulse_duration) = [];
     trial_type(trial_duration_second<min_pulse_duration) = [];
     % sort data according to time
     [trial_onset,I] = sort(trial_onset);
     trial_type = trial_type(I);
     trial_type_pulse_train = trial_type(1);
     trial_onset_pulse_train = trial_onset(1);
     last_onset_pulse_train = trial_onset(1);
     last_type_pulse_train = trial_type(1);

     for ii = 2:length(trial_type)
         current_onset_pulse_train = trial_onset(ii);
         current_onset_type_train = trial_type(ii);
         if current_onset_pulse_train - last_onset_pulse_train > min_trial_duration
             trial_type_pulse_train = [trial_type_pulse_train current_onset_type_train];
             trial_onset_pulse_train = [trial_onset_pulse_train current_onset_pulse_train];
             last_onset_pulse_train = current_onset_pulse_train;
             last_type_pulse_train = current_onset_type_train;
         end
     end
     trial_onset = trial_onset_pulse_train;
     trial_type = trial_type_pulse_train;
     if exist("threshold0","var")
         trial_onset = [1 trial_onset];
         trial_type = [0 trial_type];
         trial_type = trial_type+1;
     end
  end
  
  global showplot
  if exist('showplot','var') % show result if necessary. 
      if showplot
          
          newDefaultColors = jet(number_trial_type);
          figure
          plot(t, voltage)
          hold on
          for ii  = 1:length(trial_type)
              color_jj = newDefaultColors(trial_type(ii),:);
              xline(trial_onset(ii),'--','Color',color_jj);
          end
          xlabel('time(s)')
          ylabel('voltage(V)')
      end
  end

