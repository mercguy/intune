# Detection script: Check if Adobe Reader shortcut exists

$PublicDesktopPath = "$env:Public\Desktop"
$ShortcutName = "Acrobat Reader.lnk"
$ShortcutPath = Join-Path $PublicDesktopPath $ShortcutName

if (Test-Path $ShortcutPath) {
    Write-Output "Shortcut exists"
    exit 1  # Non-zero exit triggers remediation
} else {
    exit 0
}
