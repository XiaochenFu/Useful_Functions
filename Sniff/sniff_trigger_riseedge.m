function [sniff_onset] = sniff_trigger_riseedge(sniff_voltage, trigger_threshold, fs, minimum_sniff_duration_second)
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


trail_onset_pulse_train = sniff_onset(1);
last_onset_pulse_train = sniff_onset(1);

for ii = 2:length(sniff_onset)
    current_onset_pulse_train = sniff_onset(ii);
    if current_onset_pulse_train - last_onset_pulse_train > minimum_sniff_duration_second
        trail_onset_pulse_train = [trail_onset_pulse_train current_onset_pulse_train];
        last_onset_pulse_train = current_onset_pulse_train;
        
    end
end
sniff_onset = trail_onset_pulse_train;
%     % show result
% %     figure
%     plot(t, sniff_voltage)
%     hold on
%     for ii  = 1:length(sniff_onset)
%         xline(sniff_onset(ii),'--');
%     end
%     xlabel('time(s)')
%     ylabel('voltage(V)')
%     title('Restore onset from threshold')
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

