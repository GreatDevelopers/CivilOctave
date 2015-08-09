% Program to formulate global stiffness matrix
clc
clear

%% Initialization [PRE-PROCESSING]

% nn: Number of nodes
% ne: Number of Elements
% K: Global stiffness matrix
% k: Local stiffness matrix
% P: Load matrix
% nc: Nodal matrix (Information on nodes correspinding to each elements)


nn=5; % Enter number of nodes
ne=4; % Enter number of elements

K(nn,nn)=0; %Variable initialization
F(nn,1)=0;  % -same- 

%Node numbers for each element in row form
nc=[1 2; 2 3; 3 4; 4 5]

% Spring constants in column form
k=[100 100 100 100 ]'

%Load matrix in column form
P=[0 0 -20 -30 30]'


%% [PROCESSING]


%Following loop adds local matrices of each element to form Global
%Matrix (K), and F the global force matrix

for e=1:ne
    
    i=nc(e,1);
    j=nc(e,2);
    ks=k(e)*[1 -1;-1 1];
    
    K(i,i)=ks(1,1)+K(i,i);
    K(i,j)=ks(1,2)+K(i,j);
    K(j,i)=ks(2,1)+K(j,i);
    K(j,j)=ks(2,2)+K(j,j);

end

%% [POST-PROCESSING]

K % Global stiffness matrix
P % GLobal force vector