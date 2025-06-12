Write-Host "[+] Отключение фаервола..."
Set-NetFirewallProfile -Profile Domain,Public,Private -Enabled False
Write-Host "OK."

# Установка Chrome Remote Desktop
Write-Host "[+] Загрузка и установка Chrome Remote Desktop Host..."
$crd = "$env:TEMP\chromeremotedesktophost.msi"
Invoke-WebRequest -Uri "https://dl.google.com/edgedl/chrome-remote-desktop/chromeremotedesktophost.msi" -OutFile $crd -UseBasicParsing

Start-Process -FilePath "msiexec.exe" -ArgumentList "/i `"$crd`" /quiet /norestart" -Wait
Remove-Item -Path $crd -Force
Write-Host "CRD Установлен."

# Установка Google Chrome
Write-Host "[+] Загрузка и установка Google Chrome..."
$chrome = "$env:TEMP\chrome_installer.exe"
Invoke-WebRequest -Uri "https://dl.google.com/chrome/install/latest/chrome_installer.exe" -OutFile $chrome -UseBasicParsing

Start-Process -FilePath $chrome -ArgumentList "/silent /install" -Wait
Remove-Item -Path $chrome -Force
Write-Host "Chrome установлен."

Write-Host "[✓] Готово."
