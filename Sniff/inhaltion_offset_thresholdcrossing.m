function duration = inhaltion_offset_thresholdcrossing(sniff_voltage0, trigger_threshold0, fs, min_inhal_duration_second)

ixs = find(sign(sniff_voltage0-trigger_threshold0)>0);% find the point when voltage is higer than threshold, so not inhalation
t_offset_candidate = ixs/fs;
t_offset_candidate1 = t_offset_candidate-min_inhal_duration_second;
t_offset_candidate2 = t_offset_candidate(t_offset_candidate1>0);
duration =min(t_offset_candidate2);