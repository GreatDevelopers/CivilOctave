# Table B of SP16, page 9
Table(1).ID = "B";
Table(1).Source = "SP16";
Table(1).Caption = "Value of x_umax/d for different steel grades ";
Table(1).Clause = [2.2];
Table(1).Header = ["x_umax/d"];

x_umaxBYd = (0.87 * Material.Steel.f_y) / Material.Steel.E_s;
x_umaxBYd = 0.0035 * (1./(0.0055 + x_umaxBYd));
x_umaxBYd = roundx(x_umaxBYd,3);

# Produce final table
Table(1).Content = [x_umaxBYd];

PrintTable = [Material.Steel.f_y'  Table(1).Content'];

# To display content of table uncomment following line, else
# comment it by #
disp('Table 1')
Table(1).Header
PrintTable

# EoF ==========
