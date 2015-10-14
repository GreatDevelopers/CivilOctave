# Create your views here.
import os
from django.http import HttpResponse
from django.shortcuts import render
import csv
from django.core.mail import EmailMessage


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
	try:
		#dictionary of all input tags
		lists = {'Soil_type':'','Number_of_storeys':''
		,'Importance_factor':'','Response_reduction_factor':''
		,'Zone_factor':'','Gravity_acceleration':''
		,'Modes_considered':'','email_get':''}

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
		#calling differnet veiws based on option whether
		#user want to upload matrix value through file or
		#manually

		if(request.POST.get('through_file')=='Y'):
			return render( request,'civilsage/file.html'
			,{'number_of_storeys': number_of_storeys,
			'email_get': request.POST.get('email_get')})
		else:
			return render( request,'civilsage/matrix.html'
			,{'number_of_storeys': number_of_storeys,
			'email_get': request.POST.get('email_get') })
	except:
		return render(request, 'civilsage/index.html'
		,{'message':'please fill again'})


'''
gives pdf as output to user
...
This function gets request from matix.html and
'''
def last(request):
	message='error occured please fill again'
	#dictionary of all input tags
	lists = {'Soil_type':'','Number_of_storeys':''
	,'Importance_factor':'','Response_reduction_factor':''
	,'Zone_factor':'','Gravity_acceleration':''
	,'Modes_considered':''}
	try:
		#name of directory of specific user
		name=''

		#getting input using tags
		for var in lists.keys():
			lists[var]=request.session.get(var)
			name=name+str(lists[var])
		print(request.session.get(var))
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
				d=request.POST.get(temp)
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
		if(request.GET.get('email_id')):
			email_id=request.POST.get('email_id')
			user_email = EmailMessage('Your PDF is ready!',
			'You have is ready', to=[email_id])
			user_email.attach_file(command)
			user_email.send()
			command='rm -rf '+name
			os.system(command)
			return render(request, "civilsage/index.html", {})
		else:
			#deleting temperary files
			command='rm -rf '+name
			os.system(command)
			return response
	except:
		return render(request, "civilsage/matrix.html",{'message':message,'email_get':request.session.get('email_get')})


"""
This veiw take input data from file uploaded by user and processes
to give output in form of response
"""
def file(request):

	message='please fill again'
	#dictionary of all input tags
	lists = {'Soil_type':'','Number_of_storeys':''
	,'Importance_factor':'','Response_reduction_factor':''
	,'Zone_factor':'','Gravity_acceleration':''
	,'Modes_considered':''}
	try:
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

		#getting file uploaded by user
		f=request.FILES["input_file"]
		if(f.content_type != 'text/plain'):
			print(request.session.get('email_get'))
			return render( request,'civilsage/file.html',
			{'email_get': request.session.get('email_get'),
			'message':'File Not in CSV FORMAT '})
		data = [row for row in csv.reader(f)]
		#getting numbers of storeys
		num = request.session.get('Number_of_storeys')

		#checking if number values are not less than required values
		#if(len(data)<3*int(num)):
			#return render( request,'civilsage/file.html')
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
			for i in range(int(num)):
		 		file.write('[')
		 		#getting input from tags
		 		d=data[jar][i]
				print(d)
				file.write(str(d))
				file.write(']')
				#condition to check last element
				if( i!=int(num)+jar-1):
					file.write(',')
			jar=jar+1
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
		if(request.POST.get('email_id')):
			email_id=request.POST.get('email_id')
			user_email = EmailMessage('Your PDF is ready!',
			'You have is ready', to=[email_id])
			user_email.attach_file(command)
			user_email.send()
			command='rm -rf '+name
			os.system(command)
			return render(request, "civilsage/index.html", {})
		else:
			#deleting temperary files
			command='rm -rf '+name
			os.system(command)
			return response

	except:
		return render( request,'civilsage/file.html'
		,{'email_get': request.session.get('email_get'),'message':message})
