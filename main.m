clear; clc; close all;

H = [1 1 1 0 1 0 0 0; 0 1 1 1 0 1 0 0; 1 0 1 1 0 0 1 0; 1 1 0 1 0 0 0 1];
[m, n] = size(H);
k = n - m;
total_bits = 40000;
num_frames = total_bits / k;

EbNo_dB = 0:1:8;
ber_results = zeros(size(EbNo_dB));

for i = 1:length(EbNo_dB)
    errors = 0;
    all_noisy = [];
    all_equalized = [];
    
    for f = 1:num_frames
        bits = Gen_bits(k);
        encoded = Ldpc_encode(bits, H);
        symbols = Qpsk_modul(encoded);
        [faded, h_chan] = Rayleigh(symbols);
        
        snr = EbNo_dB(i) + 10*log10(k/n);
        noisy = Add_awgn(faded, snr);
        equalized = noisy ./ h_chan;
        
        if i == length(EbNo_dB)
            all_noisy = [all_noisy, noisy];
            all_equalized = [all_equalized, equalized];
        end
        
        var_n = 10^(-snr/10);
        llr = Qpsk_demodul(equalized, var_n);
        recovered = Ldpc_decode(llr, H);
        
        errors = errors + sum(bits ~= recovered(1:k));
    end
    
    ber_results(i) = errors / total_bits;
end

figure;
semilogy(EbNo_dB, ber_results, 'r-s', 'LineWidth', 2, 'MarkerFaceColor', 'r');
grid on;
xlabel('Eb/No (dB)');
ylabel('Bit Error Rate (BER)');

figure;
subplot(1, 2, 1);
plot(all_noisy, 'k.', 'MarkerSize', 1);
title('Received');
axis square;
grid on;

subplot(1, 2, 2);
plot(all_equalized, 'b.', 'MarkerSize', 4);
title('Equalized');
axis square;
grid on;