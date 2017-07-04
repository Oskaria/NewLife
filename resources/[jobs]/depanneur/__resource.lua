-- Manifest
resource_manifest_version '77731fab-63ca-442c-a67b-abc70f28dfa5'

-- Requiring essentialmode
dependency 'essentialmode'

-- General
client_scripts {
  'cl_utils.lua', --NE PAS TOUCHER !!
  'client.lua',
  'dommage_vehicule.lua', --NE PAS TOUCHER !!
  'vestdepanneur.lua',
  'depanneurveh.lua',
  'menudepanneur.lua',
}

server_scripts {
  'server.lua',
}

export 'getisInServiceDep' --NE PAS TOUCHER !!
