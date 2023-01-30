import os, sys, subprocess
from .engineargs import EngineArgs
from typing import List

def run(arg: EngineArgs):
    args = []
    if arg.config != None:
        if os.path.isfile(arg.config):
            args.extend(["-config",arg.config])
        else:
            raise Exception("Error: config file {} not found".format(arg.config))

    if arg.input != None:
        if os.path.isfile(arg.input):
            args.extend(["-input",arg.input])
        else:
            raise Exception("Error: input file {} not found".format(arg.input))
    
    if arg.context != None:
        if os.path.isdir(arg.context):
            args.extend(["-context",arg.context])
        else:
            raise Exception("Error: context path {} not found".format(arg.context))
    
    if arg.workflow != None:
        if os.path.isfile(arg.workflow):
            args.extend(["-workflow",arg.workflow])
        else:
            raise Exception("Error: context file {} not found".format(arg.workflow))
    
    sys.exit(subprocess.call([
        os.path.join(os.path.dirname(__file__), "bin","arcaflowengine"),
        *args
    ]))

