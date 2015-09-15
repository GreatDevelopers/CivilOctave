% Program to formulate global stiffness matrix
clc
clear

%% Initialisation [PRE-PROCESSING]

% Following are the main variables used. No explanation is given as
%	names are self explanatory.
% Number_of_nodes
% Number_of_elements
% Global_stiffness_matrix
% Local_stiffness_matrix
% Load_matrix
% Element_incidences
%	(Information on nodes correspinding to each elements)


load input.mat

%Variable initialisation
Global_stiffness_matrix(Number_of_nodes,Number_of_nodes) = 0;

%% [PROCESSING]

% Following loop adds local matrices of each element to form Global
% Matrix.

for element_i = 1:Number_of_elements
    
    i = Element_incidences(element_i,1);
    j = Element_incidences(element_i,2);
    ks = Local_stiffness_matrix(element_i)*[1 -1;-1 1];
    
    Global_stiffness_matrix(i,i) = ks(1,1) + Global_stiffness_matrix(i,i);
    Global_stiffness_matrix(i,j) = ks(1,2) + Global_stiffness_matrix(i,j);
    Global_stiffness_matrix(j,i) = ks(2,1) + Global_stiffness_matrix(j,i);
    Global_stiffness_matrix(j,j) = ks(2,2) + Global_stiffness_matrix(j,j);

end

%% [POST-PROCESSING]

%% Echo input data

Number_of_elements
Number_of_nodes
Element_incidences
Local_stiffness_matrix
Load_matrix

Global_stiffness_matrix % Global stiffness matrix
%Load_matrix % GLobal force vector

% End of file
