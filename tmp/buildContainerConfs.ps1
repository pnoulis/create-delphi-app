. ".\tmp\utils.ps1"
function isImage {
    param(
        [hashtable]$dirTree,
        [string]$image
    )
    if ($dirTree.assets['docker-images'].contains($image)) {
        return $true
    }
    return $false
}

function buildContainerConfigurators {
    param(
        [psCustomObject]$config,
        [string[]]$Containers # "image:serviceName,..."
    )

    $config.containers = [PSCustomObject[]]::new($containers.Length)
    for (($i = 0); $i -lt $containers.length; $i++) {
        $configurator = @{
            image = $containers[$i].split(':')[0]
            name  = $containers[$i].split(':')[1]
        }
        $config.containers[$i] = $configurator
        if ( -not (isImage $config.dirTree $configurator.image)) {
            Write-host "cda: Not an image: " $configurator.image
            return $config.containers
        }
    }

    return $config.containers
}
