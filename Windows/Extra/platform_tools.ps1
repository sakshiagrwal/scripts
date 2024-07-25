# Define variables
$platformToolsUrl = "https://dl.google.com/android/repository/platform-tools-latest-windows.zip"
$zipFilePath = "$env:TEMP\platform-tools.zip"
$extractPath = "$env:PROGRAMFILES\Android"

# Check for administrative privileges
if (-not (New-Object Security.Principal.WindowsPrincipal([Security.Principal.WindowsIdentity]::GetCurrent())).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)) {
    Write-Host "Error: Administrator privileges required." -ForegroundColor Red
    exit
}

# Check for internet connection
if (-not (Test-Connection 8.8.8.8 -Count 1 -Quiet)) {
    Write-Host "Error: Internet connection required." -ForegroundColor Red
    exit
}

# Download the file
Write-Host "Downloading Platform Tools to $zipFilePath..." -ForegroundColor Yellow
try {
    curl.exe -L $platformToolsUrl -o $zipFilePath
    Write-Host "Download Successful" -ForegroundColor Green
}
catch { 
    Write-Host "Failed to download: $_" -ForegroundColor Red
    exit 
}

# Extract the ZIP file
Write-Host "`nInstalling Platform Tools to $extractPath..." -ForegroundColor Yellow
try {
    Expand-Archive -Path $zipFilePath -DestinationPath $extractPath -Force
    Write-Host "Installation Successful" -ForegroundColor Green
}
catch {
    Write-Host "Failed to extract: $_" -ForegroundColor Red
    exit 
}

# Add the folder to the system PATH
$platformToolsPath = "$extractPath\platform-tools"
$currentPath = [System.Environment]::GetEnvironmentVariable("PATH", [System.EnvironmentVariableTarget]::Machine)
if (-not ($currentPath -contains $platformToolsPath)) {
    [System.Environment]::SetEnvironmentVariable("PATH", "$currentPath;$platformToolsPath", [System.EnvironmentVariableTarget]::Machine)
    Write-Host "`nAdded '$platformToolsPath' to system environment variables..." -ForegroundColor Green
}

# Cleanup
Remove-Item -Path $zipFilePath -ErrorAction SilentlyContinue

Write-Host "`nPlatform Tools installed successfully!" -ForegroundColor Green
