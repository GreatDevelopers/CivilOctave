A = [2 3; 2 4]
b = [5; 10]

%A = A = [3 2 -1 1; 1 -1 -2 4; 2 3 1 -2; 5 -2 3 2]
%b = [1; 3; -2; 0;] 

Ba = A;

n = rows(A)
x = zeros(n,1);

% Elimination phase

for k = 1:n-1
  for i = k+1:n
    lambda = A(i,k)/A(k,k);
    for j = k+1:n
      A(i,j) = A(i,j) - lambda * A(k,j);
    end
    b(i) = b(i) - lambda * b(k);
  end
end

% Back substitution phase"

for k = n:-1:1
  x(k) = ( b(k) - A(k,k+1:n) * x(k+1:n) )/A(k,k);
end

x

Ba * x
