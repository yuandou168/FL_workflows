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
  command_stop:
    type: string
    inputBinding:
      position: 3
  upload_state:
    type: File[]

  
outputs:
  stop_state:
    type: stdout
  
stdout: stop_state.txt

# outputs:
#   server_state:
#     type: File
#     outputBinding:
#       glob: global_model.pth