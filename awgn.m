
function noise = awgn(symbols,snr_db)
  Es = var(symbols);
  Eb = Es/2;
  N0 = Eb/10^(snr_db/10);
  noise=sqrt(N0/2)*(randn(size(symbols))+j*randn(size(symbols)));

