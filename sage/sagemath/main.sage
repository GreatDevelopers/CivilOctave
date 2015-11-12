"""@package docstring
This module contain code to process the data
obtain from input.sage
"""


def funSaog(soilType, timePrd):
  """
  function to pick values according to
  type of soil selected
  ...
  """
  t1 = 0; t2 = 0; t3 = 0; t4 = 0
  eq3num = 0
  t2 = 0.10
  if(soilType=='I'):
      t3 = 0.40; eq3num = 1.0
  elif (soilType=='II'):
      t3 = 0.55; eq3num = 1.36
  elif(soilType=='III'):
      t3 = 0.67; eq3num = 1.67
  else:
      Print('Unexpected soil type')
  if (timePrd < t2):
      sag = 1. + 15 * timePrd
  elif(timePrd > t3):
      sag = eq3num / timePrd
  else:
      sag = 2.5
  return sag

"""main program ... """
#loading input variables from input.sage
load('input.sage')
#changing style of brackets for latex output
latex.matrix_delimiters("[","]")

#converting mass in diagonal matrix
Mass=matrix(Number_of_storeys,Number_of_storeys)
for i in range(Number_of_storeys):
    for j in range(Number_of_storeys):
        if(i==j):
            Mass[i,j]=mass[j,0]
        else:
            Mass[i,j]=0
#calculating level of floors from its height
Level_floor=zero_matrix(RR,Number_of_storeys,1)
for storey_i in range(Number_of_storeys):
    Level_floor[storey_i,0] = Height_storey[storey_i,0]
    if(storey_i>0):
        Level_floor[storey_i,0]=(
        Level_floor[storey_i,0]+Level_floor[storey_i-1,0])

#calcutaing stiffness matrix from stiffness of storeys
Stiffness_matrix=zero_matrix(QQ,Number_of_storeys,Number_of_storeys)
for storey_i in range(Number_of_storeys):
	Stiffness_matrix[storey_i, storey_i] = Stiffness_storey[storey_i][0]
	if (storey_i < Number_of_storeys-1):
		Stiffness_matrix[storey_i, storey_i]=(
			Stiffness_matrix[storey_i, storey_i] +
			Stiffness_storey[storey_i + 1][0])
		Stiffness_matrix[storey_i, storey_i + 1]=(
		-Stiffness_storey[storey_i + 1][0])
		Stiffness_matrix[storey_i + 1, storey_i]=(
		Stiffness_matrix[storey_i, storey_i + 1])
#calculating eginvalues
w=var('w')
q=Stiffness_matrix-(w^2)*Mass
A=Stiffness_matrix*Mass.inverse()
Omega_square=A.eigenvalues()

#calculating W and time period
Omega=zero_matrix(RR,Number_of_storeys,1)
Time_period=zero_matrix(RR,Number_of_storeys,1)
for i in range( Number_of_storeys):
	q=sqrt(Omega_square[i])
	Omega[i,0]=n(q)
	Time_period[i,0]=n(2*pi)/q
#Frequency=list()
#for storey_i in range(Number_of_storeys):
	#Frequency.append(sqrt(Omega_square[storey_i].n(digits=4)))
#calculating egin vectors
z=A.eigenvectors_left()

J=zero_matrix(RR,Number_of_storeys,1)
X=zero_matrix(RR,Number_of_storeys,Number_of_storeys)
for x in range(Number_of_storeys):
	q=matrix(z[x][1][0])
	mid=q*Mass*q.transpose()
	J[x,0]=n(mid[0][0])
	X[x]=matrix(q/sqrt(abs(J[x])))
#ModesContributionX = 0;
#Number_of_modes_to_be_considered = 0;
#for Number_of_modes_to_be_considered in range(Number_of_storeys):
	#ModesContributionX = ModesContributionX+Modal_contribution(Number_of_modes_to_be_considered);
 	#if (ModesContributionX > 90):
 		#break;

#calculating Modal participation factor ,sum of modal mass
#and modal mass
Modal_participation_factor=zero_matrix(RR,Number_of_storeys,1)
Modal_mass=zero_matrix(RR,Number_of_storeys,1)
sum_modal_mass=0
for j in range(Number_of_storeys):
        P1,P2=0,0
        m=X[j,:]
        for i in range(Number_of_storeys):
            P1=P1+Mass[i][i]*m[0][i]
            P2=P2+Mass[i][i]*(m[0][i])**2
        Modal_participation_factor[j,0]=P1/P2
        Modal_mass[j,0]=(P1)**2/(P2)
        sum_modal_mass = sum_modal_mass + Modal_mass[j,0]
XX=X.transpose()
#calculating modal contribution of each storey
Modal_contribution=zero_matrix(RR,Number_of_storeys,1)
for i in range(Number_of_storeys):
	Modal_contribution[i,0]=((100 / sum_modal_mass )*Modal_mass[i,0]).n(digits=4)

#getting type of soil and dependent variables
Type_of_soil=''
for i in range (Soil_type):
   Type_of_soil = Type_of_soil+'I'
Sa_by_g=zero_matrix(RR,Number_of_storeys,1)
A_h=zero_matrix(RR,Number_of_storeys,Number_of_storeys)
for index_time in range(Number_of_storeys):
	Sa_by_g[index_time,0] = funSaog(
	Type_of_soil, Time_period[index_time,0])
 	A_h[index_time,1]= (
 	Zone_factor/2*Importance_factor/
 	Response_reduction_factor * Sa_by_g[index_time,0])

#calculating design lateral force


Design_lateral_force=zero_matrix(RR,Number_of_storeys,Number_of_storeys)
for index_i in range(Number_of_storeys):
    q=Mass*XX[:,index_i]
    z=q*matrix(A_h[index_i]*Modal_participation_factor[index_i,0]*
    Gravity_acceleration)
    Design_lateral_force[: , index_i]=z[:,1]


#calculating Peak shear force
Peak_shear_force = zero_matrix(RR,Number_of_storeys, Number_of_storeys)
for index_j in range(Number_of_storeys):
	for index_i in range(Number_of_storeys):
		for index_k in range(Number_of_storeys - index_i ):
			Peak_shear_force[index_i,index_j]=(
			Design_lateral_force[index_k + index_i,index_j] +
			 Peak_shear_force[index_i,index_j])


#storey shear force for all modes
Storey_shear_force = zero_matrix(RR,Number_of_storeys,1)
Storey_shear_force2 = zero_matrix(RR,Number_of_storeys,1)
if (Modes_considered == 0):
  Modes_considered = Number_of_modes_to_be_considered
for index_i in range(Number_of_storeys):
    for index_j in range(Modes_considered):
        Storey_shear_force[index_i,0]=(Storey_shear_force[index_i,0]+
        abs(Peak_shear_force[index_i,index_j]))
        Storey_shear_force2[index_i,0]=(Storey_shear_force2[index_i,0]+
        Peak_shear_force[index_i,index_j]^2)
    Storey_shear_force2[index_i,0] = sqrt(Storey_shear_force2[index_i,0])
P=zero_matrix(RR,Number_of_storeys,Number_of_storeys)
B=zero_matrix(RR,Number_of_storeys,Number_of_storeys)
for i in range(Number_of_storeys):
	for j in range(Number_of_storeys):
		q=Omega[i,0]
		r=Omega[j,0]
		B[i,j]=(r/q)
B=B.n(digits=4)

for i in range(Number_of_storeys):
	for j in range(Number_of_storeys):
		b=1+B[i,j]
		q=8*(0.05)^2*(b)*B[i,j]^1.5
		e=(1-B[i,j]^2)^2+4*(0.05)*B[i,j]*(b)^2
		P[i,j]=q/e
Lateral_force=zero_matrix(RR,Number_of_storeys,1)
for i in range(Number_of_storeys):
	l=Peak_shear_force[:,i].transpose()*P*Peak_shear_force[:,i]
	Lateral_force[i,0]=sqrt(l[0,0])
Force=zero_matrix(RR,Number_of_storeys,1)
for i in range(Number_of_storeys):
	if(i==Number_of_storeys-1):
		Force[i,0]=Lateral_force[i,0]
		break
	Force[i,0]=Lateral_force[i,0]-Lateral_force[i+1,0]

#making graph for eigen vectors of calculated
p=list()
for i in range(Number_of_storeys):
	for j in range(Number_of_storeys):
		if(j==0):
			p.append(line([(XX[j,i],Level_floor[j,0]),(0,0)],
			color=hue(0.4 + 0.6*(i/10))))
		else:
			p.append(line([(XX[j,i],Level_floor[j,0]),
			(XX[j-1,i],Level_floor[j-1,0])],marker='o',
			color=hue(0.4 + 0.6*(i/10))))
Graph=plot([])
for r in range(Number_of_storeys^2):
	Graph= Graph+p[r]

Omega_square=matrix(Omega_square).n(digits=4)
Time_period=Time_period.n(digits=4)
Omega=Omega.n(digits=4)
Level_floor=(Level_floor).n(digits=4)
Modal_participation_factor=(Modal_participation_factor).n(digits=4)
Modal_mass=(Modal_mass).n(digits=4)
Modal_contribution=Modal_contribution.n(digits=4)
Sa_by_g=Sa_by_g.n(digits=4)
A_h=A_h.n(digits=4)
Design_lateral_force=Design_lateral_force.n(digits=4)
Peak_shear_force=Peak_shear_force.n(digits=4)
storey_shear_force3=Storey_shear_force[:].n(digits=4)
Storey_shear_force2=Storey_shear_force2[:].n(digits=4)
Lateral_force=Lateral_force.n(digits=4)
Force=Force.n(digits=4)
