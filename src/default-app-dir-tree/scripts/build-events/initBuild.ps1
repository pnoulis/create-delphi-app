push-location ./build
Write-output "------------------------ INIT BUILD ------------------------`n" > build.log

$buildEnv = @{
    BDS             = $env:BDS
    Defines         = $env:Defines
    Config          = $env:Config
    Dir             = $env:Dir
    INCLUDEPATH     = $env:INCLUDEPATH
    INPUTDIR        = $env:INPUTDIR
    INPUTTEXT       = $env:INPUTEXT
    INPUTFILENAME   = $env:INPUTFILENAME
    INPUTNAME       = $env:INPUTNAME
    INPUTPATH       = $env:INPUTPATH
    LOCALCOMMAND    = $env:LOCALCOMMAND
    OUTPUTDIR       = $env:OUTPUTDIR
    OUTPUTTEXT      = $env:OUTPUTEXT
    OUTPUTFILENAME  = $env:OUTPUTFILENAME
    OUTPUTNAME      = $env:OUTPUTNAME
    OUTPUTPATH      = $env:OUTPUTPATH
    Path            = $env:Path
    Platform        = $env:Platform
    PROJECTDIR      = $env:PROJECTDIR
    PROJECTEXT      = $env:PROJECTEXT
    PROJECTFILENAME = $env:PROJECTFILENAME
    PROJECTNAME     = $env:PROJECTNAME
    PROJECTPATH     = $env:PROJECTPATH
    SAVE            = $env:SAVE
    SystemRoot      = $env:SystemRoot
    WINDIR          = $env:WINDIR
}

try {
    $buildEnv | ConvertTo-Json -depth 100 | Out-file -Encoding utf8 "./build.env.json"
    Write-output "build/build.env.json created" >> build.log
}
catch {
    Write-output "Failed to write build.env.json" $_ >> build.log
    exit 1
}

Write-Output "successful initial build phase`n" >> build.log
Pop-Location
