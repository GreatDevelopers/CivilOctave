# Table C1 of SP16, page 10
Table(2).ID = "C row 1";
Table(2).Source = "SP16";
Table(2).Caption = "Value of M_u,lim/fck bd^2 for different steel grades";
Table(2).Clause = [2.3];
Table(2).Header = ["M_u,lim/fck bd^2"];

M_ulimBYbd2 = (0.36 * x_umaxBYd) .* (1 - 0.416 * x_umaxBYd);
M_ulimBYbd2 = roundx(M_ulimBYbd2,3);

# Produce final table
Table(2).Content = [M_ulimBYbd2];

PrintTable = [Material.Steel.f_y'  Table(2).Content'];

# To display content of table uncomment following line, else
# comment it by #

disp('Table 2')
Table(2).Header
PrintTable

# EoF ==========
