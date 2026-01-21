# VPN Monitor

A simple PowerShell script that monitors VPN connectivity by pinging a specified DNS server and sends Windows notifications when the connection status changes (connected/disconnected).

## Features

- Monitors VPN connectivity using DNS server ping
- Sends Windows notifications when VPN connection status changes
- Logs connection status with timestamps
- Easy to configure with environment variables

## Requirements

- Windows operating system
- PowerShell (version 5.1 or later)
- VPN connection that provides access to an internal DNS server

## Installation

1. Clone or download this repository
2. Ensure you have the necessary PowerShell execution permissions

## Configuration

1. Rename the `.env` file (or create a new one if it doesn't exist)
2. Open the `.env` file and replace `<DNS_SERVER_IP>` with the IP address of your internal DNS server that is only reachable when connected to the VPN:

```env
DNS_SERVER=192.168.1.1
```

## Usage

1. Open PowerShell with administrator privileges (required for some notification features)
2. Navigate to the repository directory
3. Run the following command to bypass execution policy temporarily:

```powershell
Set-ExecutionPolicy Bypass -Scope Process -Force
```

4. Start the VPN monitor:

```powershell
.\vpn_monitor.ps1
```

## How It Works

The script:
1. Loads configuration from the `.env` file
2. Gets the current user's session ID for sending notifications
3. Enters an infinite loop that pings the configured DNS server every 10 seconds
4. When the ping fails (VPN disconnected), it sends a "VPN Connection Lost!" notification
5. When the ping succeeds (VPN connected), it sends a "VPN Connection Restored!" notification
6. Logs all status changes with timestamps to the console

## Stopping the Monitor

To stop the VPN monitor:
1. In the PowerShell window, press `Ctrl + C`

## Notes

- The script must be run with the appropriate PowerShell execution policy
- The `msg` command used for notifications may require administrator privileges
- The script will run indefinitely until manually stopped
- Notification behavior may vary depending on your Windows version and settings

## Troubleshooting

- If you don't see notifications, try running PowerShell as administrator
- Check that the DNS server IP in `.env` is correct and reachable when connected to VPN
- Verify that the PowerShell execution policy allows running scripts

## License

MIT License - feel free to use this script for personal or commercial purposes.
