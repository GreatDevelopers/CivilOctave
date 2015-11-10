import os
from django.core.mail import EmailMessage

def pdfemail():
    os.system('sage ../sagemath/input.sage')
    os.system('ls -d Temp*>file')
    f=open('file')
    a=f.read()
    a=a.split('\n')
    for i in range(len(a)-1):
        emailcall(a[i])
    os.system('rm file')

def emailcall(name):
	"""
	A function that run as background process to send pdf as emails
	...
	"""
	message='unable to send'
	command=name+'/email.txt'
	f=open(command)
	a=f.read()
        email=a.split('\n')
        email_id=email[0]
	f.close()
	try:
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
		command=name+'/civil.pdf'
		user_email = EmailMessage('Dynamics of structure',
		'You have is ready', to=[email_id])
		user_email.attach_file(command)
		user_email.send()
		command='rm -rf '+name
		os.system(command)
	except:
		user_email = EmailMessage('Dynamics of structure',
		message, to=[email_id])
