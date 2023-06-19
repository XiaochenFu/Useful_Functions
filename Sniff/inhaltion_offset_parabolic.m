function [duration,sniff_inhal_to_fit,ffun,t0,t,fobj] = inhaltion_offset_parabolic(sniff_voltage0, trigger_threshold0, fs, min_inhal_duration_second, finhal_fit_tail_second)
 % Find the inhaltion offset as the nearest threshold crossing of the parabolic fit for each inhalation onset, first find the zero crossing of the raw signal
inhal_offset = inhaltion_offset_thresholdcrossing(sniff_voltage0, trigger_threshold0, fs, min_inhal_duration_second);
t_offset_idx = round(inhal_offset*fs); % change time to index
sniff_inhal_voltage = sniff_voltage0(1:t_offset_idx); % inhal defined by voltage. Then, we need to find the minimum, and fit with data before the mininum
[~,I] = min(sniff_inhal_voltage);
if I+round(finhal_fit_tail_second*fs)>length(sniff_inhal_voltage) 
    sniff_inhal_to_fit = sniff_inhal_voltage;
else
    sniff_inhal_to_fit = sniff_inhal_voltage(1:I+round(finhal_fit_tail_second*fs));
end
% Then, use parabolic fit.
t0 = linspace(0, 1, fs+1);
t = t0(1:length(sniff_inhal_to_fit));
fobj = polyfit(t,(sniff_inhal_to_fit-trigger_threshold0),2);
% After that, find the crossing of the
% parabolic fit.
ffun = @(x) x.^2*fobj(1)+x.^1*fobj(2)+x.^0*fobj(3);
fit_duration = fzero(ffun,min_inhal_duration_second*2);
if fit_duration> inhal_offset
    duration = inhal_offset;
elseif fit_duration<(min_inhal_duration_second/2)
    duration = inhal_offset;
else
    duration = fit_duration;
end
