
clear;
clc;
n = 10^5;
bitSource=generateBits(n);
symbols=qpskMod(bitSource);


b = 0.5;
f_m = 91;
N1 = 9;
N2 = 10;
f_s = 270800;

T_symb = 1/f_s;
t = (0:length(symbols)-1)*T_symb;
g1 = g(b, f_m, N1, t);
g2 = g(b, f_m, N2, t);
g = g1 + j*g2;

snr_db = 0:5:30;
ber_sim = zeros(size(snr_db));
ber_theo = zeros(size(snr_db));




for i = 1:length(snr_db)
  faded_symbols = g .* symbols;
  noise = awgn(faded_symbols, snr_db(i));
  received = faded_symbols + noise;

  symbols_demod = received./g;

  bitSink=demod(symbols_demod, g);
  ber_sim(i) = calculateBer(bitSource, bitSink);
endfor

ber_sim
gamma_b = 2*b*10.^(snr_db/10);
ber_theo = 0.5*(1-sqrt(gamma_b./(1+gamma_b)))
hold on
semilogy(snr_db, ber_sim, 'bo')
semilogy(snr_db, ber_theo, '--')
legend('simulation', 'theory')
hold off


