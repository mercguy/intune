# Define the explicit target path
$DestinationPath = "C:\Users\$env:USERNAME\AppData\Roaming\Microsoft\Templates"

# Define the source path for the .dotx file(s)
$SourceFolder = "$PSScriptRoot\Files"

# Check if the destination directory exists
if (-Not (Test-Path -Path $DestinationPath)) {
    Write-Host "The destination folder does not exist. No files will be copied."
    exit 0
}

# Copy all .dotx files from the source folder to the destination
Write-Host "Copying .dotx files to $DestinationPath"
Get-ChildItem -Path $SourceFolder -Filter "*.dotx" | ForEach-Object {
    Copy-Item -Path $_.FullName -Destination $DestinationPath -Force
}

Write-Host "Template deployment completed successfully."
