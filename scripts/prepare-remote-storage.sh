#!/bin/bash

# -----------------------------
# Script to create Azure Storage for Terraform Remote State
# -----------------------------

# Logging functions
log_info()    { echo -e "[\e[1;94mINFO\e[0m] $*"; }
log_warn()    { echo -e "[\e[1;93mWARN\e[0m] $*"; }
log_error()   { echo -e "[\e[1;91mERROR\e[0m] $*"; }
log_success() { echo -e "[\e[1;92mSUCCESS\e[0m] $*"; }

RESOURCE_GROUP="$1"
STORAGE_ACCOUNT="$2"
CONTAINER="$3"
SUBSCRIPTION="$4"
LOCATION="${5:-eastus}"  # Default to eastus if not provided

# -----------------------------
# Set subscription if provided
# -----------------------------
if [[ -n "$SUBSCRIPTION" ]]; then
    log_info "Setting subscription to: $SUBSCRIPTION"
    SUBSCRIPTION="--subscription $SUBSCRIPTION"
    
    # Verify subscription exists
    if ! az account show --subscription "$SUBSCRIPTION" &>/dev/null; then
        log_error "Subscription '$SUBSCRIPTION' not found or not accessible"
        log_info "Available subscriptions:"
        az account list --output table
        exit 1
    fi
else
    SUBSCRIPTION=""
    log_info "Using default subscription"
fi

# -----------------------------
# Create Resource Group
# -----------------------------
log_info "Checking if resource group $RESOURCE_GROUP exists..."
if az group show --name "$RESOURCE_GROUP" &>/dev/null; then
    log_warn "Resource group $RESOURCE_GROUP already exists. Exiting."
else
    log_info "Creating resource group: $RESOURCE_GROUP in $LOCATION..."
    RG_OUTPUT=$(az group create --name "$RESOURCE_GROUP" --location "$LOCATION" 2>&1) || {
        log_error "Failed to create resource group: $RG_OUTPUT"
        exit 1
    }
    log_success "Resource group created."
fi
# -----------------------------
# Create Storage Account
# -----------------------------
log_info "Checking if storage account $STORAGE_ACCOUNT exists..."
if az storage account show --name "$STORAGE_ACCOUNT" --resource-group "$RESOURCE_GROUP" --subscription "$SUBSCRIPTION" &>/dev/null; then
    log_warn "Storage account $STORAGE_ACCOUNT already exists. Exiting."
    exit 0
else
    log_info "Creating storage account: $STORAGE_ACCOUNT..."
    SA_OUTPUT=$(az storage account create \
        --name "$STORAGE_ACCOUNT" \
        --resource-group "$RESOURCE_GROUP" \
        --location "$LOCATION" \
        --sku Standard_LRS \
        2>&1) || {
            log_error "Failed to create storage account: $SA_OUTPUT"
            exit 1
    }
    log_success "Storage account created."
fi
# -----------------------------
# Get Storage Account Key
# -----------------------------
log_info "Fetching storage account key..."
STORAGE_KEY=$(az storage account keys list \
    --resource-group "$RESOURCE_GROUP" \
    --account-name "$STORAGE_ACCOUNT" \
    --query "[0].value" -o tsv 2>&1) || {
        log_error "Failed to retrieve storage account key"
        exit 1
}
log_success "Storage account key retrieved."

# -----------------------------
# Create Blob Container
# -----------------------------
log_info "Checking if blob container $CONTAINER exists..."
if az storage container show \
    --name "$CONTAINER" \
    --account-name "$STORAGE_ACCOUNT" \
    --account-key "$STORAGE_KEY" &>/dev/null; then
    log_warn "Blob container $CONTAINER already exists. Exiting."
    exit 0
else
    log_info "Creating blob container: $CONTAINER..."
    CONTAINER_OUTPUT=$(az storage container create \
        --name "$CONTAINER" \
        --account-name "$STORAGE_ACCOUNT" \
        --account-key "$STORAGE_KEY" 2>&1) || {
            log_error "Failed to create container: $CONTAINER_OUTPUT"
            exit 1
    }
    log_success "Blob container created."
fi