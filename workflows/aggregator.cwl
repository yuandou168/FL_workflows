cwlVersion: v1.0
class: CommandLineTool
baseCommand: ssh
requirements:
  InlineJavascriptRequirement: {}
#   SubworkflowFeatureRequirement: {}
#   StepInputExpressionRequirement: {}
  # InitialWorkDirRequirement:
  #   listing:
  #     - entry: $(inputs.output_directory)
  #       writable: true
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
  mode:
    type: string
    inputBinding:
      position: 4
      prefix: '--mode'
  training_round:
    type: string
    inputBinding:
      position: 5
      prefix: '--round'
  # output_directory:
  #   type: Directory

outputs:
  server_state: 
    type: stdout
    # outputBinding:
    #   glob:
    #       $(inputs.output_directory.basename)/annotations/data_inspection-$(inputs.month)-$(inputs.day)_annotated.jsonl
  
stdout:  $(('aggregation_'+inputs.training_round + '.txt'))

          # $(inputs.output_directory.basename)/aggregation_$(inputs.training_round).txt
         #$(('aggregation_'+inputs.training_round + '.txt'))



