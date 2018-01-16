#format short g

# Execute Material.m to get material data
Material

# Openfile
fileID = fopen('DesignTables.tex','w');

# Execute all file of pattern Table10*.m

folder  = pwd;
list    = dir(fullfile(folder, 'Table10*.m'));
nFile   = length(list);
success = false(1, nFile);
for k = 1:nFile
  file = list(k).name;
  try
    run(fullfile(folder, file));
    success(k) = true;
  catch
    fprintf('failed: %s\n', file);
  end
end

tableTex1D(Material.Steel.f_y, Table(1), fileID);

tableTex1D(Material.Steel.f_y, Table(2), fileID);

tableTex1D(Material.Steel.f_y, Table(3), fileID);

tableTex2D(Material.Conc.f_ck, Material.Steel.f_y, Table(4), fileID);

tableTex2D(Material.Conc.f_ck, Material.Steel.f_y, Table(5), fileID);

# Table(6) is 3D

tableTex2D(steelPtShear, Material.Conc.f_ck, Table(7), fileID);

fclose(fileID);

# EoF =======
