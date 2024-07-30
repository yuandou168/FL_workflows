cwlVersion: v1.0
class: CommandLineTool

requirements:
  InlineJavascriptRequirement: {}
inputs:
  client_weight:
    type: File
  aggregator_upload_url:
    type: string
  round:
    type: string
  # weights:
  #   type: File[]

baseCommand: curl

arguments:
  - -F 
  #- 'file=@$(inputs.file_path)' 
  - 'file=@$(inputs.client_weight.path)' 
  - $(inputs.aggregator_upload_url.concat('/',inputs.round,'/upload'))

outputs:
  upload_state: stdout

stdout: upload.txt