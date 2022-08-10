# project root
$proot = split-path -parent $PSCommandPath | Split-path -parent

set-location $proot

# get configuration
$conf = Get-Content -Raw -Path config/config.json | ConvertFrom-Json

# make build path
$buildDir = "build/create-delphi-app-v$($conf.version)"

# clear previous build
remove-item build/* -Recurse

# produce build
Copy-Item src -Destination $buildDir -Recurse 
Copy-item config/config.json -Destination $buildDir

Write-Output "built: $buildDir"