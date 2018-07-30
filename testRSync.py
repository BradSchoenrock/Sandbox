import subprocess

#subprocess.call(["ls", "-l"])

subprocess.call(["rsync", "-az", "/h/eol/brads/git/WVD-MCSupdate/WVDNewArchitectureUpdate/WVD_Architecture_Update/Data", "/home/brads/test"])
