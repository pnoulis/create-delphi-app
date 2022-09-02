function dos2Unix {
    param(
        [string]$path
    )
    return ($path -replace "\\", "/")
}
function isDirectory {
    param(
        [psObject]$node
    )
    $node -is [System.IO.DirectoryInfo]
}
function resolveTarget {
    param(
        [string]$target
    )
    $target = Split-Path $target -Parent
    if (-not $target) {
        $config.app.path = './'
    }
    if (-not (Test-path $target)) {
        return ''
    }
    return (dos2Unix (resolve-path $target).path)
}

function spliceNode {
    param(
        [PSObject]$node
    )
    return @{
        name = $node.name
        path = dos2unix $node.fullname
    }
}

function addNode {
    param(
        [psobject]$tree
    )
    $exclude = ".*", "build"
    $level = (Get-ChildItem -Exclude $exclude)

    foreach ($node in $level) {
        $isDir = isDirectory $node
        $node = spliceNode $node
        $tree | Add-Member `
            -MemberType NoteProperty `
            -Name "$($node.name)" `
            -Value $node
        if ($isDir) {
            push-location $node.name
            $tree."$($node.name)" = addNode $node
        }
    }
    Pop-Location
    return $tree
}

function buildDirTree {
    $dirTree = @{
        root = dos2Unix (split-path -parent $PSCommandPath | Split-Path -parent)
    }
    $dirtree = addNode $dirTree
    return $dirTree 
}