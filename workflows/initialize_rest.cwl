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
  command:
    type: string
    inputBinding:
      position: 3
  
outputs:
  server_state:
    type: stdout
  
stdout: server_state.txt