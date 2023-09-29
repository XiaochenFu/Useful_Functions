function [FV_duration, amp] = PID_amp_est(FV, PID, t)
% Estimate the PID voltage by averaging the PID voltage when FV is on. 
% JKR used this to estimate the PID. The shorter the pulse, the less
% accurate.

% The baseline can be removed. with the function.

% input: FV voltage, PID voltage, time step.
% output: duration of FV opening, and the estimated voltage
FV0 = sig_Bi(FV);
[~,~,FV_duration,~] = findpeaks(FV0,t);
amp = mean(PID(FV0>0));
