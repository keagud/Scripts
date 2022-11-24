#!usr/bin/bash


if [[ ! -d venv ]]; then

  echo "no virtualenv found here- making one now..."
  virtualenv venv

  if [[ -f requirements.txt ]]; then
    echo "requirements.txt found!"
    echo "installing..."
    pip install -r requirements.txt
  fi
  
fi

source venv/bin/activate
pip $@

echo "updating requirements.txt..."
echo ""
pip freeze | tee "requirements.txt"





