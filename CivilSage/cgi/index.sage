#!/usr/bin/python3

print("Content-type: text/html")
print("")
print("<html><head><title>hello</title>")
print('<link rel="stylesheet" type="text/css" href="../~amarjeet/bootstrap.min.css">')
print('<style>body{background-color:#111;}.space{margin-top:10px;}.header{text-align:center;color:#DADADA;}</style>')
print("</head><body><br><br>")
import cgi,cgitb,os
cgitb.enable()
form = cgi.FieldStorage()
print('<h1 class="header">CivilOctave</h1>')
print('<form class="col-lg-12" name="search" action="try.py" method="POST"> \           <div class="input-group" style="width:340px;text-align:center;margin:0 auto;">\             <input class="form-control input-lg space" type="text" name="Soil_type" placeholder="Soil_type">    \
                <br>    \
                <input class="form-control input-lg space" type="text" name="Number_of_storeys" placeholder="Number_of_storeys"><br><input class=" form-control input-lg space" type="text" name="Importance_factor" placeholder="Importance_factor">   \
                <br>    \
                <input class=" form-control input-lg space" type="text" name="Response_reduction_factor" placeholder="Response_reduction_factor">   \
                <br>    \
                <input class=" form-control input-lg space" type="text" name="Zone_factor" placeholder="Zone_factor">  \
                <br>    \
                <input class=" form-control input-lg space" type="text" name="Gravity_acceleration" placeholder="Gravity_acceleration">     \
                <br>    \
                <input class=" form-control input-lg space" type="text" name="Modes_considered" placeholder="Modes_considered"> \
                <br>')



"""
    <input class="input-lg col-md-3 space" type="text" name="Zone_factor" placeholder="matrix"><input class="input-lg col-md-3 space" type="text" name="Zone_factor" placeholder="matrix"><input class="input-lg col-md-3 space" type="text" name="Zone_factor" placeholder="matrix"> \
"""
print('<br><br>    \
                <input class="btn-lg btn-success" type="submit" value="Submit"> \
            </div></form>')
print("<br></body></html>")
