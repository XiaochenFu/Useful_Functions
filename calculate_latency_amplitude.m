function [duration, amplitude, idx_onset, idx_offset] = calculate_latency_amplitude(Rawdata, idx0) 
% Input
% Rawdata, signal with one pulse
% index0, original index of the first dot of the Rawdata
% the Rawdata should look like this
% _________------________________

switch nargin
    case 1
        idx0 = 1;
end
    Rawdata_Bi = logical(sig_Bi(Rawdata));
    value_on0 = mean(Rawdata(Rawdata_Bi)); %roughly seperate data into two parts
    value_off0 = mean(Rawdata(~Rawdata_Bi));
    e = exp(1);
    threshold_on_e2 = value_off0 + (1-1/e^2)*(value_on0 - value_off0);
    threshold_off_e2 = value_on0 - (1-1/e^2)*(value_on0 - value_off0);
    value_on = mean(Rawdata(Rawdata>threshold_on_e2)); % choose 'on' data and 'off' data with the threshold
    value_off = mean(Rawdata(Rawdata<threshold_off_e2));
    threshold_on_e1 = value_off + (1-1/e)*(value_on - value_off);
    %     threshold_off_e1 = value_on - (1-1/e)*(value_on - value_off);
    idx_onset0 = remove_close_dots(find(Rawdata>threshold_on_e1),100);
    idx_offset0 = find(Rawdata>threshold_on_e1);
    idx_offset0 = idx_offset0(end);
    duration = idx_offset0 - idx_onset0;
    idx_onset = idx0 + idx_onset0;
    idx_offset = idx0 + idx_offset0;
    amplitude = value_on0;
    
%     
%     figure()
%     plot(Rawdata);hold on;
%     xlabel('time(ms)')
%     ylabel('power (uW)')
%     yline(value_on,'-.b','On state', 'linewidth',1.618); hold on; yline(value_off,'-.b','Off state', 'linewidth',1.618);
%     yline(threshold_on_e1,'-r','Threshold', 'linewidth',1.618);
%     xline(idx_onset0, 'linewidth',1.618); hold on; xline(idx_offset0, 'linewidth',1.618);
end