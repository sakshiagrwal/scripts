@echo off

:: Delete directories requiring 'takeown' and 'icacls' commands (ATLAS 10 21H2).
for %%D in (
    "%ProgramFiles%\ModifiableWindowsApps"
    "%Public%\Desktop"
    "%WinDir%\SoftwareDistribution\Download"
    "%WinDir%\SoftwareDistribution\PostRebootEventCache.V2"
    "%WinDir%\SoftwareDistribution\SLS"
    "%WinDir%\temp"
    ) do (
    if exist "%%~D" (
        echo Deleting the "%%~D" directory...
        takeown /F "%%~D" /A >NUL 2>&1 & icacls "%%~D" /grant Administrators:F >NUL 2>&1
        RD /S /Q "%%~D" >NUL 2>&1
    )
)

:: Delete other directories (ATLAS 10 21H2).
for %%D in (
    "%AppData%\DMCache"
    "%ProgramData%\USOPrivate"
    "%ProgramData%\USOShared"
    "%ProgramData%\ASUS\ASUS System Control Interface\log"
    "%ProgramData%\ASUS\ASUS System Control Interface\AsusSwitch"
    "%ProgramData%\ASUS\ASUS System Control Interface\AsusSystemAnalysis"
    "%ProgramData%\ASUS\ASUS System Control Interface\AsusSystemDiagnosis"
    "%ProgramData%\ASUS\ASUS System Control Interface\AsusSoftwareManager"
    "%ProgramData%\ASUS\AsusInstaller"
    "%ProgramFiles%\Crashpad"
    "%SystemDrive%\$Recycle.bin"
    "%UserProfile%\.dbus-keyrings"
    "%UserProfile%\.vscode\cli"
    "%UserProfile%\AppData\Local\ASUS"
    "%UserProfile%\AppData\Local\cache"
    "%UserProfile%\AppData\Local\Comms"
    "%UserProfile%\AppData\Local\Temp"
    "%UserProfile%\AppData\Local\D3DSCache"
    "%UserProfile%\AppData\Local\fontconfig"
    "%UserProfile%\AppData\Local\npm-cache"
    "%UserProfile%\AppData\Local\PeerDistRepub"
    "%UserProfile%\AppData\Local\pip"
    "%UserProfile%\AppData\Local\pylint"
    "%UserProfile%\AppData\Local\VirtualStore"
    "%UserProfile%\AppData\Local\ToastNotificationManagerCompat"
    "%UserProfile%\AppData\Local\Rufus"
    "%UserProfile%\AppData\Local\uad"
    "%UserProfile%\AppData\Local\Programs"
    "%UserProfile%\AppData\LocalLow\AMD"
    "%UserProfile%\AppData\LocalLow\Microsoft\Internet Explorer"
    "%UserProfile%\AppData\Roaming\Adobe"
    "%UserProfile%\AppData\Roaming\balena-etcher"
    "%UserProfile%\AppData\Roaming\uad"
    "%UserProfile%\Downloads\Telegram Desktop"
    "%UserProfile%\Favorites"
    "%UserProfile%\Recent"
    "%UserProfile%\Searches"
    "%UserProfile%\Saved Games"
    "%UserProfile%\Videos\Captures"
    "%WinDir%\AppReadiness"
    "%WinDir%\Prefetch"
    ) do (
    if exist "%%~D" (
        echo Deleting the "%%~D" directory...
        RD /S /Q "%%~D" 2>NUL
    )
)

:: Create directories.
if not exist "%WinDir%\Temp" mkdir "%WinDir%\Temp"
if not exist "%Temp%" mkdir "%Temp%"

:: Set charging threshold.
powershell -NoProfile -ExecutionPolicy Bypass -File "charging.ps1"

:: reg query "HKLM\SOFTWARE\ASUS\ASUS System Control Interface\AsusOptimization\ASUS Keyboard Hotkeys" /v ChargingRate
:: reg add "HKLM\SOFTWARE\ASUS\ASUS System Control Interface\AsusOptimization\ASUS Keyboard Hotkeys" /v ChargingRate /t REG_DWORD /d 40 /f
:: net stop ASUSOptimization && net start ASUSOptimization

echo.
pause
