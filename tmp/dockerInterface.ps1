. ".\tmp\paths.ps1"
. ".\tmp\utils.ps1"

$BRATNET_DOCKERHUB = "bratnet/"

function isDockerInPath {
    if ((Get-Command -CommandType application docker -all).length -eq 0) {
        throw "The docker executable could not be found at '$$env:path'"
    }
}

function isDockerdRunning {
    if ((Get-Process "Docker Desktop").length -eq 0) {
        throw "No 'Docker Desktop' process running"
    }
}

function extractRepoFromAsset {
    param(
        [string]$asset
    )
    return $BRATNET_DOCKERHUB + $asset.split('-')[0]
}

function extractTagFromAsset {
    param(
        [string]$asset
    )
    return ':' + ($asset.split('-')[1] -replace '\.Dockerfile$', '')
}

function findImage {
    param(
        [string]$imageName
    )
    ($id = docker image inspect $imageName --format '{{ .Id }}') *> $null
    if ($id) {
        # if id is found the string returned by docker is in the form:
        # sha256:3343a34324ieoeu...
        return ($id -replace 'sha256:', '')
    }
    Write-host "image: '$imageName' could not be found!"
    return ''
}
function buildImage {
    param(
        [string]$path,
        [string]$name
    )
    (Get-content $path | docker build -t $name -) *> $null
    $id = findImage $name
    if (-not $id) {
        throw "'$name' at '$path' not found"
    }
    return $id
}

function rmImage {
    param(
        [string]$name
    )
    docker image rm $name *> $null
    if (-not $?) {
        throw "Failed to remove image '$name'"
    }
    return $true
}
function getAsset {
    param(
        [hashtable]$dirTree,
        [string]$asset
    )
    return $dirTree.assets['docker-images'][$asset + '.Dockerfile']
}

function formatTimeString {
    param(
        [string]$datetime
    )
    return (Get-date -Date $datetime -UFormat "%Y-%m-%dT%T%Z")
}

function newImage {
    return @{
        asset     = @{ name = ''; path = '' }
        name      = ''
        id        = ''
        buildTime = ''
        writeTime = ''
    }
}
function getImage {
    param(
        [hashtable]$dirTree,
        [string]$assetID # in the form mssql_2019
    )

    $image = newImage
    $image.asset = getAsset $dirTree $assetID

    if (-not $image.asset) {
        throw "asset: '$assetID' could not be found"
    }

    $image.name = (extractRepoFromAsset $image.asset.name) + (extractTagFromAsset $image.asset.name)
    $image.id = findImage $image.name
    if (-not $image.id) {
        Write-host "Building image '$($image.name)'"
        $image.id = buildImage $image.asset.path $image.name
    }

    $image.buildTime = formatTimeString (
        [datetime]`
        (docker image inspect $image.name --format '{{ json .Metadata.LastTagTime }}').trim('"')
    )
    $image.writeTime = formatTimeString (
        (Get-item $image.asset.path).LastWriteTime
    )

    if ($image.writeTime -gt $image.buildTime) {
        Write-host "Image dockerfile has been modified since last build"
        Write-host "Deleting previous image $($image.name)"
        rmImage $image.name
        $image = getImage $dirTree $assetID
    }

    return $image
}