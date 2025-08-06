#!/bin/bash

ENVIRONMENT=${1:-dev}

echo "Deployando aplicação para ambiente: $ENVIRONMENT"

# Aplicar projeto ArgoCD
kubectl apply -f argocd/project.yaml

# Aplicar aplicação ArgoCD
if [ "$ENVIRONMENT" = "prod" ]; then
    sed 's/values-dev.yaml/values-prod.yaml/g' argocd/application.yaml | \
    sed 's/simple-web-app-dev/simple-web-app-prod/g' | \
    kubectl apply -f -
else
    kubectl apply -f argocd/application.yaml
fi

echo "Deploy iniciado! Verifique no ArgoCD UI."