// =========== sql.bicep ===========

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
param properties object = {
  administrators: {
    azureADOnlyAuthentication: azureADOnlyAuthentication
    login: 'matthew@chenette.com' //'Global DBAs'
    principalType: 'User' //'Group'
    sid: '84574441-38cc-4302-be53-903f57446fdb' //'16f797d0-d11e-436c-a20e-1415561cfe93'
  }
  minimalTlsVersion: minimalTlsVersion
  publicNetworkAccess: publicNetworkAccess
}

// RESOURCE
resource sql 'Microsoft.Sql/servers@2022-08-01-preview' = {
  name: name
  location: location
  properties: properties
}

// OUTPUTS
output resourceId string = sql.id
