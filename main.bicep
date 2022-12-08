

resource storageAccount'Microsoft.Storage/storageAccount@2202-05-01' = {
    name: 'jpb_sotrage''
    location "westus3"
    sku: {
      name: 'Standard_LRS'
    }
    kind: 'StorgaeV2'
    properties : {
      accessTier: 'Hot'
    }
}
