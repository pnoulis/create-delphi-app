function inspectObj {
    param(
        [PSCustomObject]$config,
        [string]$props,
        [bool]$write
    )

    if ($props -match "\*$") {
       Write-output ($config | ConvertTo-Json)
    } else {
        foreach ($prop in ($props.split(','))) {
            Write-output ($config[$prop] | ConvertTo-Json)
        }
    }
}