% Program to formulate global stiffness matrix
clc
clear

%% Initialisation [PRE-PROCESSING]

% Follwing are the main variables used. No explaination is given as
%	names are self explanatory.
% Number_of_storeys
% Mass
% Stiffness_story
%	(Summed shear stiffness of all columns in a story)


load input.mat

%Variable initialisation
Stiffness_matrix(Number_of_storeys, Number_of_storeys) = 0;

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

[EigenVector, EigenValue] = eig(Stiffness_matrix, Mass);

%% [POST-PROCESSING]

%% Echo input data

Number_of_storeys
Stiffness_story

%% Echo processed data

Stiffness_matrix

EigenVector
EigenValue

% End of file
