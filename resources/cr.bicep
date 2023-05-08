// =========== cr.bicep ===========

param name string
param location string
param sku string

resource cr 'Microsoft.ContainerRegistry/registries@2022-02-01-preview' = {
  name: name
  location: location
  sku: {
    name: sku
  }
  properties: {
    adminUserEnabled: true
  }
}

resource kv 'Microsoft.KeyVault/vaults@2021-11-01-preview' = {
  name: name
  location: location
  properties: {
    enabledForTemplateDeployment: true
    tenantId: tenant().tenantId
    accessPolicies: []
    sku: {
      name: 'standard'
      family: 'A'
    }
  }
  resource crUsername 'secrets' = {
    name: 'crUsername'
    properties: {
      value: cr.listCredentials().username
    }
  }
  resource crPassword1 'secrets' = {
    name: 'crPassword1'
    properties: {
      value: cr.listCredentials().passwords[0].value
    }
  }
  resource crPassword2 'secrets' = {
    name: 'crPassword2'
    properties: {
      value: cr.listCredentials().passwords[1].value
    }
  }
}

// output resource resource = cr
