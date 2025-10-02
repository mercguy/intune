$DeviceList = Import-Csv -Path 'C:\temp\hhem\AutoPilotGroupTag.csv'

foreach ($Device in $DeviceList) {
    # Log the current serial number being processed
    Write-Host "Processing device with Serial:" $Device.Serial

    # Skip if GroupTag is missing in the CSV
    if (-not $Device.GroupTag) {
        Write-Host "Missing GroupTag for Serial:" $Device.Serial
        continue
    }

    # Attempt to retrieve the Autopilot device
    try {
        $ErrorActionPreference = 'Stop'  # Treat all errors as terminating
        $APDevice = Get-AutopilotDevice -serial $Device.Serial
    }
    catch {
        Write-Host "Device not found in Intune for Serial:" $Device.Serial
        continue  # Skip to the next device
    }

    # If $APDevice is null, skip
    if ($null -eq $APDevice) {
        Write-Host "No Autopilot device found for Serial:" $Device.Serial
        continue
    }

    # Attempt to set the GroupTag
    try {
        Set-AutopilotDevice -id $APDevice.id -groupTag $Device.GroupTag -ErrorAction Stop
        Write-Host "Successfully updated GroupTag for Serial:" $Device.Serial
    }
    catch {
        Write-Host "Failed to update GroupTag for Serial:" $Device.Serial
        Write-Host "Error:" $_.Exception.Message
        continue  # Skip to the next device
    }
}
