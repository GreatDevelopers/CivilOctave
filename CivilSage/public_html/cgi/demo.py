#!/usr/bin/python3

print("Content-type: text/html")
print("")
print("<html><head><title>hello</title></head>")
print("<body><br><br>")
print("hello")
import cgi,cgitb
cgitb.enable()
form = cgi.FieldStorage()
listt = {'Soil_type':'','Number_of_storeys':'','Importance_factor':'','Response_reduction_factor':'','Zone_factor':'','Gravity_acceleration':'','Modes_considered':''}
for var in listt.keys():
    listt[var]=form.getvalue(var)

Soil_type =  form.getvalue('Soil_type')
Number_of_storeys=  form.getvalue('Number_of_storeys')
Importance_factor=  form.getvalue('Importance_factor')
Response_reduction_factor=  form.getvalue('Response_reduction_factor')
Zone_factor=  form.getvalue('Zone_factor')
Gravity_acceleration=  form.getvalue('Gravity_acceleration')
Modes_considered=  form.getvalue('Modes_considered')

for var in listt.keys():
    print(var,' = ',listt[var])
print("<br></body></html>")

