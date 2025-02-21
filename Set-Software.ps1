param (
    [Parameter(Position = 0)]
    [string]
    $OS,
    [Parameter(Position = 1)]
    [string]
    $GPU,
    [Parameter(Position = 2)]
    [string]
    $Software
)
if ($OS -eq 'Windows') {
    Write-Host -Object "OS: $OS (Valid)"
}
else {
    Write-Host -Object "OS: $OS (Invalid)"
}
if ($GPU -eq 'Azure NVIDIA GRID' -or $GPU -eq 'Azure NVv4') {
    Write-Host -Object "GPU: $GPU (Valid)"
}
else {
    Write-Host -Object "GPU: $GPU (Invalid)"
}
if ($Software -eq 'Natron') {
    Write-Host -Object "Software: $Software (Valid)"
}
else {
    Write-Host -Object "Software: $Software (Invalid)"
}
$confirm = Read-Host "Continue? (Y/N)"
if ($confirm -notmatch "^[Yy]$") {
    exit
}
if ($OS -eq 'Windows') {
    if ($GPU -eq 'Azure NVIDIA GRID') {
        Invoke-WebRequest -Uri 'https://download.microsoft.com/download/1/1/d/11dd7071-c632-4a83-b950-d5eb3fdcf587/553.62_grid_win10_win11_server2019_server2022_dch_64bit_international_azure_swl.exe' -OutFile '.\553.62_grid_win10_win11_server2019_server2022_dch_64bit_international_azure_swl.exe' # https://learn.microsoft.com/en-us/azure/virtual-machines/windows/n-series-driver-setup
        Start-Process -FilePath '.\553.62_grid_win10_win11_server2019_server2022_dch_64bit_international_azure_swl.exe' -ArgumentList '/s' -Wait
        Remove-Item -Path '.\553.62_grid_win10_win11_server2019_server2022_dch_64bit_international_azure_swl.exe'
    }
    elseif ($GPU -eq 'Azure NVv4') {
        Invoke-WebRequest -Uri 'https://download.microsoft.com/download/0/8/1/081db0c3-d2c0-44ae-be45-90a63610b16e/AMD-Azure-NVv4-Driver-23Q3-win10-win11.exe' -OutFile '.\AMD-Azure-NVv4-Driver-23Q3-win10-win11.exe' # https://learn.microsoft.com/en-us/azure/virtual-machines/windows/n-series-amd-driver-setup
        Start-Process -FilePath '.\AMD-Azure-NVv4-Driver-23Q3-win10-win11.exe' -ArgumentList '/install' -Wait # Test
        Remove-Item -Path '.\AMD-Azure-NVv4-Driver-23Q3-win10-win11.exe'
    }
    if ($Software -eq 'Natron') {
        Invoke-WebRequest -Uri 'https://github.com/NatronGitHub/Natron/releases/download/v2.5.0/Natron-2.5.0-Windows-x86_64.zip' -OutFile '.\Natron-2.5.0-Windows-x86_64.zip' # https://natrongithub.github.io/
        Expand-Archive -Path '.\Natron-2.5.0-Windows-x86_64.zip' -DestinationPath '.'
        Start-Process -FilePath '.\Natron-2.5.0-Windows-x86_64\Setup.exe' -ArgumentList '/ALLUSERS' -Wait
        Remove-Item -Path '.\Natron-2.5.0-Windows-x86_64.zip', '.\Natron-2.5.0-Windows-x86_64' -Recurse
    }
}
Restart-Computer -Force
