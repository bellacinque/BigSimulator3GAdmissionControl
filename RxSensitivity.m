BER = 0.0412; % Found Reference BER with FEC

% BER_Ds_BPSK = 0.5*erfc(sqrt(SNR)), assuming Noise Limited Conditions 

SNR_min = (erfcinv(BER*2))^2;

% Consider Pn and compute Pr_min(W) 

Pn = 1.38 * 10^(-23) * 10^5 * 10^3;

Pr_min = SNR_min * Pn; 

%Pr_min in dBm

Pr_min_dBm = 10*log10(Pr_min) + 30;