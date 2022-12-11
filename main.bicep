@sys.description('The Web App name')
@minLength(3)
@maxLength(24)
param ServiceAppName string = 'JP-app-bicep-be'


@sys.description('The Web App name')
@minLength(3)
@maxLength(24)
param appServiceAppName string = 'JP-app-bicep-fe'


@sys.description('The App Service Plan name')
@minLength(3)
@maxLength(24)
param appServicePlanName string = 'JP-asp-bicep'


@sys.description('The Storage Account name')
@minLength(3)
@maxLength(24)
param storageAccountName string = 'jpbellostorage'
@allowed([
  'nonprod'
  'prod'
])
param enviormentType string = 'nonprod'
param location string = resourceGroup().location

var storageAccountSkuName = (enviormentType == 'prod') ? 'Standard_GRS' : 'Standard_LRS'
var appServicePlanSkuName = (enviormentType == 'nonprod') ? 'P2V3' : 'F1'


resource storageAccount'Microsoft.Storage/storageAccounts@2022-05-01' = {
    name: storageAccountName
    location: location
    sku: {
      name: storageAccountSkuName
    }
    kind: 'StorageV2'
    properties : {
      accessTier: 'Hot'
  }
}

resource appServicePlan 'Microsoft.Web/serverFarms@2022-03-01' = {
    name: appServicePlanName
    location: location
    sku: {
      name: appServicePlanSkuName
  }
}

resource appServiceApp 'Microsoft.Web/sites@2022-03-01' = {
  name: appServiceAppName 
  location: location
  properties: {
    serverFarmId: appServicePlan.id
    httpsOnly: true
    }
}

resource ServiceApp 'Microsoft.Web/sites@2022-03-01' = {
  name: ServiceAppName
  location: location
  properties: {
    serverFarmId: appServicePlan.id
    httpsOnly: true
    }
}
