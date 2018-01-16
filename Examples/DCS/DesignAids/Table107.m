# Table 61 of SP16, Page 178

Table(7).ID = "61";
Table(7).Source = "SP16";
Table(7).Caption = 'Design Shear Strength of Concrete, ${\tau}_c$, $N/mm^2$';
#Table(7).Clause = [40.2 40.3 40.4 40.5 41.3 41.3 41.4];
Table(7).Clause = ["40.2.1" "40.2.2" "40.3" "40.4" "40.5.3" "41.3.2" "41.3.3" "41.4.3"];
Table(7).Header = ["${\tau}_c$"];

steelPtShear = [.15:.05:3];
steelPtShear = [.1 steelPtShear 4 6];

Material.Conc.N = columns(Material.Conc.f_ck);

NConcGrade = Material.Conc.N;

for i = 1:NConcGrade
   fckT = Material.Conc.f_ck(i);
  for ptIndex = 1:columns(steelPtShear)
    betaT = 0.8 * fckT / (6.89 * steelPtShear(ptIndex) );
    if (betaT < 1.)
      betaT = 1.0;
    end
    tmpAT = sqrt(1 + 5.*betaT) - 1.0 ;
    TempM(i,ptIndex) = 0.85 * sqrt(.8*fckT) * tmpAT; 
    TempM(i,ptIndex) = TempM(i,ptIndex) / ( 6. * betaT); 
 end
end

TempM = roundx(TempM,3);

# Produce final table
Table(7).Content = [ TempM ];

# PrintTable =  [0 Material.Conc.f_ck; steelPtShear' Table(7).Content];

# To display content of table uncomment following line, else
# comment it by #
#disp('Table 7pp')
#Table(7).Header
# PrintTable'

# EoF ==========
