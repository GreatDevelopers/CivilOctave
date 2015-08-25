% Program to formulate global stiffness matrix
clc
clear

%% Initialisation [PRE-PROCESSING]

% Follwing are the main variables used. No explaination is given as
%  names are self explanatory.
% Number_of_storeys
% Mass
% Stiffness_story
%  (Summed shear stiffness of all columns in a story)


load input.mat

%Variable initialisation
Stiffness_matrix(Number_of_storeys, Number_of_storeys) = 0;
Time_period(Number_of_storeys, Number_of_storeys) = 0;


%% Display input

Number_of_storeys

Mass

Stiffness_story

%% [PROCESSING]

% Following loop adds local matrices of each element to form Global
% Matrix.

for storey_i = 1:Number_of_storeys

  Stiffness_matrix(storey_i, storey_i) = ...
    Stiffness_story(storey_i);

  if (storey_i < Number_of_storeys )
    Stiffness_matrix(storey_i, storey_i) = ...
      Stiffness_matrix(storey_i, storey_i) + ...
      Stiffness_story(storey_i + 1);
    Stiffness_matrix(storey_i, storey_i + 1) = ...
      - Stiffness_story(storey_i + 1);
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

Number_of_storeys
Stiffness_story

%% Echo processed data

Stiffness_matrix

Eigen_vector
%Omega_square
Frequency
Time_periods
Level_floor
Modal_participation_factor
Gravity_acceleration
Modal_mass
Modal_contribution


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
