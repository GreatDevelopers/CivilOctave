#!/usr/local/env python
print("Content-Type: text/html")
print()

 import cgi,cgitb
 cgitb.enable() #for debugging
 form = cgi.FieldStorage()
 name = form.getvalue('fname')
 print("Name of the user is:",name)

