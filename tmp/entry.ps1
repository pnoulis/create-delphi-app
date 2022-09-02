param (
    [Parameter(Position = 0, HelpMessage = "create docker containers")]
    [string[]]$containers,

    [Parameter(Mandatory, HelpMessage = "App path")]
    [string]$appPath
)

# construct an image of the first level of the
# app's project tree to help develop
. ".\tmp\paths.ps1"
$dirTree = buildDirTree

# construct the container configuration interfaces as per user
# request
if ($containers.length -gt 1) {
    . ".\tmp\buildContainerConfs.ps1"
    $containerConfigurators = buildContainerConfigurators $dirTree
}
