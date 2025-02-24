param (
    [Parameter(Position = 0)]
    [string]
    $Os,
    [Parameter(Position = 1)]
    [string]
    $Gpu,
    [Parameter(Position = 2)]
    [string[]]
    $Software
)
if ($Os -eq 'Windows') {
    Write-Host -Object "OS: $Os (Valid)"
}
else {
    Write-Host -Object "OS: $Os (Invalid)"
}
if ($Gpu -eq 'Azure NVIDIA GRID' -or $Gpu -eq 'Azure NVv4') {
    Write-Host -Object "GPU: $Gpu (Valid)"
}
else {
    Write-Host -Object "GPU: $Gpu (Invalid)"
}
$validSoftware = @('Parsec', 'qBittorrent', 'OBS Studio', 'Natron')
$invalidSoftware = $Software | Where-Object { $_ -notin $validSoftware }
if ($invalidSoftware.Count -eq 0) {
    Write-Host -Object "Software: $Software (Valid)"
}
else {
    Write-Host -Object "Software: $Software (Invalid)"
}
$confirm = Read-Host "Continue? (Y/N)"
if ($confirm -notmatch "^[Yy]$") {
    exit
}
if ($Os -eq 'Windows') {
    if ($Gpu -eq 'Azure NVIDIA GRID') {
        Invoke-WebRequest -Uri 'https://download.microsoft.com/download/1/1/d/11dd7071-c632-4a83-b950-d5eb3fdcf587/553.62_grid_win10_win11_server2019_server2022_dch_64bit_international_azure_swl.exe' -OutFile '.\553.62_grid_win10_win11_server2019_server2022_dch_64bit_international_azure_swl.exe' # https://learn.microsoft.com/en-us/azure/virtual-machines/windows/n-series-driver-setup
        Start-Process -FilePath '.\553.62_grid_win10_win11_server2019_server2022_dch_64bit_international_azure_swl.exe' -Wait
        Remove-Item -Path '.\553.62_grid_win10_win11_server2019_server2022_dch_64bit_international_azure_swl.exe'
    }
    elseif ($Gpu -eq 'Azure NVv4') {
        Invoke-WebRequest -Uri 'https://download.microsoft.com/download/2/d/3/2d328d15-4188-4fdb-8912-fb300a212dfc/AMD-Azure-NVv4-Driver-23Q3-winsvr2022.exe' -OutFile '.\AMD-Azure-NVv4-Driver-23Q3-winsvr2022.exe' # https://learn.microsoft.com/en-us/azure/virtual-machines/windows/n-series-amd-driver-setup
        Start-Process -FilePath '.\AMD-Azure-NVv4-Driver-23Q3-winsvr2022.exe' -Wait # Test
        Remove-Item -Path '.\AMD-Azure-NVv4-Driver-23Q3-winsvr2022.exe'
    }
    if ($Software -contains 'Parsec') {
        Invoke-WebRequest -Uri 'https://builds.parsec.app/package/parsec-windows.exe' -OutFile '.\parsec-windows.exe' # https://parsec.app/downloads
        Start-Process -FilePath '.\parsec-windows.exe' -Wait
        Remove-Item -Path '.\parsec-windows.exe'
    }
    if ($Software -contains 'qBittorrent') {
        Invoke-WebRequest -Uri 'https://onboardcloud.dl.sourceforge.net/project/qbittorrent/qbittorrent-win32/qbittorrent-5.0.4/qbittorrent_5.0.4_x64_setup.exe?viasf=1' -OutFile '.\qbittorrent_5.0.4_x64_setup.exe' # https://www.qbittorrent.org/download
        Start-Process -FilePath '.\qbittorrent_5.0.4_x64_setup.exe' -Wait
        Remove-Item -Path 'qbittorrent_5.0.4_x64_setup.exe'
    }
    if ($Software -contains '7-Zip') {
        Invoke-WebRequest -Uri 'https://www.7-zip.org/a/7z2409-x64.exe' -OutFile '.\7z2409-x64.exe' # https://www.7-zip.org/download.html
        Start-Process -FilePath '.\7z2409-x64.exe' -Wait
        Remove-Item -Path '.\7z2409-x64.exe'
    }
    if ($Software -contains 'OBS Studio') {
        Invoke-WebRequest -Uri 'https://cdn-fastly.obsproject.com/downloads/OBS-Studio-31.0.1-Windows-Installer.exe' -OutFile '.\OBS-Studio-31.0.1-Windows-Installer.exe' # https://obsproject.com/download
        Start-Process -FilePath '.\OBS-Studio-31.0.1-Windows-Installer.exe' -Wait
        Remove-Item -Path '.\OBS-Studio-31.0.1-Windows-Installer.exe'
    }
    if ($Software -contains 'Natron') {
        Invoke-WebRequest -Uri 'https://github.com/NatronGitHub/Natron/releases/download/v2.5.0/Natron-2.5.0-Windows-x86_64.zip' -OutFile '.\Natron-2.5.0-Windows-x86_64.zip' # https://natrongithub.github.io/
        Expand-Archive -Path '.\Natron-2.5.0-Windows-x86_64.zip' -DestinationPath '.'
        Start-Process -FilePath '.\Natron-2.5.0-Windows-x86_64\Setup.exe' -Wait
        Remove-Item -Path '.\Natron-2.5.0-Windows-x86_64.zip', '.\Natron-2.5.0-Windows-x86_64' -Recurse
    }
}
