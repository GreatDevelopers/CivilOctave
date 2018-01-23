%A = [2 3; 2 4]
%b = [5; 10]

A = A = [3 2 -1 1; 1 -1 -2 4; 2 3 1 -2; 5 -2 3 2]
b = [1; 3; -2; 0;] 

Ba = A;

n = rows(A);
x = [];

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

% Back substitution phase

for k = n:-1:1
  sumTmp = 0;
  for j = k+1:n
    sumTmp = sumTmp + A(k,j) * x(j,1);
  end
  x(k,1) = ( b(k) - sumTmp )/A(k,k);
end

x

Ba * x
