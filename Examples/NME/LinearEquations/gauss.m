function [x,det] = gauss(A,b)

% Solves A*x = b by Gauss elimination and computes det(A).
% USAGE: [x,det] = gauss(A,b)

if size(b,2) > 1; b = b'; end % b must be column vector
n = length(b);

for k = 1:n-1
  % Elimination phase
  for i= k+1:n
    if A(i,k)  ~= 0
      lambda = A(i,k)/A(k,k);
      A(i,k+1:n) = A(i,k+1:n) - lambda*A(k,k+1:n);
      b(i)= b(i) - lambda*b(k);
    end
  end
end

if nargout == 2; det = prod(diag(A)); end

for k = n:-1:1
  % Back substitution phase
  b(k) = (b(k) - A(k,k+1:n)*b(k+1:n))/A(k,k);
end
x = b;

