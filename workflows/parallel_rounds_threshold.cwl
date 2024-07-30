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
    
    # round_help:
    #     type: string

    initial_round:
      type: string

    round:
      type: int

    communication_server_ip:
      type: string
    
    python_file:
      type: File
    accuracy_input:
      type: string

outputs: 
    output_model:
      type: string[]
      outputSource: 
        central_federated_learning_round/accuracy
steps:
  initialize:
      run: aggregator.cwl
      in: 
        keyfile: keyfile
        host: host
        command: command
        mode: mode_initialization
        training_round: initial_round
      out: [server_state]

  central_federated_learning_round:
          in: 
            round: 
              default: 0
            accuracy_input: accuracy_input
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
            server_state: initialize/server_state

          run: threshold_workflow.cwl
          out: [accuracy]
          requirements:
            cwltool:Loop:
              loopWhen: |
              
                ${ 


                      #   ${ 

                #   if (inputs.round > 0 ){
                #     var tranining_accuracy = String(inputs.accuracy_input).substring(18,24);
                #     console.log(String(tranining_accuracy));
                #     return parseFloat(tranining_accuracy) > 98.0

                #   } else{
                #     return String(inputs.accuracy_input).includes('raining');
                #   }
                # }
                }
              loop:
                # accuracy: 
                #   valueFrom: $(inputs.accuracy)
                accuracy_input: accuracy
                round:
                  valueFrom: $(inputs.round + 1)
              outputMethod:  all
    

                #   ${ 

                #   if (inputs.round > 0 ){
                #     var tranining_accuracy = String(inputs.accuracy_input).substring(18,24);
                #     console.log(String(tranining_accuracy));
                #     return parseFloat(tranining_accuracy) > 98.0

                #   } else{
                #     return String(inputs.accuracy_input).includes('raining');
                #   }
                # }
