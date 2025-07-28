#!/bin/bash

# This script would loop through various clusters and perform the commands you specify there
# Author - Karan

# Set your subscription here
subscription="PRD"
# example subscription="PRD"

# declaring array of clusters and resource groups
# please add your own AKS cluster names and 
# your own resource group names under which aks cluster reside
# using dummy data here only 
# use the indexes as your namespaces are written i.e if your namespace is prd-index1 -- index1 to be used a index of array clusters here
declare -A clusters=( 
    ["index1"]="PRD-cluster1"
    ["index2"]="PRD-cluster2"
    ["index3"]="PRD-cluster3"
    ["index4"]="PRD-cluster4"
    ["index5"]="PRD-cluster5"
)

declare -A resourceGroups=(
    ["index1"]="PRD-RG-1-rg"
    ["index2"]="PRD-RG-2-rg"
    ["index3"]="PRD-RG-3-rg"
    ["index4"]="PRD-RG-4-rg"
    ["index5"]="PRD-RG-5-rg"
)

# Looping through each cluster 
for region in "${!clusters[@]}";do
cl="${clusters[$region]}"
rg="${resourceGroup[$region]}"
# Using the index of arrays- (clusters and resourceGroups) to substitute the value of that index to local variables - cl and rg , to get the complete names

echo "Entering cluster  $cl"
echo "Resource group $rg"

# the get cluster credentials command here 
az aks get-credentials \
--resource-group "$rg" \
--name "$cl" \
--subscription "$subscription" \
--overwrite-existing

# Converting the kubeconfig to Azure CLI login 
kubelogin convert-kubeconfig -l azurecli

# Commands to be fired written here
kubectl -n prd-$region get hpa

echo "End of cluster $cl"
done