
  cwlVersion: v1.2
  class: Workflow

  requirements:
    ScatterFeatureRequirement: {}
    InlineJavascriptRequirement: {}
    StepInputExpressionRequirement: {}
    SubworkflowFeatureRequirement: {}

  inputs: 
    clients:
      type: string[]
    keyfile:
      type: File
    host:
      type: string
    command:
      type: string

    aggregator_upload_url:
      type: string 

    command_endpoint:
      type: string

    command_stop:
      type: string 

    mode_aggregation:
      type: string
      
    round:
      type: string    

  outputs: []
  


  steps: 

    #make the initialization execute here and also create the files based on the client availability here

    rest_round:
      run: rest.cwl
      in: 
        round: round
        clients: clients
        keyfile: keyfile
        host: host
        command: command
        aggregator_upload_url:  aggregator_upload_url
        command_endpoint: command_endpoint
        command_stop: command_stop
        mode_aggregation: mode_aggregation
      out: []
   

