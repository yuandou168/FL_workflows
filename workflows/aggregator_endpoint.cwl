cwlVersion: v1.0
class: CommandLineTool
baseCommand: ssh
inputs:
  host:
    type: string
    inputBinding:
      position: 2
  keyfile:
    type: File
    inputBinding:
      position: 1
      prefix: '-i'
  command_endpoint:
    type: string
    inputBinding:
      position: 3

  clients:
    type: string[]
  
outputs:
  aggregator_endpoint_state:
    type: stdout
  
stdout: aggregator_endpoint_state.txt

# outputs:
#   server_state:
#     type: File
#     outputBinding:
#       glob: global_model.pth