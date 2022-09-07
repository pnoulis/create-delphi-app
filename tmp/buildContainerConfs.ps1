. ".\tmp\utils.ps1"


$configurator = @{
    server = @{
        host = 'localhost:port or www.something.com:port'
    }
    client = @{
        host = 'hostname or ip'
        path = '/'
    }
    services = @(
        @{
            name = "this should only name the service requested"
            ID = "this is the container id created to accomodate the service request"
            state = "running | stopped | error"
            args = @{
                username = ""
                password = ""
                seed = @('one', 'two', 'three')
            }
            mode = @{
                persist = $false
                backup = $false
                transfer = $true
            }
        }
    )
}

Write-host ($configurator | ConvertTo-Json -depth 99)