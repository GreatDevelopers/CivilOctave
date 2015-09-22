#!/usr/bin/env python
print("Content-Type: text/html")
print()
import cgi,cgitb
cgitb.enable()
form = cgi.FieldStorage()
seachterm =  form.getvalue('searchbox')
print("Name of the user is:", searchterm)
