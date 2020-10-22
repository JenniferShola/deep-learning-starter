# To use this file. Export the following variables in bash_profile.
# AZ_DEV_VITRUAL_MACHINE
# AZ_RESOURCE_GROUP

# Sign in to Azure
az login 

## Start the VM
az vm start --name $AZ_DEV_VITRUAL_MACHINE --resource-group $AZ_RESOURCE_GROUP

## Build Docker Image
docker build -f Dockerfile train -t melanoma:train .

