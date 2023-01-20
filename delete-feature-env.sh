#!/bin/bash

if [[ "$1" == "" ]]; then
  echo "Syntax: delete-feature-env.sh ENV_NAME"
  exit 1
fi

rm -rf overlays/devenv/region/fe-$1.yaml
cd overlays/devenv/region
kustomize edit remove resource fe-$1.yaml
