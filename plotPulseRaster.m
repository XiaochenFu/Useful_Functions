function plotPulseRaster(hFig, Intensity, PulseFrequency, PulseWidth, NumPulse, Latency, yPos, varargin)
    % INPUTS:
    % hFig: Handle to the target figure
    % Intensity: Amplitude of the pulses (non-negative number)
    % PulseFrequency: Frequency of the pulses in Hz (non-negative number)
    % PulseWidth: Width of each pulse in milliseconds (non-negative number)
    % NumPulse: Number of pulses to generate (non-negative integer)
    % Latency: Time delay before the first pulse in seconds (non-negative number)
    % yPos: The y position where the ticks (rectangles) should be plotted
    % varargin: Plotting properties (such as 'EdgeColor', 'FaceColor', etc.)

    % Ensure the figure with handle hFig is the current figure
    figure(hFig); hold on;

    % Calculate total time
    totalTime = NumPulse / PulseFrequency;

    % Convert PulseWidth from milliseconds to seconds
    PulseWidthSec = PulseWidth / 1000;

    % Plot the pulse train as rectangles
    for i = 1:NumPulse
        start_time = (i-1)/PulseFrequency + Latency;
        rectangle('Position', [start_time, yPos, PulseWidthSec, Intensity], varargin{:});
    end
    
%     xlabel('Time (s)');
%     ylabel('Intensity');
%     title('Pulse Train with Latency');
%     hold off;
end