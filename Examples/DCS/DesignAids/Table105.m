# Table E of SP16, Page 10

Table(5).ID = "E";
Table(5).Source = "SP16";
Table(5).Caption = 'Maximum Percentage of Tensile Reinforcement $p_{t,lim}$  for Singly Reinforced Rectangular Sections';
Table(5).Clause = ["2.3"];
Table(5).Header = ["$p_{t,lim}"];

TempM = Table(3).Content ./ Material.Steel.f_y;
TempM = TempM' * Material.Conc.f_ck;
TempM = roundx(TempM,2);

# Produce final table
Table(5).Content = [ TempM ];

PrintTable =  [0 Material.Conc.f_ck; Material.Steel.f_y' Table(5).Content];

# To display content of table uncomment following line, else
# comment it by #
#disp('Table 5')
#Table(5).Header
#PrintTable'

# EoF ==========
