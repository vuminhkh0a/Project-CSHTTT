function [enc, dec] = Ldpc_encode()
    H = dvbs2ldpc(1/2); 
    enc = comm.LDPCEncoder(H);
    dec = comm.LDPCDecoder(H);
end