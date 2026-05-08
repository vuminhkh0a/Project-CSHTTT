function encoded = Ldpc_encode(bits, H)
    P = H(:, 1:4)';
    G = [eye(4), P];
    encoded = mod(bits' * G, 2);
end