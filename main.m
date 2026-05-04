clc; clear;
[enc, dec] = ldpc_setup(); 
SNR_dB = 8;
nBits = 32400; 

bitSource = generateBits(nBits); 
encodedBits = step(enc, bitSource); 

txSymbols = qpskMod(encodedBits); 
[fadedSymbols, h] = rayleighChannel(txSymbols);
rxSymbols = awgn(fadedSymbols, SNR_dB); 

equalizedSymbols = rxSymbols ./ h; 
demodBits = qpskDemod(equalizedSymbols); 

bitSink = step(dec, demodBits');

errors = sum(bitSource ~= bitSink);
ber = errors / nBits;

fprintf('SNR: %d dB | Errors: %d | BER: %e\n', SNR_dB, errors, ber);