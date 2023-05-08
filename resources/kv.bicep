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

resource kv 'Microsoft.KeyVault/vaults@2022-07-01' = {
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
