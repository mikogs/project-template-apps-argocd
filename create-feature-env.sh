#!/bin/bash

if [[ "$1" == "" ]]; then
  echo "Syntax: create-feature-env.sh ENV_NAME"
  exit 1
fi

cat >overlays/devenv/region/fe-$1.yaml <<EOF
---
apiVersion: argoproj.io/v1alpha1
kind: Application
metadata:
  name: fe-$1-node
  namespace: devenv-argocd
spec:
  project: default
  source:
    repoURL: https://github.com/mikogs/project-template-envs.git
    path: featureenvs/$1/
    targetRevision: HEAD
  destination:
    server: 'https://kubernetes.default.svc'
    namespace: fe-$1
  syncPolicy:
    automated: {}
    syncOptions:
      - CreateNamespace=true

EOF
cd overlays/devenv/region
kustomize edit add resource fe-$1.yaml
