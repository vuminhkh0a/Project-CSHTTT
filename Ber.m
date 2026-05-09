function ber = Ber(original, recovered)
    ber = sum(original ~= recovered) / length(original);
end