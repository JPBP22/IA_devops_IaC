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


resource storageAccount'Microsoft.Storage/storageAccounts@2022-05-01' = {
    name: storageAccountName
    location: 'westeurope'
    sku: {
      name: 'Standard_LRS'
    }
    kind: 'StorageV2'
    properties : {
      accessTier: 'Hot'
  }
}

resource appServicePlan 'Microsoft.Web/serverFarms@2022-03-01' = {
    name: appServicePlanName
    location: 'westeurope'
    sku: {
      name: 'F1'
  }
}

resource appServiceApp 'Microsoft.Web/sites@2022-03-01' = {
  name: appServiceAppName 
  location: 'westeurope'
  properties: {
    serverFarmId: appServicePlan.id
    httpsOnly: true
    }
}

resource ServiceApp 'Microsoft.Web/sites@2022-03-01' = {
  name: ServiceAppName
  location: 'westeurope'
  properties: {
    serverFarmId: appServicePlan.id
    httpsOnly: true
    }
}
