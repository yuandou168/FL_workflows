cwlVersion: v1.0
class: CommandLineTool
requirements:
  InlineJavascriptRequirement: {}


baseCommand: ["python"]
inputs:
  yaml_generator_file:
    type: File
    inputBinding:
      position: 1
  aggregator_ip:
    type: string
    inputBinding:
      position: 2
  communication_server_ip:
    type: string
    inputBinding:
      position: 3
  rounds:
    type: int
    inputBinding:
      position: 4

  
outputs:
  infrastructure_state:
    type: stdout
  
stdout: infrastructure_state.txt



