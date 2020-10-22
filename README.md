
# deep-learning-starter

A starter repo for building and deploying deep learning models on docker containers (to Azure)

## Installation Instructions

### Mac (Docker & Azure)

1. Install Docker on your machine.

    `brew install docker`

    If docker (the application) is already downloaded on your computer, you will have to force the cli tool which will re-download the application as well.

    `brew install docker --force`

2. Confirm that Docker is running.

    `docker --version`

3. Confirm that docker can access the local Docker image.

    `docker run hello-world`

    If docker cannot find the daemon, follow the below instructions:

    1. Create the docker group

        - LINUX: `sudo groupadd docker`
  
        - MAC: `sudo dscl . -create /groups/docker` OR `brew install docker-machine docker`

4. Add your system user id to the docker group

    LINUX: `sudo usermod -G docker -a USERNAME`

    MAC: `sudo dscl . append /groups/docker GroupMembership USERNAME`

5. Confirm that docker can access the local Docker image.

    `docker run hello-world`

6. List the docker images on your machine (to confirm that docker is working as expected).

    ```bash
    docker image ls
    docker ps --all
    ```

7. Clone the starter deep learning project

    `git clone https://github.com/JenniferShola/deep-learning-starter.git`

    `cd deep-learning-starter/`

8. Install Azure CLI tools

    `brew install azure-cli`

    1. depending on your Mac OS verion, you might need to install command line tools to finish this step. If so:

        `xcode-select --install`

    2. Try reinstalling the azure cli tools.

        `brew install azure-cli`

9. Check that Azure cli was downloaded correctly.

    `az --version`

### Docker Machine

#### Docker Daemon Error

- If you see the following error in Mac, you need to install docker-machine:

    `Cannot connect to the Docker daemon at unix:///var/run/docker.sock. Is the docker daemon running?`

#### Docker Machine Installation Instructions

1. Install docker

    `curl -L https://github.com/docker/machine/releases/download/v0.16.0/docker-machine-'uname -s'-'uname -m' >/tmp/docker-machine && chmod +x /tmp/docker-machine && sudo cp /tmp/docker-machine /usr/local/bin/docker-machine`

2. Create default

    `docker-machine create default`

3. Set docker env

    `eval $(docker-machine env)`

4. To have launchd start docker-machine now and restart at login:

    `brew services start docker-machine`

    Or, if you don't want/need a background service you can just run:

    `docker-machine start`

## Common Commands

## Azure

- Login to Azure

    `azure login`

    `az login`

- Start the virtual machine on Azure

    `az vm start --name AZURE_VITRUAL_MACHINE_NAME --resource-group AZURE_RESOURCE_GROUP_NAME`

- Deallocate the virtual machine on Azure

    `az vm deallocate --name AZURE_VITRUAL_MACHINE_NAME --resource-group AZURE_RESOURCE_GROUP_NAME`

    **IMPORTANT:** Make sure to use the **deallocate** command (`az vm deallocate` instead of `az vm stop`). Deallocate releases resources from the virtual machine which halts any further charges.

    If you use the stop command, it stops the virtual machine but does **not** release the resources which essentially means that you will still be charged for the use of the resources (when though the vm is stopped).

### Docker

If you're confused on how to use docker, consider reviewing the [documentation](https://docs.docker.com/engine/reference/commandline/cli/#environment-variables) or watch a [tutorial](https://youtu.be/jPdIRX6q4jA).

- Create docker remote context to VM

    `docker context create remote ‐‐docker “host=ssh://user@remotemachine”`

- To specify a context:

    `docker context use remote`

- To see all the processes in a docker context:

    `docker --context remote ps`

- To execute a command in a running container, run:

    `docker exec -t <CONTAINER_ID> COMMAND`

- Run a docker process in the current directory:

    `docker run .`

- To view logs from your container, run:

    `docker logs <CONTAINER_ID>`

- To stop and remove a container from ACI, run:

    ```bash
    docker stop <CONTAINER_ID>
    docker rm <CONTAINER_ID>
    ```
