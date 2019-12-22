#! /usr/bin/env bash

echo "--- Welcome to preghenella/fun4all Docker container"
echo "--- Run the sPHENIX setup script, and you should be in business"
echo
echo "  # source /opt/sphenix/core/bin/sphenix_setup.sh -n"
echo

exec "$@"
