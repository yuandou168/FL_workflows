import requests
import yaml
import sys 
import pathlib
import os

directory=pathlib.Path(__file__).parent.resolve()
directory=directory.parents[0]
information_server_ip = sys.argv[1]
aggregator_ip = sys.argv[2]
# rounds = sys.argv[3]
host_aggregator_ip = aggregator_ip.replace('.', '-')
host_information_ip = information_server_ip.replace('.', '-')

#numbers = [str(i) for i in range(int(rounds)+1)]
rounds = 12
# Load the YAML file and update the clients field
with open(f'{directory}/input_files/skeleton_job.yml', 'r') as f:
#with open('/Users/chroniskontomaris/Documents/GitPullTest/CWL_Remote_RestAPI/CWL_Workflow/skeleton_job.yml', 'r') as f:
    config = yaml.safe_load(f)

config['rounds'] = rounds
config['command_endpoint'] = f'sudo docker run -t -i -v $(pwd)/:/aggregator_endpoint/files -d -p 808:808 chroniskaust/aggregator_endpoint_test:latest; while ! curl --silent --head --fail http://{aggregator_ip}:808/ >/dev/null; do sleep 1; done && echo "Aggregator flask server is running." '
config['aggregator_upload_url'] = f'http://{aggregator_ip}:808'
config['host'] = f'ec2-user@ec2-{host_aggregator_ip}.compute-1.amazonaws.com'
config['information_server_host'] = f'ec2-user@ec2-{host_information_ip}.compute-1.amazonaws.com'
config['communication_server_ip'] = f'http://{information_server_ip}'
# Write the updated YAML file
with open(f'{directory}/input_files/final_job.yml', 'w') as f:
    yaml.dump(config, f , default_style='',default_flow_style=False)
