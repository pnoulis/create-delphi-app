. ".\tmp\paths.ps1"
. ".\tmp\utils.ps1"

$dirtree = buildDirTree
function create {
    param(
        [Parameter(Mandatory = $True, Position = 0, HelpMessage = "path to instantiate delphi app")]
        [string]$path,

        [Parameter(Position = 1, HelpMessage = "containers to attach")]
        $containers
    )

    Write-host "say create" $path $containers
}

function start {
    write-host "say start"
}

function stop {
    write-host "say stop"
}

function list {
    Write-host "say list"
    inspectObj $dirtree.assets['docker-images'] "*"
}

