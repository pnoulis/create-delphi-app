param (
    [Parameter(Position=0,HelpMessage="create docker containers")]
    [string[]]$containers,

    [Parameter(Mandatory,HelpMessage="App path")]
    [string]$appPath
)

Write-Host $containers $appPath