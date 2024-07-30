cwlVersion: v1.0
class: CommandLineTool
baseCommand: curl
requirements:
  InlineJavascriptRequirement: {}
inputs:
  client_url:
    type: string

  round :
    type: string



arguments: 
  - valueFrom: "-O" 
  - valueFrom: |
  
      ${
        var lastSlashIndex = inputs.client_url.lastIndexOf("/");
        var newUrl = '';
        if (lastSlashIndex >= 0) {
          newUrl = inputs.client_url.slice(0, lastSlashIndex) + '/' + inputs.round  + inputs.client_url.slice(lastSlashIndex);
          console.log(newUrl); 
        } else {
          console.log("Invalid URL");
        }
        return newUrl;
      }

outputs:
  weights:
    type: File
    outputBinding:
      glob:
         $(inputs.client_url.substring(inputs.client_url.lastIndexOf("/") + 1))