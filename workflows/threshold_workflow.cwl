
  cwlVersion: v1.2
  class: Workflow

  requirements:
    ScatterFeatureRequirement: {}
    InlineJavascriptRequirement: {}
    StepInputExpressionRequirement: {}
    ShellCommandRequirement: {}

  inputs: 
    clients:
      type: string[]
    keyfile:
      type: File
    host:
      type: string
    command:
      type: string


    round: int

    aggregator_upload_url:
      type: string 

    command_endpoint:
      type: string

    command_stop:
      type: string

    round_help:
      type: string   

    # mode_initialization:
    #   type: string
    
    mode_aggregation:
      type: string
    
    communication_server_ip:
      type: string
    
    python_file:
      type: File

    # initial_round:
    #   type: string


  # outputs: []
  outputs:
    weights:
      type: File[]
      outputSource: receive_weights/weights
    upload_state:
      type: File[]
      outputSource: upload/upload_state
    aggregation_endpoint_state:
      type: File
      outputSource: enable_aggregator_endpoint/aggregator_endpoint_state    
    server_state:
      type: File
      outputSource: aggregation/server_state
    client_list:
      type: string[]
      outputSource: get_clients/client_list
    accuracy:
      type: string
      outputSource: validate_accuracy_threshold/accuracy


  


  steps: 

    discover:
      run: service_discovery.cwl
      in:
        communication_server_ip: communication_server_ip
        python_file: python_file
      out: [service_discovery_output]

    get_clients:
      run: read_clients.cwl
      in:
        datafile: discover/service_discovery_output
      out: [client_list]

    enable_aggregator_endpoint:
      run: aggregator_endpoint.cwl
      in: 
        keyfile: keyfile
        host: host
        command_endpoint: command_endpoint
        clients: get_clients/client_list
      out: [aggregator_endpoint_state]

    receive_weights:
      run: get_weights_single.cwl
      scatter: client_url
      in:
        client_url: get_clients/client_list
        round: round_help
        aggregator_endpoint_state: enable_aggregator_endpoint/aggregator_endpoint_state
      when: |
        $(inputs.aggregator_endpoint_state.size >0)
      scatterMethod: dotproduct
      out: [weights]
    
    upload:
      run: upload.cwl
      scatter: file_path2
      in: 
        file_path2: receive_weights/weights
        round: round_help
        aggregator_upload_url: aggregator_upload_url
      scatterMethod: dotproduct
      out: [upload_state]
    

    stop_aggregator_endpoint:
      run: stop_aggregator_endpoint.cwl
      in:
        host: host
        keyfile: keyfile
        command_stop: command_stop
        upload_state: upload/upload_state
      out: [stop_state]

    aggregation:
      run: aggregator.cwl
      in:
        host: host
        keyfile: keyfile
        mode: mode_aggregation
        command: command
        training_round: round_help
        stop_state: stop_aggregator_endpoint/stop_state
      when: |
        $(inputs.stop_state.size <=0)
      out: [server_state]

    validate_accuracy_threshold:
      run: threshold_validation.cwl
      in:
        datafile: aggregation/server_state
      out: [accuracy]


      
   


