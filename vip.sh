#!/usr/bin/bash

start_dir=$PWD
venv_root_dir=$start_dir


 # look in higher directories for an existing venv
 # OR a git directory indicating the root of a repo
 #

while [[ $PWD != '/' ]]; do

  if [[ -d .venv ]] || [[ -d .git ]] ; then
    venv_root_dir=$PWD
    echo "Project root determined as $venv_root_dir"
    break
  fi

  cd ..

done

cd $venv_root_dir

if ! [[ -d .venv ]]; then
  echo "no virtualenv found here- making one now..."
  python -m virtualenv venv
fi


if [[ -f requirements.txt ]]; then 
  echo "located requirements.txt at $venv_root_dir"; 

else 
  echo "no requirements.txt found! creating...";
  touch requirements.txt;

fi



source .venv/bin/activate
pip freeze | sort > .old_requirements.txt

if [[  $# > 1 ]]; then
  pip $@

  pip freeze | sort > requirements.txt

  echo -e "|Removed|\t|Added|\t|Current Total|"
  #possible TODO make this print nicer
  comm -3 .old_requirements.txt requirements.txt --total
fi


rm -f .old_requirements.txt
cd $start_dir
