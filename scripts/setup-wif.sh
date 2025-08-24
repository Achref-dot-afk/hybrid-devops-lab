#!/bin/bash

# -----------------------------
# Script to create Azure AD App, Service Principal, and Federated Credential
# -----------------------------

# Logging functions
log_info()    { echo -e "[\e[1;94mINFO\e[0m] $*"; }
log_warn()    { echo -e "[\e[1;93mWARN\e[0m] $*"; }
log_error()   { echo -e "[\e[1;91mERROR\e[0m] $*"; }
log_success() { echo -e "[\e[1;92mSUCCESS\e[0m] $*"; }

# Check for required arguments
if [[ $# -lt 3 ]]; then
    log_error "Usage: $0 <APP_NAME> <AZ_SUBSCRIPTION_ID> <AZ_RESOURCE_GROUP>"
    exit 1
fi

APP_NAME="$1"
AZ_SUBSCRIPTION_ID="$2"
AZ_RESOURCE_GROUP="$3"

log_info "Fetching tenant ID..."
AZ_TENANT_ID=$(az account show --query tenantId -o tsv) || { log_error "Failed to get tenant ID"; exit 1; }
log_success "Tenant ID: $AZ_TENANT_ID"

# Create app registration
log_info "Creating Azure AD app registration: $APP_NAME..."
APP_CREATE_OUTPUT=$(az ad app create --display-name "$APP_NAME" 2>&1) || { log_error "Failed to create app: $APP_CREATE_OUTPUT"; exit 1; }
log_success "App registration created."

# Get client_id and object_id
log_info "Retrieving app ID and object ID..."
APP_ID=$(az ad app list --display-name "$APP_NAME" --query "[0].appId" -o tsv) || { log_error "Failed to get app ID"; exit 1; }
APP_OBJ_ID=$(az ad app list --display-name "$APP_NAME" --query "[0].id" -o tsv) || { log_error "Failed to get app object ID"; exit 1; }
log_success "App ID: $APP_ID, Object ID: $APP_OBJ_ID"

# Create service principal
log_info "Creating service principal..."
SP_OUTPUT=$(az ad sp create --id "$APP_ID" 2>&1) || { log_error "Failed to create service principal: $SP_OUTPUT"; exit 1; }
log_success "Service principal created."

# Assign Contributor role
log_info "Assigning 'Contributor' role to service principal on resource group $AZ_RESOURCE_GROUP..."
ROLE_ASSIGN_OUTPUT=$(az role assignment create \
    --assignee "$APP_ID" \
    --role Contributor \
    --scope "/subscriptions/$AZ_SUBSCRIPTION_ID/resourceGroups/$AZ_RESOURCE_GROUP" 2>&1) || { log_error "Role assignment failed: $ROLE_ASSIGN_OUTPUT"; exit 1; }
log_success "Role assignment completed."

# Create federated credential
log_info "Creating federated credential for GitHub Actions..."
FED_CRED_OUTPUT=$(az ad app federated-credential create \
  --id "$APP_ID" \
  --parameters "{
    \"name\": \"github-oidc\",
    \"issuer\": \"https://token.actions.githubusercontent.com\",
    \"subject\": \"repo:<YOUR_ORG>/<YOUR_REPO>:ref:refs/heads/main\",
    \"audiences\": [\"api://AzureADTokenExchange\"]
  }" 2>&1) || { log_error "Failed to create federated credential: $FED_CRED_OUTPUT"; exit 1; }
log_success "Federated credential created successfully."
