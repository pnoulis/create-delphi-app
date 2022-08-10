# project root
$proot = split-path -parent $PSCommandPath | split-path -parent

if (Test-Path build/run) {
    remove-item -recurse build/run
} elseif (-not (Test-path build)) {
    new-item build -type directory
}

. $proot/src/cda.ps1 build/run

