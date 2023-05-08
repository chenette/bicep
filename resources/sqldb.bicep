// =========== sqldb.bicep ===========

// USER-PROVIDED PARAMETERS
param application string
param environment string
param instance string = '1'

// PROPERTIES PARAMETERS
param azureADOnlyAuthentication bool = true
param minimalTlsVersion string = '1.2'
param publicNetworkAccess string = 'Disabled'

// BASE PARAMETERS
param name string = 'sql-${application}-${environment}-${location}-${padLeft(instance, 3, '0')}'
param location string = resourceGroup().location
param sku object = {
  capacity: 1
  family: 'Gen5'
  name: 'GP_S_Gen5'
  tier: 'GeneralPurpose'
}
// RESOURCE
resource sqldb 'Microsoft.Sql/servers/databases@2022-08-01-preview' = {
  name: name
  location: location
  sku: sku
}
