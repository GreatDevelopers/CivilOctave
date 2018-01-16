# Table C2 of SP16, page 10
Table(3).ID = "C row 2";
Table(3).Source = "SP16";
Table(3).Caption = "Value of $\\dfrac{p_{t,lim}f_y}{f_{ck}}$ for Different Steel Grades";
Table(3).Clause = ["2.3"];
Table(3).Header = ["$\\dfrac{p_{t,lim}f_y}{f_{ck}}$"];

p_tlimfyBYfck = (100 * 0.36 / 0.87) * x_umaxBYd ;
p_tlimfyBYfck = roundx(p_tlimfyBYfck,2);

# Produce final table
Table(3).Content = [p_tlimfyBYfck];

PrintTable = [Material.Steel.f_y'  Table(3).Content'];

# To display content of table uncomment following line, else
# comment it by #

#disp('Table 3')
#Table(3).Header
#PrintTable

# EoF ==========
