function phase = time2phase(time ,InhalationDuration,SniffDuration)
switch length(InhalationDuration)
    case 0 
        phase = nan;
    case 1 % one sniff cycle, one or more time points 
        phase = zeros(size(time));
        switch length(time)
            case 0
                phase = nan;
            case 1
                if time<=InhalationDuration
                    phase = time/InhalationDuration*pi;
                else
                    ExhalationDuration = SniffDuration-InhalationDuration;
                    phase = (time-InhalationDuration)/ExhalationDuration*pi+pi;
                end
            otherwise % Recursion
                for i = 1:length(time)
                    time_i = time(i);
                    phase_i = time2phase(time_i ,InhalationDuration,SniffDuration);
                    phase(i)  = phase_i;
                end
        end
    otherwise % many sniff cycles, one points per sniff cycle. Recursion
        if length(time) == length(InhalationDuration)
            phase = zeros(size(time));
            for i = 1:length(time)
                time_i = time(i);
                InhalationDuration_i = InhalationDuration(i);
                SniffDuration_i = SniffDuration(i);
                phase_i = time2phase(time_i ,InhalationDuration_i,SniffDuration_i);
                phase(i)  = phase_i;
            end
        else
            error('Number of time point should be same of the number of the sniff cycle')
        end
end