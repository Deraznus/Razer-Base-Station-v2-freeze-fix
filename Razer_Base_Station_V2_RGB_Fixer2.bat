@echo off
setlocal enabledelayedexpansion
cd /d "%~dp0"

:: Indítási késleltetés eltávolítva

:: Hardver keresése (csak az aktív szülő eszköz)
set "FULL_ID="
for /f "delims=" %%A in ('powershell -NoProfile -Command "Get-PnpDevice | Where-Object { $_.InstanceId -match 'VID_1532&PID_0F20' -and $_.InstanceId -notmatch 'MI_' -and $_.Present -eq $true } | Select-Object -ExpandProperty InstanceId -First 1"') do (
    set "FULL_ID=%%A"
)

if "!FULL_ID!"=="" exit

:: Al-eszközök kíméletlen törlése (hogy a Synapse elengedje)
powershell -NoProfile -Command "Get-PnpDevice | Where-Object { $_.InstanceId -match 'VID_1532&PID_0F20' -and $_.InstanceId -match 'MI_' -and $_.Present -eq $true } | ForEach-Object { pnputil /remove-device $_.InstanceId /force }" >nul 2>&1

:: Minimális technikai szünet a törlés után
timeout /t 1 /nobreak >nul

:: Fizikai áramelvétel és restart
RestartUsbPort.exe "!FULL_ID!" >nul 2>&1

:: Windows frissítése (hogy visszajöjjenek az eszközök)
timeout /t 1 /nobreak >nul
pnputil /scan-devices >nul 2>&1

exit