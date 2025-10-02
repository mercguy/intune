# Define source and destination paths
$ProfileSource = "$PSScriptRoot\profile.xml"
$ProfileDestination = "C:\ProgramData\Cisco\Cisco AnyConnect Secure Mobility Client\Profile\"

# Ensure the destination folder exists
if (!(Test-Path -Path $ProfileDestination)) {
    New-Item -ItemType Directory -Path $ProfileDestination -Force
}

# Copy profile.xml to the destination
Copy-Item -Path $ProfileSource -Destination $ProfileDestination -Force

# Exit with success code
exit 0
