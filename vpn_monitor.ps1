# To run this script:
# Set-ExecutionPolicy Bypass -Scope Process -Force
# .\vpn_monitor.ps1


# Load variables from .env file
$envFilePath = ".\.env"
Get-Content $envFilePath | ForEach-Object {
    if ($_ -match '^\s*([^#][\w]+)\s*=\s*(.+)\s*$') {
        $name, $value = $Matches[1], $Matches[2]
        Set-Variable -Name $name -Value $value
    }
}

# Show IP being monitored
Write-Output "DNS Server monitored: $DNS_SERVER"

# Get current session ID for the logged-in user
$USERNAME = $env:USERNAME
$sessionId = (query session | Select-String $USERNAME).ToString().Split() | Where-Object { $_ -match '^\d+$' } | Select-Object -First 1

# Loop to monitor VPN
$OFFLINE = $false
$ONLINE = $false

while ($true) {
    # Get current timestamp
    $datetime = Get-Date -Format "yyyy-MM-dd HH:mm:ss"

    # Ping the DNS server
    $pingResult = Test-Connection -ComputerName $DNS_SERVER -Count 1 -Quiet

    if (-not $pingResult) {
        if (-not $OFFLINE) {
            Write-Output "VPN Connection is down! $datetime"
            msg $sessionId "VPN Connection Lost!"
            $OFFLINE = $true
            $ONLINE = $false
        }
    } else {
        if (-not $ONLINE) {
            Write-Output "VPN Connection is back online! $datetime"
            msg $sessionId "VPN Connection Restored!"
            $ONLINE = $true
            $OFFLINE = $false
        }
    }

    Start-Sleep -Seconds 10
}
