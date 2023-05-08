// =========== app.bicep ===========

// USER-PROVIDED PARAMETERS
param application string
param environment string
param instance string = '1'
param aspId string

@secure()
param clid string
@secure()
param clse string

// PROPERTIES PARAMETERS
param httpsOnly bool = true
param isLinux bool = true

// BASE PARAMETERS
param name string = 'asp-${application}-${environment}-${location}-${padLeft(instance, 3, '0')}'
param location string = resourceGroup().location
param kind string = 'app,linux,container'
param properties object = {
  httpsOnly: httpsOnly
  reserved: isLinux
  serverFarmId: aspId
  siteConfig: {
    alwaysOn: true
    appSettings: [
      {
        name: 'DOCKER_REGISTRY_SERVER_URL'
        value: 'https://crchenetteprod001.azurecr.io'
      }
      {
        name: 'DOCKER_REGISTRY_SERVER_USERNAME'
        value: clid
      }
      {
        name: 'DOCKER_REGISTRY_SERVER_PASSWORD'
        value: clse
      }
    ]
    healthCheckPath: '/' // Change?
    linuxFxVersion: 'DOCKER|crchenetteprod001.azurecr.io/dotnetwebapp:latest'
  }
}

// RESOURCE
resource app 'Microsoft.Web/sites@2021-03-01' = {
  name: name
  location: location
  kind: kind
  properties: properties
}
