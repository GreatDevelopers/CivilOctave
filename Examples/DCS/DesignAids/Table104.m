# Table D of SP16, Page 10

Table(4).ID = "D";
Table(4).Source = "SP16";
Table(4).Caption = 'Limiting moment of resistance factor for singly reinforced rectangular sections';
Table(4).Clause = [2.3];
Table(4).Header = ["$\\dfrac{M_{u,lim}}{bd^2}$ factor"];

TempM = Table(2).Content' * Material.Conc.f_ck;
TempM = roundx(TempM,2);

# Produce final table
Table(4).Content = [ TempM ];

PrintTable =  [0 Material.Conc.f_ck; Material.Steel.f_y' Table(4).Content];

# To display content of table uncomment following line, else
# comment it by #
#disp('Table 4')
#Table(4).Header
#PrintTable'

# EoF ==========
