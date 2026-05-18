

clear;
clc;
n = 64800;
bitSource=generateBits(n);
symbols=qpskMod(bitSource);


snr_db = 0:8;
snr = zeros(size(snr_db));
ber = zeros(size(snr_db));
ber_theo = zeros(size(snr_db));



for i = 1:length(snr_db)
  snr(i)=10^(snr_db(i)/10);
  symbols_noise = symbols+awgn(symbols,snr_db(i));
  bitSink=qpskDemod(symbols_noise);
  ber(i) = calculateBer(bitSource, bitSink);
  ber_theo(i) = 0.5*erfc(sqrt(snr(i)));
endfor

ber
ber_theo
hold on
semilogy(snr_db, ber, 'bo')
semilogy(snr_db, ber_theo, '--')
legend('simulation', 'theory')
hold off


