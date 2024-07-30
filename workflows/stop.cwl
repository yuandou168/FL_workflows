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
  stop:
    type: string
    inputBinding:
      position: 3
outputs:
  stop_state: stdout

stdout: stop_state.txt
