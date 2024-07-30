#!/usr/bin/env cwl-runner

cwlVersion: v1.2
class: Workflow

$namespaces:
  cwltool: "http://commonwl.org/cwltool#"
  s: https://schema.org/

$schemas:
 - https://schema.org/version/latest/schemaorg-current-http.rdf
 
requirements:
  InlineJavascriptRequirement: {}
  SubworkflowFeatureRequirement: {}
  StepInputExpressionRequirement: {}

hints:
  ResourceRequirement:
     coresMin: 4

inputs: 
    clients:
      type: string[]
    keyfile:
      type:  File
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
        type: int

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
        central_federated_learning_round/output_model
steps:
  initialize:
      run: aggregator.cwl
      in: 
        keyfile: keyfile
        host: host
        command: command
        mode: mode_initialization
        training_round: round
      out: [server_state]
  central_federated_learning_round:
    in:
      round:
        default: 0
      rounds: rounds
      clients: clients
        # clients: get_clients/client_list
      python_file: python_file
      communication_server_ip: communication_server_ip
      keyfile: keyfile
      host: host
      command: command
      mode_initialization: mode_initialization
      aggregator_upload_url:  aggregator_upload_url
      command_endpoint: command_endpoint
      command_stop: command_stop
      mode_aggregation: mode_aggregation
      server_state: initialize/server_state


    out: [output_model]
    requirements:
      cwltool:Loop:
        loopWhen: $(inputs.round < inputs.rounds)
        loop:
          round:
            valueFrom: $(inputs.round + 1)
          input_model: output_model
        outputMethod:  all
    run:
      class: Workflow
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

        # rounds:
        #   type: string[]

        round:
          type: int

        communication_server_ip:
          type: string
        
        python_file:
          type: File

      outputs:
        output_model:
          type: File
          outputSource:
            central_federated_learning_round/aggregation_state

      steps:

        central_federated_learning_round:
          run: rest.cwl
          in: 
            round: round
            round_help: 
              valueFrom: $(String(inputs.round))
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
          out: [aggregation_state]

  
