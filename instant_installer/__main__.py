# -*- coding: utf-8 -*-

import sys
import os
import subprocess

path = os.path.abspath(__file__)
modpath = os.path.dirname(path)
base_dir =  os.getcwd()
bscript = modpath+'/install/init/install.sh'
demo_mode = "false"
if len(sys.argv) > 1:
	if '-d' in sys.argv[1] or '-demo' in sys.argv[1]:
		demo_mode = "true"

msg = 'What is the name of the project? > '
user_input = raw_input(msg)
if user_input == "":
	print "You must provide a project name"
	sys.exit()
project_name = user_input

print "Starting install ..."
subprocess.call([bscript, project_name, base_dir, modpath])

if demo_mode == "true":
	bscript = modpath+'/install/pages/install.sh'
	subprocess.call([bscript, project_name, base_dir, modpath])

bscript = modpath+'/install/real_time/install.sh'
subprocess.call([bscript, project_name, base_dir, modpath])

bscript = modpath+'/install/end/install.sh'
subprocess.call([bscript, project_name, base_dir, modpath, demo_mode])
