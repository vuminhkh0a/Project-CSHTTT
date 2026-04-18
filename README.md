# Project CSHTTT

## 1. Generate BitSource
n is the size of bitSource vector
```
bitSource=generateBits(n);
```

## 2. QPSK Modulation
```
symbols=qpskMod(bitSource);
```
### Plot the constellation map
```
plot(symbols,'.')
```

## 3. Add AWGN to signal
snr in db
```
symbols = awgn(symbols,snr);
```
### Plot the constellation map to see the effect of AWGN 
```
plot(symbols,'.')
```

## 4. QPSK Demodulation
```
bitSink=qpskDemod(symbols);
```
