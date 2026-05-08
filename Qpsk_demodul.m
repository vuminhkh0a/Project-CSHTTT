function llr = Qpsk_demodul(equalized, var_n)
    llr = zeros(2*length(equalized), 1);
    llr(1:2:end) = -(2 * real(equalized)) / var_n;
    llr(2:2:end) = -(2 * imag(equalized)) / var_n;
end