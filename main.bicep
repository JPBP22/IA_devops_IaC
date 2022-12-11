@sys.description('The Web BE App name')
@minLength(3)
@maxLength(24)
param ServiceAppName string = 'JP-assignment-be'


@sys.description('The Web FE App name')
@minLength(3)
@maxLength(24)
param appServiceAppName string = 'JP-assignemnt-fe'


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

module appService 'modules/appstuff.bicep' = {
  name: 'appService'
  params:{
    location: location
    appServiceAppName:appServiceAppName
    ServiceAppName:ServiceAppName
    appServicePlanName: appServicePlanName
    enviormentType:enviormentType

  }
}

output appServiceAppHostName string = appService.outputs.appServiceAppHostName
