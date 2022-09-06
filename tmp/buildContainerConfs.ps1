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
function newConfiguratorTemplate {
    return @{
        image = ""
        name = ""
        container = ""
        persist = $true
        backup = $false
    }
}
function buildContainerConfigurators {
    param(
        [psCustomObject]$config,
        [string[]]$Containers # "image:serviceName,..."
    )

    $config.containers = [PSCustomObject[]]::new($containers.Length)
    for (($i = 0); $i -lt $containers.length; $i++) {
        $config.containers[$i] = newConfiguratorTemplate
        $configurator = $config.containers[$i]
        $configurator.image = $containers[$i].split(':')[0]
        $configurator.name = $containers[$i].split(':')[1]
        $configurator.image = $config.dirtree.assets['docker-images']['mssql_server_2019.Dockerfile'].name
        write-host "assigned image path" $configurator.image
        if ( -not (isImage $config.dirTree $configurator.image)) {
            Write-host "cda: could not resolve image: " $configurator.image
            return $config.containers
        }
    }
    return $config.containers
}
