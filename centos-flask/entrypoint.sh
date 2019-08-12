#!/bin/bash
set -e

# create and use virtualenv
VENV_DIR="/opt/flask/venv"
VENV_ACTIVATE_PATH="/opt/flask/venv/bin/activate"
if [ ! -d "$VENV_ACTIVATE_PATH" ]; then
  virtualenv $VENV_DIR
fi
source $VENV_ACTIVATE_PATH

exec "$@"
