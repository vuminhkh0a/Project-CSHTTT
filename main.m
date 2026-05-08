N = 64800;
EbNo_dB = 0:2:10;
ber_results = zeros(size(EbNo_dB));
[enc, dec] = ldpc_setup(); 

for i = 1:length(EbNo_dB)
    bits = generateBits(N);
    encoded = step(enc, bits);
    symbols = qpskMod(encoded);
    
    [faded, h] = rayleighChannel(symbols);
    
    snr = EbNo_dB(i) + 10*log10(2);
    noisy = awgn(faded, snr);
    
    equalized = noisy ./ h;
    
    var_n = 10^(-snr/10);
    llr = zeros(2*length(equalized), 1);
    llr(1:2:end) = -(2*real(equalized))/var_n;
    llr(2:2:end) = -(2*imag(equalized))/var_n;
    
    recovered = ldpcDec(dec, llr);
    ber_results(i) = calculateBER(bits, recovered);
end

figure;
semilogy(EbNo_dB, ber_results, 'r-o', 'LineWidth', 2);
grid on;
xlabel('Eb/No (dB)'); ylabel('BER');

figure;
subplot(1,2,1);
plot(noisy(1:500), 'k.'); title('Received');
subplot(1,2,2);
plot(equalized(1:500), 'b.'); title('Equalized');