from django.shortcuts import render

# Create your views here.
import os
from django.http import HttpResponse
from django.template import RequestContext, loader
from django.shortcuts import render
from django.shortcuts import render_to_response
from django.views.decorators.csrf import csrf_protect

def index(request):
	return render(request, 'civilsage/index.html')

@csrf_protect
def matrix(request):
    c = {}
    c=request.POST.get('Number_of_storeys')
    lists = {'Soil_type':'','Number_of_storeys':'','Importance_factor':'','Response_reduction_factor':'','Zone_factor':'','Gravity_acceleration':'','Modes_considered':''}
    values = {}
    for var in lists.keys():
    	lists[var]=request.POST.get(var)
    file = open('input.sage', 'a')
    for var in lists.keys():
    	file.write(var)
    	file.write('=')
    	file.write(lists[var])
    	file.write('\n\n\n')
    os.system('sh sagemath/civil.sh')
    return render_to_response('civilsage/matrix.html', lists)
