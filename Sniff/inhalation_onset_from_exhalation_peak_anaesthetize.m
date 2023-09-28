function [sniff_onset] = inhalation_onset_from_exhalation_peak_anaesthetize(sniff_voltage, trigger_threshold, fs, minimum_sniff_duration_second, Exhalaation_peak_threshold, Time_to_exhalation_peak)
% addapted from sniff_trigger_riseedge_anaesthetize
% sniff_phase = zeros(size(sniff_voltage));
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


% In order to find the exhalation peak, we need to flip the sniff signal so
% that the exhalation goes upwards. 

% method 4: find peak and calculate the inhaltion peak as xx second ahead
[~,exh_pks] = findpeaks(-sniff_voltage, fs,'MinPeakDistance',minimum_sniff_duration_second,'MinPeakHeight',Exhalaation_peak_threshold);%-3.3
% trail_onset_pulse_train = []
% current_onset_pulse_train = sniff_onset(end);
% 
% for ii = 1:(length(inh_pks))
%     inh_pk = inh_pks(length(inh_pks)+1-ii);
%     % find the nearest threshold crossing at left of the peak
%     d = inh_pk-sniff_onset;
%     d(d<0) = nan;
%     [~,iiddxx]=min(d,[],'omitnan');
%     current_onset_pulse_train=sniff_onset(iiddxx);
%     trail_onset_pulse_train = [current_onset_pulse_train trail_onset_pulse_train];
% end
% sniff_onset = trail_onset_pulse_train;
sniff_onset = exh_pks-Time_to_exhalation_peak;
sniff_onset = sniff_onset(sniff_onset>0);

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
        plot(t, sniff_voltage)
        hold on
        for ii  = 1:length(sniff_onset)
            xline(sniff_onset(ii),'--');hold on
            %             y1=get(gca,'ylim');
            hold on
            %             plot([sniff_onset(ii) sniff_onset(ii)],y1);
        end
        xlabel('time(s)')
        ylabel('voltage(V)')
        title('Restore onset from threshold')
    end
end




