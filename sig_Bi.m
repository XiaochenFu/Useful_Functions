%% Lick data get from a beam break
function bi_data = sig_Bi(Data,On_Value,Off_Value)
% Input: 
%     Beam_Data: Data from beam breaker;   
%     Nolick: Aproximate value when there's no break
%     Lick: Aproximate value when break
%     lick_time_threshold: If beam break is longer than threshold, it's not a lick
% Output: 
%     beam_break: binary data, 1 for break and 0 for no break
%     realick: binary data, 1 for lick-caused break
switch nargin
    case 1
        On_Value =  max(Data(:)); Off_Value = min(Data(:)); 
        Data = (Data-Off_Value)/(On_Value-Off_Value);
        bi_data = round(Data);
        bi_data(bi_data>1) = 1;
    case 3
        Data = (Data-Off_Value)/(On_Value-Off_Value);
        bi_data = round(Data);
        bi_data(bi_data<0) = 0;
    otherwise
        error('Check the Number of imputs')
end
end