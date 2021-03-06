#!/usr/bin/env bash
set -ex

make uninstall
pip install aws-allowlister

# Check that it runs without error
aws-allowlister --help
aws-allowlister --version

# Get the latest tag
git fetch origin
latest_tag=$(git describe --tags `git rev-list --tags --max-count=1`)
echo "latest tag: $latest_tag"
mkdir -p examples/${latest_tag}/
mkdir -p examples/latest/

# Create directory if it does not exist, then write the SCP to that path specific to the version
# Also update it to a "latest" folder, that way we can view the diff in commits.
# All
aws-allowlister generate --quiet > examples/${latest_tag}/All-AllowList-SCP.json
aws-allowlister generate --quiet > examples/latest/All-AllowList-SCP.json
# SOC
aws-allowlister generate -s --quiet > examples/${latest_tag}/SOC-AllowList-SCP.json
aws-allowlister generate -s --quiet > examples/latest/SOC-AllowList-SCP.json
# PCI
aws-allowlister generate -p --quiet > examples/${latest_tag}/PCI-AllowList-SCP.json
aws-allowlister generate -p --quiet > examples/latest/PCI-AllowList-SCP.json
# HIPAA
aws-allowlister generate -h --quiet > examples/${latest_tag}/HIPAA-AllowList-SCP.json
aws-allowlister generate -h --quiet > examples/latest/HIPAA-AllowList-SCP.json
# ISO
aws-allowlister generate -i --quiet > examples/${latest_tag}/ISO-AllowList-SCP.json
aws-allowlister generate -i --quiet > examples/latest/ISO-AllowList-SCP.json
# FedRAMP High
aws-allowlister generate -fh --quiet > examples/${latest_tag}/FedRAMP_High-AllowList-SCP.json
aws-allowlister generate -fh --quiet > examples/latest/FedRAMP_High-AllowList-SCP.json
# FedRAMP Moderate
aws-allowlister generate -fm --quiet > examples/${latest_tag}/FedRAMP_Moderate-AllowList-SCP.json
aws-allowlister generate -fm --quiet > examples/latest/FedRAMP_Moderate-AllowList-SCP.json
# FedRAMP All
aws-allowlister generate -fm -fh --quiet > examples/${latest_tag}/FedRAMP_All-AllowList-SCP.json
aws-allowlister generate -fm -fh --quiet > examples/latest/FedRAMP_All-AllowList-SCP.json

