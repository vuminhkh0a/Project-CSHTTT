function symbols = Add_awgn(symbols,snr)
    Es = var(symbols);
    Eb = Es/2;
    N0 = Eb/10^(snr/10);
    noise = sqrt(N0/2)*(randn(size(symbols)) + 1i*randn(size(symbols)));
    symbols = symbols + noise;
end