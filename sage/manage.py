#!/usr/bin/env python
import os
import sys,threading
import initial_file

if __name__ == "__main__":
    #thread = threading.Thread(target=initial_file.pdfemail,args=())
    #thread.daemon = True
    #thread.start()
    os.environ.setdefault("DJANGO_SETTINGS_MODULE", "sage.settings")

    from django.core.management import execute_from_command_line
    

    execute_from_command_line(sys.argv)
