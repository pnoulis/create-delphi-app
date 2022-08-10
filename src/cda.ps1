# cda.ps1 (create delphi app)
# The script will produce a dirtree and the tools to necessary to
# automate a simple build process for delphi applications.

# @@ $arg[0]
# directory path "cda" should instantiate a new delphi app

if ($args.count -lt 1) {
    Write-Output "create-delphi-app: path not provided"
    exit 1
}

# get script root path
$cdaRoot = split-path $PSCommandPath -parent

# remove target dir name from path and make sure the remainder is valid
## specifically (split-path path -parent) will return an empty string if
## the target dir name is relative to the cwd and no path specifiers such as ./
## have been provided
$tpath = (split-path $args[0] -parent)
if (-not $tpath) {
    $tpath = "./"
}

# expand target root path
try {
    $tpath = resolve-path $tpath
}
catch {
    Write-output "create-delphi-app: parts of path do not exist: $($args[0])"
    exit 1
}

# join dir root and name
$tpath = join-path -path $tpath -childpath (split-path $args[0] -leaf)

# make sure target path does not exist
if (Test-Path $tpath) {
    Write-output "create-delphi-app: target directory exists already: $($args[0])"
    exit 1
}

# instantiate new delphi app
Copy-Item -path "$cdaRoot/default-app-dir-tree/" -Destination $tpath -Recurse

Write-Output "DONE: $tpath"