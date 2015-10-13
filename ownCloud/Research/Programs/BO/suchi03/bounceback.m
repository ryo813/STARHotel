function y = bounceback(x,v,xbase,xl,xu)
% -------------------------------------------------------------
%   y = bounceback(x,v,xbase,xl,xu)
%
%   Description:
%     Bounce back mechanism is adopted to bring decision
%     variables within limits.
%     Mainly, this function is for DE algorithm to confine
%     the input variables within boundary space.
%
%   Input:
%     x      (1 * M)  :  target vecor
%     v      (1 * M)  :  mutant vector
%     xbase  (1 * M)  :  base-point vector
%     xl     (1 * M)  :  lower-limit vector
%     xu     (1 * M)  :  upper-limit vector
%
%   Output:
%     y      (1 * M)  :  output variables confined
%                           within boundary space
%
%  Coded by Ryosuke YOSHIZAKI, Kyoto Univ., May. 8, 2015
%                                    fixed  Oct. 9, 2015
% -------------------------------------------------------------

% acquiring the variable size
[N1,M1] = size(x);
[N2,M2] = size(x);
[N3,M3] = size(xbase);
[N4,M4] = size(xl);
[N5,M5] = size(xu);

% Exception processing:
%    N1, N2, N3, N4, and N5 should be equal to 1;
%    M1, M2, M3, M4, and M5 should be same size (desined as M).
if sum([N1,N2,N3,N4,N5]) ~= 5
  error('the numbers of row size of argument vectors should be equal to 1.');
elseif (M1 ~= M2) || (M1 ~= M3) || (M1 ~= M4) || (M1 ~= M5)
  error('the numbers of column size of argument vectors should be same size.');
else
  y = zeros(N1,M1);  % initialize output argument
end

% Processing to confine the input variables within boundary space
idx_xl    = find(v < xl);
idx_xu    = find(xu < v);
len_xl    = length(idx_xl);
len_xu    = length(idx_xu);
if len_xl > 0
  v(idx_xl) = xbase(idx_xl) + rand(1,len_xl) .* ( xl(idx_xl) - xbase(idx_xl)  );
end
if len_xu > 0
  v(idx_xu) = xbase(idx_xu) + rand(1,len_xu) .* ( x(idx_xu)  - xu(idx_xu) );
end

% set output argument as mutant vector confiend within boundary space
y = v;