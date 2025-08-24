#!/bin/bash

# -----------------------------
# Script to create Azure Storage for Terraform Remote State
# -----------------------------

# Logging functions
log_info()    { echo -e "[\e[1;94mINFO\e[0m] $*"; }
log_warn()    { echo -e "[\e[1;93mWARN\e[0m] $*"; }
log_error()   { echo -e "[\e[1;91mERROR\e[0m] $*"; }
log_success() { echo -e "[\e[1;92mSUCCESS\e[0m] $*"; }

# -----------------------------
# Read environment variables from GitHub Actions or script arguments
# -----------------------------
RESOURCE_GROUP="${RESOURCE_GROUP:-$1}"
STORAGE_ACCOUNT="${STORAGE_ACCOUNT:-$2}"
CONTAINER="${CONTAINER_NAME:-$3}"
LOCATION="${LOCATION:-eastus}"
SUBSCRIPTION="${SUBSCRIPTION_ID:-$4}"

# Validate required variables
if [[ -z "$RESOURCE_GROUP" || -z "$STORAGE_ACCOUNT" || -z "$CONTAINER" || -z "$SUBSCRIPTION" ]]; then
    log_error "Missing required parameters. Provide RESOURCE_GROUP, STORAGE_ACCOUNT, CONTAINER_NAME, and SUBSCRIPTION_ID."
    exit 1
fi

# -----------------------------
# Create Resource Group if it doesn't exist
# -----------------------------
log_info "Checking if resource group $RESOURCE_GROUP exists..."
if az group show --name "$RESOURCE_GROUP" --subscription "$SUBSCRIPTION" &>/dev/null; then
    log_warn "Resource group $RESOURCE_GROUP already exists."
else
    log_info "Creating resource group: $RESOURCE_GROUP in $LOCATION..."
    az group create --name "$RESOURCE_GROUP" --location "$LOCATION" --subscription "$SUBSCRIPTION" || {
        log_error "Failed to create resource group."
        exit 1
    }
    log_success "Resource group created."
fi

# -----------------------------
# Create Storage Account if it doesn't exist
# -----------------------------
log_info "Checking if storage account $STORAGE_ACCOUNT exists..."
if az storage account show --name "$STORAGE_ACCOUNT" --resource-group "$RESOURCE_GROUP" --subscription "$SUBSCRIPTION" &>/dev/null; then
    log_warn "Storage account $STORAGE_ACCOUNT already exists."
else
    log_info "Creating storage account: $STORAGE_ACCOUNT..."
    az storage account create \
        --name "$STORAGE_ACCOUNT" \
        --resource-group "$RESOURCE_GROUP" \
        --location "$LOCATION" \
        --sku Standard_LRS \
        --subscription "$SUBSCRIPTION" || {
        log_error "Failed to create storage account."
        exit 1
    }
    log_success "Storage account created."
fi

# -----------------------------
# Create Blob Container if it doesn't exist
# -----------------------------
log_info "Checking if blob container $CONTAINER exists..."
if az storage container show \
    --name "$CONTAINER" \
    --account-name "$STORAGE_ACCOUNT" \
    --auth-mode login &>/dev/null; then
    log_warn "Blob container $CONTAINER already exists."
else
    log_info "Creating blob container: $CONTAINER..."
    az storage container create \
        --name "$CONTAINER" \
        --account-name "$STORAGE_ACCOUNT" \
        --auth-mode login || {
        log_error "Failed to create blob container."
        exit 1
    }
    log_success "Blob container created."
fi