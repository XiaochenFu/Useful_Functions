function [dP] = Dprime_2N(n_HIT,n_FA, n_SPlus, n_SMinus)
% Function to calculate standard d-prime

% based on  (Hautus, 1995), mentioned in Stanislaw & Todorov (1999)

% A fourth approach involves adjusting only the extreme rates themselves.
% Rates of 0 are replaced with 0.5 ÷ n, and rates of 1 are replaced with (n
% 0.5) ÷ n, where n is the number of signal or noise trials (Macmillan &
% Kaplan, 1985). This approach yields biased measures of sensitivity
% (Miller, 1996) and may be less satisfactory than the loglinear approach
% (Hautus, 1995). However, it is the most common remedy for extreme values
% and is utilized in several computer programs that calculate SDT measures
% (see, e.g., Dorfman, 1982). Thus, it is the convention we adopt in our
% computational example below.


p_HIT = n_HIT/n_SPlus;
p_FA = n_FA/n_SMinus;
if p_HIT == 1
    p_HIT = 1 - (1 / (2 * n_SPlus));
elseif p_HIT == 0
    p_HIT = 1 / (2 * n_SPlus);
end

if p_FA == 1
    p_FA = 1 - (1 / (2 * n_SMinus));
elseif p_FA == 0
    p_FA = 1 / (2 * n_SMinus);
end
dP = norminv(p_HIT)-norminv(p_FA);
end
