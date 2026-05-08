clear; clc; close all;

H = dvbsldpc(1/2); 
N = size(H, 2);
EbNo_dB = 0:2:10;
ber_results = zeros(size(EbNo_dB));

for i = 1:length(EbNo_dB)
    bits = Gen_bits(N/2);
    encoded = Ldpc_encode(bits, H);
    symbols = Qpsk_modul(encoded);
    [faded, h] = Rayleigh(symbols);
    
    snr = EbNo_dB(i) + 10*log10(2);
    noisy = Add_awgn(faded, snr);
    equalized = noisy ./ h;
    
    var_n = 10^(-snr/10);
    llr = Qpsk_demodul(equalized, var_n);
    recovered = Ldpc_decode(llr, H);
    
    ber_results(i) = Ber(bits, recovered);
end

figure;
semilogy(EbNo_dB, ber_results, 'r-o', 'LineWidth', 2);
grid on;
xlabel('Eb/No (dB)');
ylabel('BER');

figure;
subplot(1,2,1);
plot(noisy(1:500), 'k.');
title('Received');
axis square;
grid on;

subplot(1,2,2);
plot(equalized(1:500), 'b.');
title('Equalized');
axis square;
grid on;