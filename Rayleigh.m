function [fadedSymbols, h] = Rayleigh(symbols)
    h = (randn(size(symbols)) + 1i*randn(size(symbols))) / sqrt(2);
    fadedSymbols = symbols .* h;
end