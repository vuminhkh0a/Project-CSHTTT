function decodedBits = ldpcDec(decoderObj, llrValues)
    decodedBits = step(decoderObj, llrValues);
end