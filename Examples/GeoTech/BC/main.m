
clc
clear



load input.mat
load dataFile.mat




phiPrime = atand(0.67 * tand(phi));
NcPrime = interp1(Bearing_capacity_factors(:,1), ...
  Bearing_capacity_factors(:,2), phiPrime);
NqPrime = interp1(Bearing_capacity_factors(:,1), ...
  Bearing_capacity_factors(:,3), phiPrime);
NgPrime = interp1(Bearing_capacity_factors(:,1), ...
  Bearing_capacity_factors(:,4), phiPrime);
 


phiPrime
NcPrime
NqPrime
NgPrime

NPhie= tand(45+phi/2)^2

Dc= 1+.2*(Depth_of_foundation/width_of_foundation)*sqrt(NPhie)



if(phi<10)
disp("Dq=Dg=1");
elseif(phi>10)
Dq=(1+(0.1)*(Depth_of_foundation/width_of_foundation)*sqrt(NPhie))
Dg=(1+(0.1)*(Depth_of_foundation/width_of_foundation)*sqrt(NPhie))
%Dq=Dg=disp(Dq=Dg);

endif

Ic=(1-(incination_of_load_to_vertical/90))^2

Iq=(1-(incination_of_load_to_vertical/90))^2

Ig=(1-(incination_of_load_to_vertical/phi))^2
if(Dw>=(Depth_of_foundation+width_of_foundation))
W=1
elseif(Dw<=Depth_of_foundation)
W=.5
elseif(Depth_of_foundation<Dw<Depth_of_foundation+width_of_foundation)
W=y1+(x-x1)*(y2-y1)/(x2-x1)
endif
Effective_surcharge_at_baselevel = Gamma*Depth_of_footing

Sc=Shape_factor(1,1)
Sq=Shape_factor(1,2)
Sg=Shape_factor(1,3)



Ultimate_shear_failure = (.66*Cohesion*NcPrime*Sc*Dc*Ic+Effective_surcharge_at_baselevel*(NqPrime-1)*Sq*Dq*Iq+.5*width_of_foundation*Gamma*NgPrime*Sg*Dg*Ig*W)


Safe_net_allowable_bearing_capacity= Ultimate_shear_failure/2.5
