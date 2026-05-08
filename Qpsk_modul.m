function symbols = Qpsk_modul(bitSource)
    symbols = zeros(1,length(bitSource)/2);
    for index = 1:2:length(bitSource)
        if bitSource(index)==0 && bitSource(index+1)==0
            symbols((index+1)/2) = exp(1i*pi/4);
        elseif bitSource(index)==0 && bitSource(index+1)==1
            symbols((index+1)/2) = exp(1i*3*pi/4);
        elseif bitSource(index)==1 && bitSource(index+1)==1
            symbols((index+1)/2) = exp(1i*5*pi/4);
        else
            symbols((index+1)/2) = exp(1i*7*pi/4);
        end
    end
end