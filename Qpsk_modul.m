function symbols = Qpsk_modul(bits)
    symbols = zeros(1, length(bits)/2);
    for i = 1:2:length(bits)
        re = (1 - 2*bits(i));     
        im = (1 - 2*bits(i+1));   
        symbols((i+1)/2) = (re + 1j*im)/sqrt(2);
    end
end