cwlVersion: v1.0
class: CommandLineTool
baseCommand: ssh
inputs:
  host:
    type: string
    inputBinding:
      position: 2
      prefix: '-T'
  keyfile:
    type: File
    inputBinding:
      position: 1
      prefix: '-i'
  check:
    type: string
    inputBinding:
      position: 3
  clients:
    type: string[]
    inputBinding:
      position: 4

  
outputs:
  state: stdout

stdout: clients_state.txt
