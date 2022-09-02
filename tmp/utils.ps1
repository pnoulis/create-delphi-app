function inspectObj {
    param(
        [PSCustomObject]$config,
        [string]$props,
        [bool]$write
    )

    if ($props -match "\*$") {
        if ($write) {
            Write-output ($config | ConvertTo-Json -depth 100) > out.json
        }
        else {
            Write-output ($config | ConvertTo-Json -depth 100)
        }
    }
    else {
        if ($write) {
            foreach ($prop in ($props.split(','))) {
                Write-output ($config[$prop] | ConvertTo-Json -depth 100) > out.json
            }
        }
        else {
            foreach ($prop in ($props.split(','))) {
                Write-output ($config[$prop] | ConvertTo-Json -depth 100)
            }
        }
    }
}