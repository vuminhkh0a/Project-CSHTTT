
function symbols = awgn(symbols,snr)
  Es = var(symbols);
  Eb = Es/2;
  N0 = Eb/10^(snr/10);
  noise=sqrt(N0/2)*(randn(size(symbols))+i*randn(size(symbols)));
  symbols = symbols + noise;

