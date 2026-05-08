function decodedBits = Ldpc_decode(decoderObj, llrValues)
    decodedBits = step(decoderObj, llrValues);
end