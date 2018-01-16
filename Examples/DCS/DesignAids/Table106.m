# Table 1-4 of SP16, Page 47-50

Table(6).ID = "1-4";
Table(6).Source = "SP16";
Table(6).Caption = 'Reinforcement Percentage $p_t$ for Singly Reinforced Sections';
Table(6).Clause = ["???"];
Table(6).Header = ["$p_t$"];

fckT =  Material.Conc.f_ck;
fyT = Material.Steel.f_y;

iI = columns(fckT);
jJ = columns(fyT);
kK = columns(steelpt);

for i = 1:iI
 for j = 1:jJ
  maxPt = interp2(fckT, fyT, Table(5).Content,fckT(i),fyT(j));

   for k = 1:kK
     if ( steelpt(k) > maxPt )
       MuBYbd2(i,j,k) = NaN;
     else
       MuBYbd2(i,j,k) = 0.87 * fyT(j) * steelpt(k)/100. * ...
       ( 1. - 1.005 * fyT(j)/fckT(i) * steelpt(k)/100. );
     end
   end  

 end
end

# Produce final table
Table(6).Content = [ MuBYbd2 ];

# PrintTable =  [0 Material.Conc.f_ck; Material.Steel.f_y' Table(6).Content];

# To display content of table uncomment following line, else
# comment it by #
#disp('Table 4')
#Table(6).Header
#PrintTable'

# EoF ==========
