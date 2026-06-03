
clear;
clc;
n = 10^6;
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
g_chann = g1 + 1j*g2;

snr_db = 0:5:30;
ber_sim = zeros(size(snr_db));
ber_theo = zeros(size(snr_db));




for i = 1:length(snr_db)
  faded_symbols = g_chann .* symbols;
  Es = var(symbols);
  Eb = Es/2;
  N0 = Eb/10^(snr_db(i)/10);
  noise=sqrt(N0/2)*(randn(size(symbols))+1j*randn(size(symbols)));
  received = faded_symbols + noise;

  symbols_demod = received./g_chann;

  bitSink=demod(symbols_demod, g_chann);
  ber_sim(i) = calculateBer(bitSource, bitSink);
end

ber_sim
gamma_b = 2*b*10.^(snr_db/10);
ber_theo = 0.5*(1-sqrt(gamma_b./(1+gamma_b)))
hold on
set(gca, 'YScale', 'log');
semilogy(snr_db, ber_sim, 'ro-')
semilogy(snr_db, ber_theo, '--')
legend('simulation', 'theory')
title('BEP of slow flat Rayleigh fading channel')
xlabel('Eb/N0 (dB)')
ylabel ('BER')
hold off


