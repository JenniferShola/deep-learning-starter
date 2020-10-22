# To use this file. Export the following variables in bash_profile.
# AZ_DEV_VITRUAL_MACHINE
# AZ_RESOURCE_GROUP
# AZ_LAB_NAME
# DOCKER_HUB_REPO
#
# This file takes two arguments: 
# -i name of the image to be saved to docker hub
# -f name of the command or python file for the call to docker run

# Return if required environment variables are not set.
if [ -z "$AZ_DEV_VITRUAL_MACHINE" ] || [ -z "$AZ_LAB_NAME" ] ||
    [ -z "$AZ_DEV_VITRUAL_MACHINE" ] || [ -z "$DOCKER_HUB_REPO" ]:
        echo "The required environment variables are not set"
        return 1 2>/dev/null
        exit 
fi

# Get the flags passed into this file
while getopts u:d:p:f: option 
do
    case "${option}" in
        i) IMAGE_NAME=${OPTARG};;
        f) FILE_TO_RUN=${OPTARG};;
    esac
done

# Return if required arguments are not passed.
if [ -z "$IMAGE_NAME" ] || [ -z "$FILE_TO_RUN" ]:
    echo "Needs at least two arguments"
    return 1 2>/dev/null
    exit 
fi

# Sign in to Azure
az login 

# Start the dev VM on Azure
az vm start --name $AZ_DEV_VITRUAL_MACHINE --resource-group $AZ_RESOURCE_GROUP

# Build the docker image on the allocated VM
docker build -f Dockerfile train -t melanoma:train .

# Push the build image to a serve (docker hub)
docker push $DOCKER_HUB_REPO:$IMAGE_NAME aialmanac/ml-playground:melanoma

# Push the build image to a serve (docker hub)
docker run -it --rm --gpus all ubuntu $FILE_TO_RUN

# Deallocate the VM on Azure
az vm deallocate --name $AZ_DEV_VITRUAL_MACHINE --resource-group $AZ_RESOURCE_GROUP
