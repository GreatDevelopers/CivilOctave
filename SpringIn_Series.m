% Program to formulate global stiffness matrix
clc
clear

%% Initialisation [PRE-PROCESSING]

% Follwing are the main variables used. No explaination is given as
%	names are self explanatory.
% Number_of_nodes nn
% Number_of_Elements ne
% Global_stiffness_matrix K
% Local_stiffness_matrix k
% Load_matrix P
% Element_Incidences nc: Nodal matrix
%	(Information on nodes correspinding to each elements)


Number_of_nodes = 5; % Enter number of nodes
Number_of_Elements = 4; % Enter number of elements

% Node numbers for each element in row form
Element_Incidences = [1 2; 2 3; 3 4; 4 5]

% k: Spring constants in column form
Local_stiffness_matrix = [100 100 100 100 ]'

%Load matrix in column form
Load_matrix = [0 0 -20 -30 30]'

%Variable initialisation
Global_stiffness_matrix(Number_of_nodes,Number_of_nodes) = 0;
% F(Number_of_nodes,1) = 0; % *** rm it ***


%% [PROCESSING]


% Following loop adds local matrices of each element to form Global
% Matrix.

%, and F the global force matrix  *** rm it ***
 
for element_i = 1:Number_of_Elements
    
    i = Element_Incidences(element_i,1);
    j = Element_Incidences(element_i,2);
    ks = Local_stiffness_matrix(element_i)*[1 -1;-1 1];
    
    Global_stiffness_matrix(i,i) = ks(1,1) + Global_stiffness_matrix(i,i);
    Global_stiffness_matrix(i,j) = ks(1,2) + Global_stiffness_matrix(i,j);
    Global_stiffness_matrix(j,i) = ks(2,1) + Global_stiffness_matrix(j,i);
    Global_stiffness_matrix(j,j) = ks(2,2) + Global_stiffness_matrix(j,j);

end

%% [POST-PROCESSING]

Global_stiffness_matrix % Global stiffness matrix
Load_matrix % GLobal force vector