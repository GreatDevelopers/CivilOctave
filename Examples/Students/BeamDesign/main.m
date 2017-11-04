% Design of Singly Reinforced Beam
disp('Assume b and D')
span = 6
supportwidth = 230 
b = 250
D = (span*1000)/10
cover = 30
fy = 415
fck = 25
ConcDensity = 25;
d = D-cover
l = min(span , (span-(supportwidth/1000)+(d/1000)))
AdditionalDeadLoad = 5; % in KN/m
SelfWeight = ConcDensity*(b/1000)*(D/1000)
DL = AdditionalDeadLoad + SelfWeight
LL = input('Enter the Live Load Acting on Beam is')
wu = (1.5*(DL + LL))
Mu = ((wu*l*l)/8)
disp('CALCULATE d, D, b and Area of Steel')
bardia = 25;
stirrupdia = 8;
[dmin,Rlim,d,D,pt,Astreq,Astmin,AreaOneBar,NoOfBars,Astprov,Spacing] = sizeandsteel(fck,Mu,b,cover,bardia,stirrupdia,fy)

disp('CHECK FOR FLEXURE')
ptprov = (100*Astprov)/(b*d)
Mur = 0.87*fy*(ptprov/100)*[1-((fy/fck)*(ptprov/100))]*b*d*d
if Mu*1000000 < Mur
  disp('SECTION IS SAFE AS FLEXURAL STREMGTH IS SUFFICIENT')
END
%disp('CHECK FOR DEFLECTION')
%fs = 0.58*fy*(Astreq/Astprov)
%Kc =1;
%Kt = 1.014
%Ltodmax = 20*Kt*Kc
%Ltodprov = (l*1000)/d
%if Ltodprov < Ltodmax
 % disp('SAFE IN DEFLECTION')
%else
 % disp('FAIL IN DEFLECTION')
%end