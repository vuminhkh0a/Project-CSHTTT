function [enc, dec] = ldpc_setup()
    H = dvbs2ldpc(1/2); 
    enc = comm.LDPCEncoder(H);
    dec = comm.LDPCDecoder(H);
end