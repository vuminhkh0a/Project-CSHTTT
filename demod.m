
function bitSink = demod(symbols, g)
  bitSink = zeros(1,length(symbols)*2);
  sTypes = [pi/4,3*pi/4,5*pi/4,7*pi/4];
  sTypes = exp(1j*sTypes);
  for i = 1:length(symbols)/4
    gS_m(4*i-3:4*i)=g(4*i-3:4*i).*sTypes;
  end
  for index = 1:length(symbols)
    distance = abs(symbols(index)-sTypes);
    minDis = min(distance);
    if minDis == distance(1)
      bitSink(2*index-1)=0;
      bitSink(2*index)=0;
    elseif minDis == distance(2)
      bitSink(2*index-1)=0;
      bitSink(2*index)=1;
    elseif minDis == distance(3)
      bitSink(2*index-1)=1;
      bitSink(2*index)=1;
    else
      bitSink(2*index-1)=1;
      bitSink(2*index)=0;
    end
  end
