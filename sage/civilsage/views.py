from django.shortcuts import render

# Create your views here.
import os
from django.http import HttpResponse
from django.shortcuts import get_object_or_404, render
from django.http import HttpResponseRedirect, HttpResponse
from django.core.urlresolvers import reverse
from django.template import RequestContext, loader
from django.shortcuts import render
from django.shortcuts import render_to_response
from django.views.decorators.csrf import csrf_protect

Number=0


def index(request):
	return render(request, 'civilsage/index.html')

def matrix(request):
	global Number
	c = {}
	c=request.POST.get('Number_of_storeys')
	lists = {'Soil_type':'','Number_of_storeys':'','Importance_factor':'','Response_reduction_factor':'','Zone_factor':'','Gravity_acceleration':'','Modes_considered':''}
	values = {}
	for var in lists.keys():
		lists[var]=request.POST.get(var)
	file = open('sagemath/input.sage', 'w')
	for var in lists.keys():
		file.write(var)
		file.write('=')
		file.write(lists[var])
		file.write('\n\n\n')
	file.close()
	request.session['Number_of_storeys'] = lists['Number_of_storeys']
	return render( request,'civilsage/matrix.html')


def last(request):
	c={}
	num = request.session.get('Number_of_storeys')
	file=open('sagemath/input.sage','a')
	var = ['mass','Height_storey','Stiffness_storey']
	for i in range(1):
		for j in var:
			file.write(j)
			file.write('=matrix([')
			for i in range(int(num)):
				temp = j+','+str(i)
	 			c[temp]=request.GET.get(temp)
	 			file.write('[')
	 			d=request.GET.get(temp)
				file.write(d)
				file.write(']')
				if( i!=3):
					file.write(',') 
			file.write(']) \n\n\n\n')
	file.close()
	os.system('sh sagemath/civil.sh')
	return render_to_response('civilsage/last.html', c)

