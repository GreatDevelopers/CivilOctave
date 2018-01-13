Table(1).ID = "B";
Table().Source = "SP16";
Table().Caption = "Caption ..";
Table().Clause = [2.2 3.5];
TempData = ["fy"; "x_umaxBYd";];

xmBYd = (0.87 * Material.Steel.f_y) / Material.Steel.E_s;
xmBYd = roundx(xmBYd,3);

# Produce final table

Table().Content = [ Material.Steel.f_y' xmBYd' ];


# To display content of table uncomment following line, else
# comment it by #
Table().Content

