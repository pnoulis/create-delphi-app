Write-output "------------------------ POST BUILD ------------------------`n" >> build/build.log

# required assets should be moved at build/$(platform)/$(config)/

## read build environment variables
$buildEnv = Get-Content -Raw -Path build/build.env.json | ConvertFrom-Json

## make target dir path
$buildDir = "build/$($buildEnv.Platform)/$($buildEnv.Config)"

## copy ./config to $targetDir
mkdir "$buildDir/config"
copy-item -path (get-item -path "config/*" -exclude ("delphi-rad-studio")).fullname `
    -destination "$buildDir/config" -recurse   


# Prepare built project for public distribution

## extract project version from config/config.ini
function getProjectVersion {
(select-string -path $args[0] -Pattern '^\s*version\s*=\s*(\d.*\d)$').Matches.groups[1].value
}

try {
    $projectVersion = getProjectVersion("config/config.ini")
}
catch {
    Write-output "Failed to read project version" $_ >> build/build.log
    exit 1
}

Write-output "Successful read of project version" >> build/build.log

## make target directory for public build
$publicBuildDir = "build/$($buildEnv.PROJECTNAME)-$($buildEnv.Platform)-v$($projectVersion)"
mkdir $publicBuildDir

## copy contents of $buildDir into publicBuildDir
Copy-Item -path "$buildDir/*" -Destination "$publicBuildDir" -Recurse

## remove compliler files
Remove-Item -path "$publicBuildDir/*.dcu"

Write-Output "successful post build phase`n" >> build/build.log