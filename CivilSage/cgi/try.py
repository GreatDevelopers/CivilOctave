#!/usr/bin/python3

print("Content-type: text/html")
print("")
print("<html><head><title>hello</title></head>")
print("<body><br><br>")
import cgi,cgitb,os
import subprocess
cgitb.enable()
form = cgi.FieldStorage()
lists = {'Soil_type':'','Number_of_storeys':'','Importance_factor':'','Response_reduction_factor':'','Zone_factor':'','Gravity_acceleration':'','Modes_considered':''}
values = {}
for var in lists.keys():
    lists[var]=form.getvalue(var)
    #print(values[var])
#print(values,'\n')
#b = sorted(values)

print('<h3 class="header">Mass</h3><br>')
for row in range(int(lists['Number_of_storeys'])):
    print('<div class="row">')
    for col in range(1,2):
        print('<input class="input-lg col-md-3 col-sm-3 col-xs-3 space" type="text" name="mass',row,col,'" placeholder="m',row,col,'">')
    print('</div>')

"""
Height Storey
"""
print('<h3 class="header">Height storey</h3>')
for row in range(int(lists['Number_of_storeys'])):
    print('<div class="row">')
    for col in range(1,2):
        print('<input class="input-lg col-md-12 col-sm-12 space" type="text" name="height',row,col,'" placeholder="h',row,col,'">')
    print('</div>')

"""
Stiffness_storey
"""
print('<h3 class="header">Stiffness storey</h3>')
for row in range(int(lists['Number_of_storeys'])):
    print('<div class="row">')
    for col in range(1, 2):
        print('<input class="input-lg col-md-12 col-sm-12 space" type="text" name="stiff',row,col,'" placeholder="s',row,col,'">')
    print('</div>')


#Soil_type =  form.getvalue('Soil_type')
#Number_of_storeys=  form.getvalue('Number_of_storeys')
#Importance_factor=  form.getvalue('Importance_factor')
#Response_reduction_factor=  form.getvalue('Response_reduction_factor')
#Zone_factor=  form.getvalue('Zone_factor')
#Gravity_acceleration=  form.getvalue('Gravity_acceleration')
#Modes_considered=  form.getvalue('Modes_considered')
print("<h4>Input</h4>")
file = open('/home/amarjeet/projects/CivilOctave/sagemath/input1.sage', 'a')

for var in lists.keys():
    print('<br>',var,' = ',lists[var],'<br>')
    file.write(var)
    file.write('=')
    file.write(lists[var])
    file.write('\n\n\n')
#os.chdir('//home//amarjeet//projects//CivilOctave//sagemath//')
os.system('sh civil.sh')
print("<br><h4>Output</h4><br>")
print("<br></body></html>")

