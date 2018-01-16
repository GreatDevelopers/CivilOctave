# Concrete

steelpt = 0:.1:6;

Material.Conc.f_ck = [15 20 25 30 35 40 45 50 55];

Material.Conc.FactorFcr_fck = 0.7;
Material.Conc.FactorE_c = 5000;

Material.Conc.f_cr = Material.Conc.FactorFcr_fck * sqrt(Material.Conc.f_ck);
Material.Conc.E_c = Material.Conc.FactorE_c* sqrt(Material.Conc.f_ck);
 

# Steel

Material.Steel.f_y = [240 250 415 500 550];
Material.Steel.E_s = 200000;
