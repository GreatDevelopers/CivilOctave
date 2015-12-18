##
# @package initial_file
# This module contain functions for processing the intruppted files.
# For, this we first retrive the name of all directory  using pdfemail()
# and then process
# files in it using emailcall()
# @author amarjeet kapoor
#
#

import os,threading
from django.core.mail import EmailMessage


##
# function to get name of directory that are unprocessed and then
# call emailcall() and pass the name
#

def pdfemail():
	##
   	# initalize sage

    os.system('sage sagemath/input.sage')

    # get list of unprocessed files
    os.system('ls -d Temp*>file')

    # open and read names of directory to be processed
    f=open('file')
    a=f.read()
    if( a ==''):
        return

    # getting individual directory name
    a=a.split('\n')

    # process files
    for i in range(len(a)-1):
        emailcall(a[i])
    os.system('rm file')

##
# A function that run as process to send pdf as emails
# @param name this name of directory
#
# @exception remove directory and email error
def emailcall(name):
	##
	# @breif

	#getting email id

	try:
                message='unable to send'
                command=name+'/email.txt'
                f=open(command)
                a=f.read()
                email=a.split('\n')
                email_id=email[0]
                f.close()
		#calling sh file for background processing
		command='sh civil.sh '+name
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
                command='rm -rf '+name
                os.system(command)

if __name__ == '__main__':
	print("hello")
