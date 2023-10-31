#!/bin/bash


ssh user@$CONDA_SERVER  <<-'ENDSSH'
  'jupyter notebook --no-browser --port=8080'
ENDSSH
