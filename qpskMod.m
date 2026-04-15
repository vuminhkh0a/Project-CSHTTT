
function modulatedBits = qpskMod(bitSource)
  modulatedBits = zeros(1,length(bitSource)/2);
  hold on
  for index = 1:2:length(bitSource)
    if bitSource(index)==0&&bitSource(index+1)==0
      plot(exp(pi*i/4));
      modulatedBits((index+1)/2)=exp(pi*i/4);
    elseif bitSource(index)==0&&bitSource(index+1)==1
      plot(exp(3*pi*i/4));
      modulatedBits((index+1)/2)=exp(3*pi*i/4);
    elseif bitSource(index)==1&&bitSource(index+1)==1
      plot(exp(5*pi*i/4));
      modulatedBits((index+1)/2)=exp(5*pi*i/4);
    else
      plot(exp(7*pi*i/4));
      modulatedBits((index+1)/2)=exp(7*pi*i/4);
    endif
  endfor
  hold off
  end

