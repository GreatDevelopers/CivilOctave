import os,threading
from django.core.mail import EmailMessage



def pdfemail():
    """
    function to process interuppted files
    ...
    """
    
   	#initalize sage
    os.system('sage sagemath/input.sage')
    
    #get list of unprocessed files
    os.system('ls -d Temp*>file')
    
    #open and read names of directory to be processed
    f=open('file')
    a=f.read()
    if( a ==''):
        return
        
    #getting individual directory name
    a=a.split('\n')
    
    #process files
    for i in range(len(a)-1):
        emailcall(a[i])
    os.system('rm file')

def emailcall(name):
	"""
	A function that run as process to send pdf as emails
	...
	"""
	
	#getting email id 
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
		
		#sending email
		command=name+'/civil.pdf'
		user_email = EmailMessage('Dynamics of structure',
		'You have is ready', to=[email_id])
		user_email.attach_file(command)
		user_email.send()
		
		#deleting files
		command='rm -rf '+name
		os.system(command)
	except:
		user_email = EmailMessage('Dynamics of structure',
		message, to=[email_id])

if __name__ == '__main__':
	print("hello")
