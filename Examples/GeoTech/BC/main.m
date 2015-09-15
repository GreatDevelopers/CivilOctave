% Program to claculate Bearing Capacity
clc
clear

%% Initialisation [PRE-PROCESSING]

% Following are the main variables used. No explanation is given as
%	names are self explanatory.
%

load input.mat
load dataFile.mat

%Variable initialisation
%Global_stiffness_matrix(Number_of_nodes,Number_of_nodes) = 0;

%% [PROCESSING]

phiPrime = atand(0.67 * tand(phi));
NcPrime = interp1(Bearing_capacity_factors(:,1), ...
  Bearing_capacity_factors(:,2), phiPrime);
NqPrime = interp1(Bearing_capacity_factors(:,1), ...
  Bearing_capacity_factors(:,3), phiPrime);
NgPrime = interp1(Bearing_capacity_factors(:,1), ...
  Bearing_capacity_factors(:,4), phiPrime);
  
% Output
phiPrime
NcPrime
NqPrime
NgPrime

% End of file
