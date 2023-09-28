function [padded_w, padded_t] = padWaveform(w, t, fs, timeWindow)
    % INPUTS:
    % w: The waveform to be padded (array)
    % t: The time vector corresponding to w (array)
    % fs: Sampling rate in Hz (non-negative number)
    % timeWindow: Two-element array specifying the start and end times of the desired time window, e.g., [-1 10]
    
    % OUTPUTS:
    % padded_w: The zero-padded waveform (array)
    % padded_t: The time vector corresponding to padded_w (array)

    % Determine number of samples to add before and after the waveform
    preSamples = round((t(1) - timeWindow(1)) * fs);
    postSamples = round((timeWindow(2) - t(end)) * fs);

    % Generate the padded waveform and time vector
    padded_w = [zeros(1, preSamples), w, zeros(1, postSamples)];
    padded_t = [(t(1) - preSamples/fs):1/fs:(t(end) + postSamples/fs)];

end
