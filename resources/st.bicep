// =========== st.bicep ===========

// USER-PROVIDED PARAMETERS
param application string
param environment string
param instance string = '1'

// BASE PARAMETERS
param name string = 'asp-${application}-${environment}-${location}-${padLeft(instance, 3, '0')}'
param location string = resourceGroup().location
param sku object = {
  name: 'Standard_LRS'
}
param kind string = 'StorageV2'

// RESOURCE
resource st 'Microsoft.Storage/storageAccounts@2022-09-01' = {
  name: name
  location: location
  sku: sku
  kind: kind
}

// OUTPUTS
