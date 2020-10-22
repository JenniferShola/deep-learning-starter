# Deallovate all running virtual dev machines
az vm deallocate --ids $(
    az vm list --query "[].id"
        -o tsv | grep "dev"
)