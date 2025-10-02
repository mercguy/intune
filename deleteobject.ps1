Connect-MgGraph -Scopes "Device.ReadWrite.All","Directory.ReadWrite.All","DeviceManagementServiceConfig.ReadWrite.All","DeviceManagementManagedDevices.ReadWrite.All"

$names = @(
'hostname-of-device',
'hostname-of-device',
'hostname-of-device'
)

foreach ($n in $names) {
    $md  = Get-MgDeviceManagementManagedDevice -Filter "deviceName eq '$n'" -All
    $aad = Get-MgDevice -Filter "displayName eq '$n'" -All -Property "id,deviceId"
    $g   = @($md.azureAdDeviceId)+@($aad.deviceId)|?{$_}|Select-Object -Unique

    foreach($x in $g){
        Get-MgDeviceManagementWindowsAutopilotDeviceIdentity -Filter "azureActiveDirectoryDeviceId eq '$x'" -All |
            % { Remove-MgDeviceManagementWindowsAutopilotDeviceIdentity -WindowsAutopilotDeviceIdentityId $_.Id }
    }

    if(-not $g -and $md.serialNumber){
        Get-MgDeviceManagementWindowsAutopilotDeviceIdentity -Filter "serialNumber eq '$($md.serialNumber)'" -All |
            % { Remove-MgDeviceManagementWindowsAutopilotDeviceIdentity -WindowsAutopilotDeviceIdentityId $_.Id }
    }

    if($md){ $md | % { Remove-MgDeviceManagementManagedDevice -ManagedDeviceId $_.Id } }
    if($aad){ $aad | % { Remove-MgDevice -DeviceId $_.Id } }
}
