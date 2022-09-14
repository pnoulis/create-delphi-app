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

function add {
    param(
        [parameter(Mandatory = $True, Position = 0, HelpMessage = "path to add service to")]
        [string]$path,

        [parameter(Position = 1, HelpMessage = "containers to attach")]
        $containers
    )
}

function start {
    write-host "say start"
}

function stop {
    write-host "say stop"
}

function list {
    $images = $dirtree.assets['docker-images'].keys.where{ $_ -ne "name" -and $_ -ne "path"}
    forEach ($image in $images) {
        Write-host $image.split(".")[0]
    }
}

