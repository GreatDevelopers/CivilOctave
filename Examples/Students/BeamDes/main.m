%Design of beam using octave 
clc
clear

%Type of units used in design

 fprintf("all dimension in newton and mm\n")

%input files that are needed to further processing of beam design
load given_data.mat
load tables.mat
beam

%calculation for effective depth
disp('effective depth=overall depth-effective cover')

fprintf("\n");

eff_depth=(beam.depth-beam.clear_cover-(beam.main_dia/2))

%limiting moment for singly reinforced beam for same dimension
fprintf("\n");

disp('limiting moment= 0.36*fck*xu*b(d-0.416xu)')
fprintf("\n");


Mu_lim_factor=interp2(table,table,table,beam.fy,beam.fck)

Mu_lim = Mu_lim_factor * (beam.width*eff_depth^2);

Mu_lim 
disp('Mu = ') 
disp(beam.factored_moment)

%factored moment by applied loading
Mu_factor=beam.factored_moment/(beam.width*eff_depth^2);
disp('if real moment is more than limiting moment then it is doubly case otherwise singly case');

isDouble = 9; 

% Something differrent

if (Mu_factor > Mu_lim_factor) 
  AisDouble = 1;
  fprintf("This is designed as doubly reinforced section\n");
else 
  isDouble = 0;
  fprintf("This is designed as singly reinforced\n");
end 

fprintf("\n");

 %effective cover to depth ratio = d
 d=(beam.clear_cover+beam.main_dia/2)/eff_depth;
 
 %Ratio of effective cover to depth ratio =D
 D=[.05 .10 .15 .20];
 
 %percentage tensile reinforcement
 pt=interp2(tensile_reinforcement,tensile_reinforcement,...
            tensile_reinforcement,d,Mu_factor);
 
%Area of steel on tensile and compressive side            
 Area_of_tensile_steel=(pt*beam.width*eff_depth/100)
 
 fprintf("\n");
 
%number of bars required 

 disp('number of bars=total area of steel/area of one bar')
 Area_of_one_bar=(pi*beam.main_dia^2/4); 
 
 Number_of_tensile_bars=ceil(Area_of_tensile_steel/Area_of_one_bar)
 fprintf("\n");
 
 if (isDouble == 1) 
 pc=interp2(compression_reinforcement,compression_reinforcement,...
            compression_reinforcement,d,Mu_factor);
                      
 Area_of_compression_steel=(pc*beam.width*eff_depth/100)
 
 fprintf("\n");
 Number_of_compression_bars=ceil(Area_of_compression_steel/Area_of_one_bar)
 endif
 %Nominal shear stress 
 disp('nominal shear stress= shear force/(width*depth)')
 Tv=beam.shear/(beam.width*eff_depth)
 
%Design shear strength of concrete 
 x=beam.fck;
 y=(100*Area_of_tensile_steel/(beam.width*eff_depth));
 disp('design shear strength:')
 Tc=interp2(design_shear_stress,design_shear_stress,...
            design_shear_stress,x,y)
 Tcmax=interp1(max_shear_stress(:,1),max_shear_stress(:,2),x)
 
 %Suppose two legged stirrup of 8mm dia
 area_of_stirrup=(2*pi*beam.stirrup_dia^2/4)
 
 %Spacing of stirrup
 disp('spacing of stirrup=0.87*fy*area*diameter/unbalanced shear')
 if (Tv>Tc) && (Tv<Tcmax)
   Vus=(Tv-Tc)*beam.width*eff_depth;
   sv=(.87*beam.fy*area_of_stirrup*beam.stirrup_dia/Vus)
 else
   sv=(area_of_stirrup*.87*beam.fy/(.4*beam.width))
 end
 
 if sv>300
     sv=min(.75*eff_depth,300)
 end
   
 %Developement length of bars
 disp('bond stress of bar:')
 Tbd=interp1(bond_stress(:,1),bond_stress(:,2),beam.fck)*1.6;
 disp('developement length=0.87*dia*fy/(4*bond stress)')
 Ld=(beam.main_dia*.87*beam.fy/(4*Tbd))
