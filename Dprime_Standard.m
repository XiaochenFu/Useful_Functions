% Function to calculate standard d-prime
function [dP] = Dprime_Standard(n_HIT,n_FA, n_SPlus, n_SMinus)
    p_HIT = n_HIT/n_SPlus;
    p_FA = n_FA/n_SMinus;
    dP = norminv(p_HIT)-norminv(p_FA);
end
