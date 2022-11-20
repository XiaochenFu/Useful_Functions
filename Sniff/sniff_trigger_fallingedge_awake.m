% function [sniff_onset] = sniff_trigger_fallingedge_awake(sniff_voltage0, trigger_threshold0, fs, minimum_sniff_duration_second)
% The if data is above threshold at t0 and below the threshold at t1, the
% onset would be defined as t0, rather than t1.
function [sniff_onset] = sniff_trigger_fallingedge_awake(sniff_voltage0, trigger_threshold0, fs, minimum_sniff_duration_second)
%
%change to rise edge
sniff_voltage = 0-sniff_voltage0;

trigger_threshold = 0-trigger_threshold0;
sniff_onset = [];
trail_offset = [];
t = (1:length(sniff_voltage))/fs;

sniff_copy = sniff_voltage;
sniff_copy(sniff_voltage>trigger_threshold) = 1;
sniff_copy(sniff_voltage<trigger_threshold) = 0;
sniff_jj_bi = sign(sniff_copy);
% find when data change
sniff_jj_bi_diff = diff(sniff_jj_bi);
sniff_jj_onset_index = find((sniff_jj_bi_diff>0));
sniff_onset_jj = t(sniff_jj_onset_index);
sniff_onset = [sniff_onset,sniff_onset_jj];
sniff_jj_offset_index = find((sniff_jj_bi_diff<0));
trail_offset_jj = t(sniff_jj_offset_index);
trail_offset = [trail_offset,trail_offset_jj];

% method 1: search from forward
% trail_onset_pulse_train = sniff_onset(1);
% last_onset_pulse_train = sniff_onset(1);
%
% for ii = 2:length(sniff_onset)
%     current_onset_pulse_train = sniff_onset(ii);
%     if current_onset_pulse_train - last_onset_pulse_train < minimum_sniff_duration_second
% %         last_onset_pulse_train = current_onset_pulse_train;
%     else
%         trail_onset_pulse_train = [trail_onset_pulse_train last_onset_pulse_train];
%         last_onset_pulse_train = current_onset_pulse_train;
%     end
% end
% trail_onset_pulse_train = [trail_onset_pulse_train last_onset_pulse_train];
% sniff_onset = trail_onset_pulse_train;

% method 2: search from backward
% trail_onset_pulse_train = sniff_onset(end);
% current_onset_pulse_train = sniff_onset(end);
%
% for ii = 1:(length(sniff_onset)-1)
%     last_onset_pulse_train = sniff_onset(end-ii);
%     if current_onset_pulse_train - last_onset_pulse_train < minimum_sniff_duration_second
% %         last_onset_pulse_train = current_onset_pulse_train;
%     else
%         trail_onset_pulse_train = [last_onset_pulse_train trail_onset_pulse_train];
%         current_onset_pulse_train= last_onset_pulse_train;
%     end
% end
% trail_onset_pulse_train = [trail_onset_pulse_train ];
% sniff_onset = trail_onset_pulse_train;

% method 3: find peak and search the nearest cross
[~,inh_pks] = findpeaks(sniff_voltage, fs,'MinPeakDistance',minimum_sniff_duration_second,'MinPeakHeight',-3.5);
trail_onset_pulse_train = [];
current_onset_pulse_train = sniff_onset(end);

for ii = 1:(length(inh_pks))
    inh_pk = inh_pks(length(inh_pks)+1-ii);
    % find the nearest threshold crossing at left of the peak
    d = inh_pk-sniff_onset;
    d(d<0) = nan;
    [~,iiddxx]=min(d,[],'omitnan');
    current_onset_pulse_train=sniff_onset(iiddxx);
    trail_onset_pulse_train = [current_onset_pulse_train trail_onset_pulse_train];
end
sniff_onset = trail_onset_pulse_train;


% show result
global showplot
global nopopplot
if exist("showplot")
    if showplot
        h = figure;
        if exist("nopopplot")
            if nopopplot
                set(h,'visible','off');
            end
        end
        plot(t, sniff_voltage0)
        hold on
        for ii  = 1:length(sniff_onset)
            xline(sniff_onset(ii),'--');,hold on
            %             y1=get(gca,'ylim');
            hold on
            %             plot([sniff_onset(ii) sniff_onset(ii)],y1);
        end
        xlabel('time(s)')
        ylabel('voltage(V)')
        title('Restore onset from threshold')
    end
end




