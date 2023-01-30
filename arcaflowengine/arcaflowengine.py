import os, sys, subprocess
from typing import List

def run(arg: List[str]):
    sys.exit(subprocess.call([
        os.path.join(os.path.dirname(__file__), "bin","arcaflowengine"),
        *arg
    ]))
