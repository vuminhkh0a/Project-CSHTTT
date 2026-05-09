function encoded = Ldpc_encode(bits, H)
    [m, n] = size(H);
    k = n - m;
    P = H(:, 1:k)';
    G = [eye(k), P];
    encoded = mod(bits' * G, 2);
end