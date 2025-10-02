# Remediation script: Silently remove Adobe Reader shortcut

$PublicDesktopPath = "$env:Public\Desktop"
$ShortcutName = "Acrobat Reader.lnk"
$ShortcutPath = Join-Path $PublicDesktopPath $ShortcutName

if (Test-Path $ShortcutPath) {
    Remove-Item $ShortcutPath -Force -ErrorAction SilentlyContinue
}
