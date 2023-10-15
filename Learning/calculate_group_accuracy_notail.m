% Function to calculate dprime
function [Session0, mean_dprimes, std_dprimes] = calculate_group_accuracy_notail(Behaviour_Infos)
n_inputs = length(Behaviour_Infos);
% mean_dprimes = zeros(1, n_inputs);
% std_dprimes = zeros(1, n_inputs);
Session_longest = [];
dprime_all = {};
for j = 1:n_inputs
    Behaviour_Info = Behaviour_Infos{j};

    if ~isempty(Behaviour_Info)
        % Define the labels for the signal and noise stimuli
        signal_label = 'HIT';
        noise_label = 'FA';

        % Extract the Behaviour_Info_cat labels from the Behaviour_Info structure
        labels = {Behaviour_Info.Response};


        % Calculate the hit and false alarm counts for each window
        hit_idx = strcmp(labels, signal_label);
        miss_idx = strcmp(labels, 'MISS');
        fa_idx = strcmp(labels, noise_label);
        cr_idx = strcmp(labels, 'CR');



        % Calculate the dprime for every window_size trials
        total_length = length(labels);
        window_steps = 3;
        window_width = 25;
        n_windows = length(1:window_steps:(total_length - window_width + 1));
        dprimes = zeros(1,n_windows);
        Session = 1:window_steps:(total_length - window_width + 1);
        if length(Session_longest)<length(Session)
            Session_longest = Session;
        end
        k = 1;
        for i = 1:window_steps:(total_length - window_width + 1)
            window_indices = i:(i + window_width - 1);
            n_hit = sum(hit_idx(window_indices));
            n_miss = sum(miss_idx(window_indices));
            n_fa = sum(fa_idx(window_indices));
            n_cr = sum(cr_idx(window_indices));
            n_splus = n_hit + n_miss;
            n_sminus = n_fa + n_cr;
            dprimes(k) = Accuracy_Cal(n_hit, n_fa, n_splus, n_sminus);
            k = k+1;
        end

    end
    %     % Store mean and std dprime for current Behaviour_Info_cat
    %     mean_dprimes(j) = mean(dprimes);
    %     std_dprimes(j) = std(dprimes);
    dprime_all = [dprime_all dprimes];

end


maxNumCol = max(cellfun(@(c) size(c,2), dprime_all));  % max number of columns
aMat = cell2mat(cellfun(@(c){padarray(c,[0,maxNumCol-size(c,2)],NaN,'Post')}, dprime_all)');



% If there is only one input, retain all values
if n_inputs == 1
    mean_dprimes = mean(aMat,1,'omitnan');
    std_dprimes = 0;
    Session0 = Session;
else
    % If there are multiple inputs, remove tails with single input
    max_len = max(cellfun(@length, dprime_all)); % find the maximum length
    dprime_mat = nan(n_inputs, max_len); % pre-allocate matrix with NaN
    for i = 1:n_inputs
        dprime_mat(i, 1:length(dprime_all{i})) = dprime_all{i}; % assign values to matrix
    end
    valid_idx = sum(~isnan(dprime_mat)) > 1; % find indices where there are more than one value
    mean_dprimes = nanmean(dprime_mat(:, valid_idx), 1); % compute mean, ignoring NaNs
    std_dprimes = nanstd(dprime_mat(:, valid_idx), 1, 1); % compute std, ignoring NaNs
%     Session_longest = 1:window_steps:(total_length - window_width + 1);
    Session0 = Session_longest(valid_idx);
end

end