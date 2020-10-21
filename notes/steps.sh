az account list-locations \
  --query "[].{Name: name, DisplayName: displayName}" \
  --output table

REGION=eastus2
az configure --defaults location=$REGION

webappsuffix=$RANDOM
resourcegroup=tailspin-space-game-rg
az group create --name tailspin-space-game-rg

az appservice plan create \
  --name tailspin-space-game-asp \
  --resource-group $resourcegroup \
  --sku B1

az webapp create \
  --name tailspin-space-game-web-dev-$webappsuffix \
  --resource-group $resourcegroup \
  --plan tailspin-space-game-asp

az webapp create \
  --name tailspin-space-game-web-test-$webappsuffix \
  --resource-group $resourcegroup \
  --plan tailspin-space-game-asp

az webapp create \
  --name tailspin-space-game-web-staging-$webappsuffix \
  --resource-group $resourcegroup \
  --plan tailspin-space-game-asp

az webapp list \
  --resource-group $resourcegroup \
  --query "[].{hostName: defaultHostName, state: state}" \
  --output table

# Instances
# tailspin-space-game-web-staging-11918.azurewebsites.net
# tailspin-space-game-web-dev-11918.azurewebsites.net
# tailspin-space-game-web-test-11918.azurewebsites.net

git fetch upstream release
git checkout -b release upstream/release

