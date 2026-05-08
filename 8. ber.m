function ber = calculateBER(original, recovered)
    ber = sum(original ~= recovered) / length(original);
end