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

	#name of directory of specific user
	name=''

	#getting input using tags and sending it as response
	for var in lists.keys():
		request.session[var]=request.POST.get(var)
	#creating directory from base directory
	lists['Number_of_storeys']=request.POST.get('Number_of_storeys')
	#making list for iteratation in templete
	number_of_storeys=list()
	for a in range(int(lists['Number_of_storeys'])):
		number_of_storeys.append('a')
	#calling matrix.html
	if(request.POST.get('through_file')=='Y'):
		return render( request,'civilsage/file.html'
		,{'number_of_storeys': number_of_storeys})
	else:
		return render( request,'civilsage/matrix.html'
		,{'number_of_storeys': number_of_storeys})


'''
This function gets request from matix.html and
gives pdf as output to user
...
'''
def last(request):

		#dictionary of all input tags
	lists = {'Soil_type':'','Number_of_storeys':''
	,'Importance_factor':'','Response_reduction_factor':''
	,'Zone_factor':'','Gravity_acceleration':''
	,'Modes_considered':''}

	#name of directory of specific user
	name=''

	#getting input using tags
	for var in lists.keys():
		lists[var]=request.session.get(var)
		name=name+str(lists[var])

	command='cp -r sagemath '+name
	os.popen(command)

	#opening file for writing
	command=name+'/input.sage'
	file = open(command, 'w')

	#writing variables in input.sage file with syntax of sage
	for var in lists.keys():
		file.write(var)
		file.write('=')
		file.write(lists[var])
		file.write('\n')
	file.close()


	#getting numbers of storeys
	num = request.session.get('Number_of_storeys')


	#opening input.sage to append remaining inputs
	command=name+'/input.sage'
	file=open(command,'a')
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


	#creating and writing sh file for background processing
	command=name+'/civil.sh'
	file=open(command,'w')
	command='cd '+name
	file.write(command)
	file.write('\nlatex civil.tex\nsage civil.sagetex.sage\n')
	file.write('pdflatex civil.tex\n')
	file.close()
	#calling sh file for background processing
	command='sh '+name+'/civil.sh'
	os.system(command)

	#opening creted pdf to display to user
	command=name+'/civil.pdf'
	f=open(command)
	#sending pdf as response
	response = HttpResponse(f,content_type='application/pdf')
	response['Content-Disposition'] = 'attachment; filename="civil.pdf"'

	#deleting temperary files
	command='rm -rf '+name
	os.system(command)

	return response


def file(request):
	lists = {'Soil_type':'','Number_of_storeys':''
	,'Importance_factor':'','Response_reduction_factor':''
	,'Zone_factor':'','Gravity_acceleration':''
	,'Modes_considered':''}

	#name of directory of specific user
	name=''

	#getting input using tags
	for var in lists.keys():
		lists[var]=request.session.get(var)
		name=name+str(lists[var])

	command='cp -r sagemath '+name
	os.popen(command)

	#opening file for writing
	command=name+'/input.sage'
	file = open(command, 'w')

	#writing variables in input.sage file with syntax of sage
	for var in lists.keys():
		file.write(var)
		file.write('=')
		file.write(lists[var])
		file.write('\n')
	file.close()

	f=request.FILES["input_file"]
	command=name+'/name.txt'
	destination=open(command, 'wb+')
	for chunk in f.chunks():
		destination.write(chunk)
	destination.close()

	f = open(command,'r')
	x = f.read()
	aid = []
	s = ''
	for i in x:
		if i == ',':
			aid.append(int(s))
			s = ''
			continue
		s = s + i
	aid.append(int(s))
		#dictionary of all input tags

	#getting numbers of storeys
	num = request.session.get('Number_of_storeys')


	if(len(aid)<3*int(num)):
		return render( request,'civilsage/file.html')



	#opening input.sage to append remaining inputs
	command=name+'/input.sage'
	file=open(command,'a')
	#list of basic tags
	var = ['mass','Height_storey','Stiffness_storey']
	jar=0
	#writing matix into sage file
	for j in var:
		file.write(j)
		file.write('=matrix([')
		#writing elements of matix
		for i in range(jar,int(num)+jar):
			#creating input tags
			temp = j+str(i)
	 		file.write('[')
	 		#getting input from tags
	 		d=aid[i]
			file.write(str(d))
			file.write(']')
			#condition to check last element
			if( i!=int(num)+jar-1):
				file.write(',')
		jar=i
		file.write('])\n')
	file.close()


	#creating and writing sh file for background processing
	command=name+'/civil.sh'
	file=open(command,'w')
	command='cd '+name
	file.write(command)
	file.write('\nlatex civil.tex\nsage civil.sagetex.sage\n')
	file.write('pdflatex civil.tex\n')
	file.close()
	#calling sh file for background processing
	command='sh '+name+'/civil.sh'
	os.system(command)

	#opening creted pdf to display to user
	command=name+'/civil.pdf'
	f=open(command)
	#sending pdf as response
	response = HttpResponse(f,content_type='application/pdf')
	response['Content-Disposition'] = 'attachment; filename="civil.pdf"'

	#deleting temperary files
	command='rm -rf '+name
	os.system(command)

	return response
