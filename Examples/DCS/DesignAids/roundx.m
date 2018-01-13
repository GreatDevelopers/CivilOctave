# Function to round to fixed places

function[X] = roundx(X,xPlaces)

X = round(X * 10^xPlaces) / 10^xPlaces;

endfunction