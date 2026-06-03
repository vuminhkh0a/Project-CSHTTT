

clear;
clc;
n = 10^6;
bitSource=generateBits(n);
symbols=qpskMod(bitSource);

snr_db = 0:8;
snr = zeros(size(snr_db));
ber = zeros(size(snr_db));
ber_theo = zeros(size(snr_db));



for i = 1:length(snr_db)
  snr(i)=10^(snr_db(i)/10);
  Es = var(symbols);
  Eb = Es/2;
  N0 = Eb/10^(snr_db(i)/10);
  noise=sqrt(N0/2)*(randn(size(symbols))+1j*randn(size(symbols)));
  symbols_noise = symbols+noise;
  bitSink=qpskDemod(symbols_noise);
  ber(i) = calculateBer(bitSource, bitSink);
  ber_theo(i) = 0.5*erfc(sqrt(snr(i)));
end

ber
ber_theo
hold on
set(gca, 'YScale', 'log');
semilogy(snr_db, ber, 'bo-')
semilogy(snr_db, ber_theo, 'k--')
legend('simulation', 'theory')
xlabel('Eb/N0 (dB)')
ylabel('BER')
title('BER of QPSK signal over a channel with AWGN')
hold off


