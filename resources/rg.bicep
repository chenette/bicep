
// =========== asp.bicep ===========

targetScope = 'subscription'

// USER-PROVIDED PARAMETERS
param application string
param environment string
param instance string = '1'

// BASE PARAMETERS
param name string = 'asp-${application}-${environment}-${location}-${padLeft(instance, 3, '0')}'
param location string = deployment().location

resource rg 'Microsoft.Resources/resourceGroups@2022-09-01' = {
  name: name
  location: location
}

output id resource = rg
