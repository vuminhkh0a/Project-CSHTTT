
function ber = calculateBer(bitSource, bitSink)
  count = 0;
  n = length(bitSource);
  for index = 1:n
    if bitSource(index)!=bitSink(index)
      count = count + 1;
    endif
  endfor
  ber = count/length(bitSource);

