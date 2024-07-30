#!/usr/bin/env cwl-runner
cwlVersion: v1.1
class: ExpressionTool

requirements:
  - class: InlineJavascriptRequirement

inputs:
  datafile:
    type: File
    inputBinding:
      loadContents: true

outputs:
  accuracy:
    type: string

expression: "${var lines2 = inputs.datafile.contents.split('\\n');
                 lines2.pop();
                  return {'accuracy' : lines2.pop() } ;
              }"