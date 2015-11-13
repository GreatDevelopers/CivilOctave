#!/usr/bin/env python
import os
import sys,threading
import initial_file


if __name__ == "__main__":

    os.environ.setdefault("DJANGO_SETTINGS_MODULE", "sage.settings")

    from django.core.management import execute_from_command_line
    
    
    #code to fire thread to process intrupted process
    if(sys.argv[1]== 'initial'):
    	
    	#remove our argument so that argv can be send to django
		sys.argv.remove('initial')
		
		#starting thread
		thread = threading.Thread(target=initial_file.pdfemail,args=())
		thread.daemon = True
		thread.start()

    execute_from_command_line(sys.argv)
