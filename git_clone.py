from urllib.request import urlopen
import ssl
import json
import subprocess
import argparse
import sys

ctx = ssl.create_default_context()
ctx.check_hostname = False
ctx.verify_mode = ssl.CERT_NONE

def main(arguments):
    parser = argparse.ArgumentParser(
        description=__doc__,
        formatter_class=argparse.RawDescriptionHelpFormatter)
    parser.add_argument('--groupid', type=str, help="group id")

    args = parser.parse_args(arguments)

    if args.groupid is None:
        raise Exception('groupid is required')

# Hard code url and token
    gitlaburl=""
    token=""
    
    
    resp = urlopen(f'{gitlaburl}/api/v4/groups/{args.groupid}/projects?private_token={token}&include_subgroups=true&with_shared=false&per_page=100000', context=ctx)
    projects = json.loads(resp.read().decode())
    for project in projects:
        try:
            repoHttpUrl = project['http_url_to_repo']
            clonePath = project["path_with_namespace"]
            command = f'mkdir -p {clonePath}; git clone {repoHttpUrl} {clonePath}; cd {clonePath}'
            print(command)
            resultCode = subprocess.run(command, shell=True, capture_output=True)

        except Exception as e:
            print("Error on %s: %s" % (repoHttpUrl, e.strerror))

if __name__ == '__main__':
    sys.exit(main(sys.argv[1:]))

