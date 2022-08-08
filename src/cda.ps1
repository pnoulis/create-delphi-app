# cda.ps1 (create delphi app)
function getCDARootPath {
    Split-Path -Parent $PSCommandPath | Split-Path -parent
}
function getTargetRootPath {
(Resolve-path -Path (split-path $args[0] -Parent)).Path
}

function getTargetName {
    split-path $args[0] -Leaf
}

function getTargetFullPath {
    Join-Path -Path $args[0] -childPath $args[1]
}

$cdaRootPath=getCDARootPath
$targetName=getTargetName $args[0]
$targetRootPath=getTargetRootPath $args[0]
$targetFullPath=getTargetFullPath $targetRootPath $targetName


if (Test-Path -Path $targetFullPath) {
    Write-Output "cda.ps1 -> Target path already exists: $targetFullPath"
    exit;
}

Push-location
Push-Location -Path "$cdaRootPath/src"
Copy-Item .\default-app-dir-tree -Destination "$targetFullPath/" -Recurse

Pop-Location
Write-Output 'Done'