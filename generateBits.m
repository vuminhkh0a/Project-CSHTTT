
function bitSource = generateBits(n)
  rng(0,'twister');
  bitSource = randi([0 1],n,1);

