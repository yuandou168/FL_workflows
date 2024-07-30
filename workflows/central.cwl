
  cwlVersion: v1.2
  $namespaces:
    cwltool: "http://commonwl.org/cwltool#"
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

    mode_initialization:
      type: string
    
    mode_aggregation:
      type: string

    rounds:
      type: string[]

    round:
      type: string

    communication_server_ip:
      type: string
    
    python_file:
      type: File

    
  outputs:

    aggregation_state:
      type: File[]
      outputSource: 
        central_federated_learning_round/aggregation_state


  steps: 

    #make the initialization execute here and also create the files based on the client availability here
    initialize:
      run: aggregator.cwl
      in: 
        keyfile: keyfile
        host: host
        command: command
        mode: mode_initialization
        round: round
      out: [server_state]
    
    central_federated_learning_round:
      run: rest.cwl
      scatter: round
      scatterMethod: nested_crossproduct
      in: 
        round: rounds
        clients: clients
        # clients: get_clients/client_list
        python_file: python_file
        communication_server_ip: communication_server_ip
        keyfile: keyfile
        host: host
        command: command
        aggregator_upload_url:  aggregator_upload_url
        command_endpoint: command_endpoint
        command_stop: command_stop
        mode_aggregation: mode_aggregation
        server_state: initialize/server_state
      when: |
        $(inputs.server_state.size >0)
      out: [aggregation_state]

   

