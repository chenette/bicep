// =========== kv.bicep ===========

@minLength(3)
@maxLength(24)
param name string

param location string = resourceGroup().location
param tags object = {}

@allowed([
  'standard'
  'premium'
])
param skuName string = 'standard'

resource kv 'Microsoft.KeyVault/vaults@2023-02-01' = {
  name: name
  location: location
  tags: tags
  properties: {
    accessPolicies: []
    enabledForDeployment: false
    enabledForDiskEncryption: false
    enabledForTemplateDeployment: true
    enablePurgeProtection: false
    enableRbacAuthorization: false
    enableSoftDelete: false
    sku: {
      name: skuName
      family: 'A'
    }
    softDeleteRetentionInDays: 7
    tenantId: subscription().tenantId
  }
}


// resource kv 'Microsoft.KeyVault/vaults@2021-11-01-preview' = {
//   name: name
//   location: location
//   properties: {
//     enabledForTemplateDeployment: true
//     tenantId: tenant().tenantId
//     accessPolicies: []
//     sku: {
//       name: 'standard'
//       family: 'A'
//     }
//   }
//   resource crUsername 'secrets' = {
//     name: 'crUsername'
//     properties: {
//       value: cr.listCredentials().username
//     }
//   }
//   resource crPassword1 'secrets' = {
//     name: 'crPassword1'
//     properties: {
//       value: cr.listCredentials().passwords[0].value
//     }
//   }
//   resource crPassword2 'secrets' = {
//     name: 'crPassword2'
//     properties: {
//       value: cr.listCredentials().passwords[1].value
//     }
//   }
// }

// output resource resource = cr
