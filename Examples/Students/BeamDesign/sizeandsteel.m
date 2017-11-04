function[dmin,Rlim,d,D,pt,Astreq,Astmin,AreaOneBar,NoOfBars,Astprov,Spacing] = sizeandsteel(fck,Mu,b,cover,bardia,stirrupdia,fy)

% Mulim = 0.138*fck*b*d*d
%Rlim = Mulim/(b*d*d) = 0.138*fck
Rlim = 0.138*fck;
dmin = sqrt(Mu*1000000/(Rlim*b));
D = ceil(dmin + cover+stirrupdia+(bardia/2));
d = D-cover+stirrupdia+(bardia/2);
pt = [[1-[sqrt(1-((4.6*Mu*1000000)/(fck*b*d*d)))]]*(fck/(2*fy))]*100;
Astreq = (pt*b*d)/100; % in mm^2
Astmin = 0.0012*b*D; % in mm^2
AreaOneBar = (3.14/4)*(bardia)^2; % in mm^2
NoOfBars = ceil(Astreq/AreaOneBar);
Astprov = (3.14/4)*(bardia^2)*NoOfBars;
Spacing = [b-(cover*2)-bardia]/(NoOfBars);
end 