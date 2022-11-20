    function [t, x1, x1_std] = average_data_plot(x1_all, Sampling_Rate)
        [Number_Dots,~] = size(x1_all);
        t = (0:Number_Dots-1)/Sampling_Rate;
%         fprintf('Sampling Rate needs to be 1k')
        x1 = mean(x1_all,2);
        x1_std = std(x1_all,0,2);
    end