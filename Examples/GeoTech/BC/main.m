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


q=Unit_weight_of_soil*Depth_of_foundation;

Nphi= (tand(45 + phi/2))^2;
function rectangle
  load input.mat
load datafile.mat
  phiPrime = atand(0.67 * tand(phi));
NcPrime = interp1(Bearing_capacity_factors(:,1), ...
  Bearing_capacity_factors(:,2), phiPrime);
NqPrime = interp1(Bearing_capacity_factors(:,1), ...
  Bearing_capacity_factors(:,3), phiPrime);
NgPrime = interp1(Bearing_capacity_factors(:,1), ...
  Bearing_capacity_factors(:,4), phiPrime); 


q=Unit_weight_of_soil*Depth_of_foundation;

 Nphi= (tand(45 + phi/2))^2; 
  for i=1:4
    Sq(i)=1.0+0.2*Width_of_foundation(i)/Length_of_foundation;
    Sc(i)=1.0+0.2*Width_of_foundation(i)/Length_of_foundation;
    Sg(i)=1.0-0.4*Width_of_foundation(i)/Length_of_foundation;
    
  
    Dc(i)= 1+(0.2)*(Depth_of_foundation/Width_of_foundation(i))*sqrt(Nphi);
    if (phi<10);
      Dq=Dg=1;
    elseif (phi>10);
      Dq(i)=(1+(0.1)*(Depth_of_foundation/Width_of_foundation(i))*sqrt(Nphi));
      Dg(i)=(1+(0.1)*(Depth_of_foundation/Width_of_foundation(i))*sqrt(Nphi));
    endif
      ic= ( 1 - alpha/90)^2;
      ig= ( 1- alpha/phi)^2;
      iq= ( 1 - alpha/90)^2;
 
 
    if(Dw>=(Depth_of_foundation+Width_of_foundation(i)));
      W=1;
    elseif(Dw<=Depth_of_foundation);
      W= 0.5;
 
    elseif(Depth_of_foundation<Dw<(Depth_of_foundation+Width_of_foundation(i)));
      y(i)=0.5+[0.5*(Dw-Depth_of_foundation)]/[Width_of_foundation(i)];
      W(i)=y(i);
    end
 
    qdprime(i)= 0.66*Cohesion*NcPrime*Sc(i)*Dc(i)*ic+ q*(NqPrime-1)*Sq(i)*Dq(i)*iq + 0.5*Width_of_foundation(i)*Gamma*NgPrime*Sg(i)*Dg(i)*ig*W(i);
    Safe_Net_Allowable_Bearing_Capacity(i) = qdprime(i)/2.5;
    qdprimespt(i)= q*(NqPrime-1)*Dq(i)*iq*Sq(i)+ 0.5*Width_of_foundation(i)*Gamma*NgPrime*Sg(i)*Dg(i)*ig;
    Safe_Net_Allowable_Bearing_Capacityspt(i) = qdprimespt(i)/2.5;
   
    if (Safe_Net_Allowable_Bearing_Capacity(i))<(Safe_Net_Allowable_Bearing_Capacityspt(i));
      a=Safe_Net_Allowable_Bearing_Capacity(i)
    elseif(Safe_Net_Allowable_Bearing_Capacity(i))>(Safe_Net_Allowable_Bearing_Capacityspt(i));
      b=Safe_Net_Allowable_Bearing_Capacityspt(i)
    end
   endfor
  % Output
ic
iq
ig
Dc
Dq
Dg
Sc
Sq
Sg
phiPrime
NcPrime
NqPrime
NgPrime
qdprime
Safe_Net_Allowable_Bearing_Capacity
qdprimespt
Safe_Net_Allowable_Bearing_Capacityspt
 
 endfunction

switch (shape)
  case "rectangle"
    rectangle();
    break;
  case "strip"
   Sq=1;
   Sc=1;
   Sg=1;
  case "circle"
   Sq=1.2;
   Sc=1.3;
   Sg=0.6;

   otherwise
   Sq=1.2;
   Sc=1.3;
   Sg=0.8;
endswitch   
   
for i=1:4
  Dc(i)= 1+(0.2)*(Depth_of_foundation/Width_of_foundation(i))*sqrt(Nphi);
  if (phi<10);
    Dq=Dg=1;
  elseif (phi>10);
    Dq(i)=(1+(0.1)*(Depth_of_foundation/Width_of_foundation(i))*sqrt(Nphi));
    Dg(i)=(1+(0.1)*(Depth_of_foundation/Width_of_foundation(i))*sqrt(Nphi));
  endif
  ic= ( 1 - alpha/90)^2;
  ig= ( 1- alpha/phi)^2;
  iq= ( 1- alpha/90)^2;
 
 
  if(Dw>=(Depth_of_foundation+Width_of_foundation(i)));
    W=1;
  elseif(Dw<=Depth_of_foundation);
    W= 0.5;
 
  elseif(Depth_of_foundation<Dw<(Depth_of_foundation+Width_of_foundation(i)));
    y(i)=0.5+[0.5*(Dw-Depth_of_foundation)]/[Width_of_foundation(i)];
    W(i)=y(i);
  endif
  qdprime(i)= 0.66*Cohesion*NcPrime*Sc*Dc(i)*ic+ q*(NqPrime-1)*Sq*Dq(i)*iq + 0.5*Width_of_foundation(i)*Gamma*NgPrime*Sg*Dg(i)*ig*W(i);
  Safe_Net_Allowable_Bearing_Capacity(i) = qdprime(i)/2.5;
  qdprimespt(i)= q*(NqPrime-1)*Dq(i)*iq*Sq+ 0.5*Width_of_foundation(i)*Gamma*NgPrime*Sg*Dg(i)*ig;
  Safe_Net_Allowable_Bearing_Capacityspt(i) = qdprimespt(i)/2.5;

  if (Safe_Net_Allowable_Bearing_Capacity(i))<(Safe_Net_Allowable_Bearing_Capacityspt(i));
    a=Safe_Net_Allowable_Bearing_Capacity(i)
  elseif(Safe_Net_Allowable_Bearing_Capacity(i))>(Safe_Net_Allowable_Bearing_Capacityspt(i));
    b=Safe_Net_Allowable_Bearing_Capacityspt(i)
  endif
end


% Output
ic
iq
ig
Dc
Dq
Dg
Sc
Sq
Sg
phiPrime
NcPrime
NqPrime
NgPrime
qdprime
Safe_Net_Allowable_Bearing_Capacity
qdprimespt
Safe_Net_Allowable_Bearing_Capacityspt

% End of file
