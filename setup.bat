@echo off
:: Проверка прав администратора
net session >nul 2>&1
if %errorlevel% neq 0 (
    echo [!] Пожалуйста, запустите этот скрипт от имени администратора.
    pause
    exit /b
)

echo [+] Отключение фаервола...
netsh advfirewall set allprofiles state off

echo [+] Загрузка и установка Chrome Remote Desktop Host...
set "crd_installer=%TEMP%\chromeremotedesktophost.msi"
powershell -Command "Invoke-WebRequest -Uri 'https://dl.google.com/edgedl/chrome-remote-desktop/chromeremotedesktophost.msi' -OutFile '%crd_installer%'"
msiexec /i "%crd_installer%" /quiet /norestart
del "%crd_installer%"

echo [+] Загрузка и установка Google Chrome...
set "chrome_installer=%TEMP%\chrome_installer.exe"
powershell -Command "Invoke-WebRequest -Uri 'https://dl.google.com/chrome/install/latest/chrome_installer.exe' -OutFile '%chrome_installer%'"
"%chrome_installer%" /silent /install
del "%chrome_installer%"

echo [+] Готово.
pause
exit /b

