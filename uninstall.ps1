# Define destination path
$ProfileDestination = "C:\ProgramData\Cisco\Cisco AnyConnect Secure Mobility Client\Profile\profile.xml"

# Remove profile.xml if it exists
if (Test-Path -Path $ProfileDestination) {
    Remove-Item -Path $ProfileDestination -Force
}

# Exit with success code
exit 0
