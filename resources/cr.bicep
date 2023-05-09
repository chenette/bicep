// =========== cr.bicep ===========

// USER-PROVIDED PARAMETERS
param application string
param environment string
param instance string = '1'

// BASE PARAMETERS
param name string = 'cr${application}${environment}${padLeft(instance, 3, '0')}'
param location string = resourceGroup().location
param sku object = {
  name: ''
}
param properties object = {
  adminUserEnabled: true
}

resource cr 'Microsoft.ContainerRegistry/registries@2023-01-01-preview' = {
  name: name
  location: location
  sku: sku
  properties: properties
}

// For the future of having secure outputs
// https://github.com/Azure/bicep/issues/2163
