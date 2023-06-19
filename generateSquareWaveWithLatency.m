function [w, t] = generateSquareWaveWithLatency(Intensity, PulseFrequency, PulseWidth, NumPulse, fs, Latency)
    % INPUTS:
    % Intensity: Amplitude of the pulses (non-negative number)
    % PulseFrequency: Frequency of the pulses in Hz (non-negative number)
    % PulseWidth: Width of each pulse in milliseconds (non-negative number)
    % NumPulse: Number of pulses to generate (non-negative integer)
    % fs: Sampling rate in Hz (non-negative number)
    % Latency: Time delay before the first pulse in seconds (non-negative number)
    
    % OUTPUTS:
    % w: The generated square wave, an array of size [1, NumPulse*PulseWidth*fs + Latency*fs]
    % t: The corresponding time vector in seconds, an array of the same size as w

    % by GPT4

    % Calculate total time
    totalTime = NumPulse / PulseFrequency;

    % Convert PulseWidth from milliseconds to proportion of pulse period
    PulseWidth = PulseWidth / 1000 * PulseFrequency;

    % Generate time vector
    t = 0:1/fs:totalTime - 1/fs;

    % Generate square wave
    w = 0.5 * Intensity * (square(2*pi*PulseFrequency*t, PulseWidth*100) + 1); 

    % Truncate to NumPulse pulses
    onePulseTime = 1 / PulseFrequency;
    pulseSamples = onePulseTime * fs;
    w = w(1:NumPulse*pulseSamples);
    t = t(1:NumPulse*pulseSamples);

    % Add latency
    latencySamples = round(Latency * fs);
    w = [zeros(1, latencySamples), w];
    t = [0:1/fs:(Latency - 1/fs), t + Latency];
end
