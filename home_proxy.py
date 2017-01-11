#!/bin/python3

# from io import StringIO
import os
# import sys

# # do something that writes to stdout or stdout.buffer
# os.system("git config --list")

import subprocess

# proc = subprocess.Popen(["cat", "/etc/services"], stdout=subprocess.PIPE, shell=True)
gitConfig = subprocess.check_output("git config --list", shell=True).decode()
# (out, err) = proc.communicate()
if 'http.proxy' in gitConfig:
	# proxy is set, have to unset
	os.system("git config --global --unset http.proxy")
	os.system("git config --global --unset https.proxy")
	os.system("git config --list")
else:
	os.system("git config --global http.proxy http://10.3.100.207:8080")
	os.system("git config --global https.proxy http://10.3.100.207:8080")
	os.system("git config --list")
