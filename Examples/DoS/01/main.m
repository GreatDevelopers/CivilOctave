% Program to formulate global stiffness matrix
clc
clear

%% Function to write Matrix

function matrixTeX(A, fmt, align)

  disp(['\section{',strrep(inputname(1),'_',' '),'}'])
  [m,n] = size(A);

  if isvector(A)
    myMatrix = 'Bmatrix';
  else
    myMatrix = 'bmatrix';
  end

  if(nargin < 2)

    %
    % Is the matrix full of integers?
    % If so, then use integer output
    %

    if( norm(A-floor(A)) < eps )
      intA = 1;
      fmt  = '%d';
    else
      intA = 0;
      fmt  = '%8.4f';
    end

  end

  fmtstring1 = [' ',fmt,' & '];
  fmtstring2 = [' ',fmt,' \\\\ \n'];

  if(nargin < 3)
    printf('\\[\n\\begin{%s}\n',myMatrix);
  else
    printf('\\[\n\\begin{%s*}[%s]\n',myMatrix,align);
  endif  

  for i = 1:m

    for j = 1:n-1
       printf(fmtstring1,A(i,j));
    end

    printf(fmtstring2, A(i,n));

  end

  if(nargin < 3)
    printf('\\end{%s}\n\\]\n',myMatrix);
  else
    printf('\\end{%s*}\n\\]\n',myMatrix);
  endif  



end

%% Initialisation [PRE-PROCESSING]

% Following are the main variables used. No explanation is given as
%  names are self explanatory.
% Number_of_storeys
% Mass
% Stiffness_storey
%  (Summed shear stiffness of all columns in a storey)
%
% Frequency is vector matrix while Omega is diagonal matrix.
% Time_periods is vector matrix while Time_period is diagonal matrix.


load input.mat

%Variable initialisation
Stiffness_matrix(Number_of_storeys, Number_of_storeys) = 0;
Time_period(Number_of_storeys, Number_of_storeys) = 0;


%% Display input

disp(['\section{Given data} Number of storeys = ',num2str(Number_of_storeys)])
%disp(Number_of_storeys)

matrixTeX(Mass,'%10.4e','r')

%matrixTeX(Stiffness_storey)

%% [PROCESSING]

% Following loop adds local matrices of each element to form Global
% Matrix.

for storey_i = 1:Number_of_storeys

  Stiffness_matrix(storey_i, storey_i) = ...
    Stiffness_storey(storey_i);

  if (storey_i < Number_of_storeys )
    Stiffness_matrix(storey_i, storey_i) = ...
      Stiffness_matrix(storey_i, storey_i) + ...
      Stiffness_storey(storey_i + 1);
    Stiffness_matrix(storey_i, storey_i + 1) = ...
      - Stiffness_storey(storey_i + 1);
    Stiffness_matrix(storey_i + 1, storey_i) = ...
      Stiffness_matrix(storey_i, storey_i + 1);
   endif
    
end

for storey_i = 1 : Number_of_storeys
  Level_floor(storey_i, 1) = ...
    Height_storey(storey_i,1);
  if (storey_i > 1 )
     Level_floor(storey_i, 1) = ...
       Level_floor(storey_i, 1) + ...
     Level_floor(storey_i - 1, 1);
  endif
end

[Eigen_vector, Omega_square] = eig(Stiffness_matrix, Mass);
Omega = sqrt(Omega_square);

for storey_i = 1 : Number_of_storeys
  Time_period(storey_i, storey_i) = 2 * pi() ...
    / sqrt(Omega_square(storey_i, storey_i)); 
end

for storey_i = 1 : Number_of_storeys
  Frequency(storey_i,1) = Omega(storey_i, storey_i);
end

for storey_i = 1 : Number_of_storeys
  Time_periods(storey_i,1) = Time_period(storey_i, storey_i);
end

sum_modal_mass = 0;

for index_k = 1 : Number_of_storeys
  sum_W_Phi = 0;
  sum_W_Phi2 = 0;
  for index_i = 1 : Number_of_storeys
    sum_W_Phi = sum_W_Phi + Mass(index_i, index_i) * ...
      Eigen_vector(index_i, index_k);
    sum_W_Phi2 = sum_W_Phi2 + Mass(index_i, index_i) * ...
      Eigen_vector(index_i, index_k)^2;
  end
  Modal_participation_factor(index_k,1) = sum_W_Phi / sum_W_Phi2;
  Modal_mass(index_k,1) = (sum_W_Phi^2) / (sum_W_Phi2);
  sum_modal_mass = sum_modal_mass + Modal_mass(index_k,1);  
end

Modal_contribution = 100 / sum_modal_mass * Modal_mass;

%% [POST-PROCESSING]

%% Echo input data

%Number_of_storeys
%Stiffness_storey

%% Echo processed data

matrixTeX(Stiffness_matrix,'%10.4e','r')
matrixTeX(Eigen_vector,'%10.4e','r')
matrixTeX(Omega_square,'%10.4e','r')
matrixTeX(Frequency,'%10.4e','r')
matrixTeX(Time_periods,'%10.4e','r')
matrixTeX(Level_floor,'%10.4e','r')
matrixTeX(Modal_participation_factor,'%10.4e','r')

disp(['g = ', num2str(Gravity_acceleration)])

matrixTeX(Modal_mass,'%10.4e','r')
matrixTeX(Modal_contribution,'%10.4e','r')

%% Plot mode shapes

plotHangle = figure('visible', 'off')

plot([0; Eigen_vector(:,1)], [0; Level_floor],'-ro')
hold on
plot([0; Eigen_vector(:,2)], [0; Level_floor],'-go')
plot([0; Eigen_vector(:,3)], [0; Level_floor],'-bo')
plot([0; Eigen_vector(:,4)], [0; Level_floor],'-mo')
plot([0 0], [0 Level_floor(Number_of_storeys)],'-k')
hold off

% saveas(plotHangle, 'ModeShape.eps','eps')
print (plotHangle, '-color',  'ModeShape.eps')
saveas(plotHangle, 'ModeShape.png','png')
saveas(plotHangle, 'ModeShape.pdf')

% End of file
