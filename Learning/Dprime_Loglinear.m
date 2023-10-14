function [dP] = Dprime_Loglinear(n_HIT,n_FA, n_SPlus, n_SMinus)

% based on  (Hautus, 1995), mentioned in Stanislaw & Todorov (1999)

% A third approach, dubbed loglinear, involves adding 0.5 to both the
% number of hits and the number of false alarms and adding 1 to both the
% number of signal trials and the number of noise trials, before
% calculating the hit and falsealarm rates. This seems to work reasonably
% well (Hautus, 1995). Advocates of the loglinear approach recommend using
% it regardless of whether or not extreme rates are obtained

p_HIT = (n_HIT+0.5)/(n_SPlus+1);
p_FA = (n_FA+0.5)/(n_SMinus+1);
dP = norminv(p_HIT)-norminv(p_FA);