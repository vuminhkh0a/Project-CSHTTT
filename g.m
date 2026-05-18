%calculate g to simulate rayleigh channel
function g_i = g(b, f_m, N_i, t)
  g_i = zeros(size(t));
  n = 1:N_i;
  c = sqrt(2*b/N_i);
  f = f_m*sin(pi/(2*N_i)*(n-1/2));
  theta = 2*pi*rand(size(f));
  for index = 1:N_i
    g_i = g_i + c*cos(2*pi*f(index).*t + theta(index));
  endfor



