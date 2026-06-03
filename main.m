clear;
clc;

% LDPC Configuration
block_length = 1296;  % 648, 1296, or 1944
rate = 1/2;           % 1/2, 2/3, 3/4, 5/6
max_decode_iterations = 50;
min_sum = 1;

% Initialize LDPC code
ldpc_code = LDPCCode(0, 0);
ldpc_code.load_wifi_ldpc(block_length, rate);
info_length = ldpc_code.K;

% Channel parameters
b = 0.5;
f_m = 91;
N1 = 9;
N2 = 10;
f_s = 270800;
T_symb = 1/f_s;

% Number of codewords
num_codewords = 20;  % Increase for more accurate results
total_bits = num_codewords * block_length;
total_symbols = total_bits / 2;

% Generate information bits
info_bits = randi([0, 1], num_codewords * info_length, 1);

% Encode all information bits
coded_bits = zeros(total_bits, 1);
for i = 1:num_codewords
    idx_info = (i-1)*info_length + 1 : i*info_length;
    idx_code = (i-1)*block_length + 1 : i*block_length;
    coded_bits(idx_code) = ldpc_code.encode_bits(info_bits(idx_info));
end

% QPSK Modulation using your function
symbols = qpskMod(coded_bits);

% Fading channel generation
t = (0:total_symbols-1)*T_symb;
g1 = g(b, f_m, N1, t);
g2 = g(b, f_m, N2, t);
g_chann = g1 + 1j*g2;

snr_db = 0:2:20;
ber_sim = zeros(size(snr_db));

for snr_idx = 1:length(snr_db)
    fprintf('\nProcessing SNR = %.1f dB\n', snr_db(snr_idx));

    % Apply fading
    faded_symbols = g_chann .* symbols;

    % Calculate noise variance
    %Es = mean(abs(symbols).^2); % Should be 1 after normalization
    Es = var(symbols);
    Eb = Es / 2;  % QPSK has 2 bits per symbol
    N0 = Eb / (10^(snr_db(snr_idx)/10));
    noise_var = N0/2;  % Variance per dimension (real/imag)

    % Add noise
    noise = sqrt(noise_var) * (randn(size(symbols)) + 1j*randn(size(symbols)));
    received = faded_symbols + noise;

    % Compute LLRs for your QPSK constellation
    llr = compute_qpsk_llr(received, g_chann, N0);

    % Decode each codeword
    decoded_bits = zeros(total_bits, 1);
    block_errors = 0;
    bit_errors = 0;

    for i = 1:num_codewords
        idx_code = (i-1)*block_length + 1 : i*block_length;

        % Decode
        [decoded_codeword, ~] = ldpc_code.decode_llr(llr(idx_code), ...
                                                      max_decode_iterations, min_sum);
        decoded_bits(idx_code) = decoded_codeword;

        % Count errors
        original = coded_bits(idx_code);
        errors = sum(decoded_codeword ~= original);
        if errors > 0
            block_errors = block_errors + 1;
            bit_errors = bit_errors + errors;
        end
    end

    % Calculate error rates
    ber_sim(snr_idx) = bit_errors / total_bits;

end
ber_sim = ber_sim + 0.0001
gamma_b = 2*b*10.^(snr_db/10);
ber_theo = 0.5*(1-sqrt(gamma_b./(1+gamma_b)))

% Plot results
hold on;
set(gca, 'YScale', 'log');
semilogy(snr_db, ber_sim, 'ro-', 'LineWidth', 1.5, 'MarkerSize', 8);
semilogy(snr_db, ber_theo, '--', 'LineWidth', 1.5, 'MarkerSize', 8);
grid on;
xlabel('Eb/N0 (dB)', 'FontSize', 12);
ylabel('Error Rate', 'FontSize', 12);
title(sprintf('LDPC Code (N=%d, Rate=%.2f) over Rayleigh Fading with QPSK', block_length, rate), 'FontSize', 14);
legend('LDPC', 'Uncoded');
axis([min(snr_db) max(snr_db) 1e-4 1]);
hold off;
