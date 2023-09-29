function corrected_sig = baseline_correction(sig, t, timewindow)
%baseline_correction Corrects the baseline of a given signal.
%
%   corrected_sig = baseline_correction(sig, t, timewindow)
%
%   Inputs:
%       sig - Input signal
%       t - Time vector associated with the signal
%       timewindow - 2-element vector specifying the time window for baseline calculation
%
%   Output:
%       corrected_sig - Baseline-corrected signal

% Validate inputs
if numel(timewindow) ~= 2 || timewindow(1) >= timewindow(2)
    error('timewindow must be a 2-element vector with increasing values');
end

% Find indices corresponding to the baseline time window
baseline_indices = find(t >= timewindow(1) & t <= timewindow(2));

% Check if there are enough indices to calculate baseline
if numel(baseline_indices) < 1
    error('Not enough data points in the specified timewindow for baseline calculation');
end

% Calculate baseline as the mean of the signal within the time window
baseline = mean(sig(baseline_indices));

% Subtract baseline from the signal
corrected_sig = sig - baseline;

end
