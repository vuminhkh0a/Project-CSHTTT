
function symbols = qpskMod(bitSource)
  symbols = zeros(1,length(bitSource)/2);
  for index = 1:2:length(bitSource)
    if bitSource(index)==0&&bitSource(index+1)==0
      symbols((index+1)/2)=exp(pi*1j/4);
    elseif bitSource(index)==0&&bitSource(index+1)==1
      symbols((index+1)/2)=exp(3*pi*1j/4);
    elseif bitSource(index)==1&&bitSource(index+1)==1
      symbols((index+1)/2)=exp(5*pi*1j/4);
    else
      symbols((index+1)/2)=exp(7*pi*1j/4);
    end
  end
  end

