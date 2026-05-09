function recovered = Ldpc_decode(llr, H)
    received_bits = llr < 0; 
    decoded = double(received_bits');
    for iter = 1:50
        syndrome = mod(decoded * H', 2);
        if all(syndrome == 0), break; end
        violations = syndrome * H;
        [~, idx] = max(violations);
        decoded(idx) = 1 - decoded(idx);
    end
    recovered = decoded';
end