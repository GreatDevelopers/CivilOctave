

# Create your views here.
import os
from django.http import HttpResponse
from django.shortcuts import render


'''
first veiw created by rendering html page
from templete
...
'''
def index(request):
	return render(request, 'civilsage/index.html')

'''
This function display matrix for input from user and take
response from index veiw and write input taken through index.html
and write in input.sage file
...
'''
def matrix(request):
	
	#dictionary of all input tags
	lists = {'Soil_type':'','Number_of_storeys':''
	,'Importance_factor':'','Response_reduction_factor':''
	,'Zone_factor':'','Gravity_acceleration':''
	,'Modes_considered':''}
	
	#getting input using tags
	for var in lists.keys():
		lists[var]=request.POST.get(var)
		
	#opening file for writing
	file = open('sagemath/input.sage', 'w')
	
	#writing variables in input.sage file with syntax of sage 
	for var in lists.keys():
		file.write(var)
		file.write('=')
		file.write(lists[var])
		file.write('\n')
	file.close()
	
	#making list for iteratation in templete  
	number_of_storeys=list()
	for a in range(int(lists['Number_of_storeys'])):
		number_of_storeys.append('a')
	
	#puting list created for iteration in request
	request.session['Number_of_storeys'] = lists['Number_of_storeys']
	#calling matrix.html
	return render( request,'civilsage/matrix.html'
	,{'number_of_storeys': number_of_storeys})


'''
This function gets request from matix.html and 
gives pdf as output to user
...
''' 
def last(request):

	#getting numbers of storeys 
	num = request.session.get('Number_of_storeys')
	#opening input.sage to append remaining inputs
	file=open('sagemath/input.sage','a')
	#list of basic tags
	var = ['mass','Height_storey','Stiffness_storey']
	
	#writing matix into sage file
	for j in var:
		file.write(j)
		file.write('=matrix([')
		#writing elements of matix
		for i in range(int(num)):
			#creating input tags 
			temp = j+str(i)
	 		file.write('[')
	 		#getting input from tags
	 		d=request.GET.get(temp)
			file.write(d)
			file.write(']')
			#condition to check last element
			if( i!=int(num)-1):
				file.write(',')
		file.write('])\n')
	file.close()
	
	#calling sh file for background processing
	os.system('sh sagemath/civil.sh')
	
	#opening creted pdf to display to user
	f=open('sagemath/civil.pdf')
	#sending pdf as response
	response = HttpResponse(f,content_type='application/pdf')
	response['Content-Disposition'] = 'attachment; filename="civil.pdf"'
	return response

