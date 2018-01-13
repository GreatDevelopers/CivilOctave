# Execute Material.m to get material data

Material

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

# EoF =======
