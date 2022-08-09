Write-output "------------------------ POST BUILD ------------------------`n" >> build/build.log

# required assets should be moved at build/$(platform)/$(config)/

## read build environment variables
$buildEnv = Get-Content -Raw -Path build/build.env.json | ConvertFrom-Json

## make target dir path
$targetDir = "build/$($buildEnv.Platform)/$($buildEnv.Config)"

## copy ./config to $targetDir
mkdir "$targetDir/config"
copy-item -path (get-item -path "config/*" -exclude ("delphi-rad-studio")).fullname `
    -destination "$targetDir/config" -recurse   

Write-Output "successful post build phase`n" >> build/build.log