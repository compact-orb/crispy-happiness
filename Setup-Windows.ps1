Invoke-WebRequest -Uri 'https://download.microsoft.com/download/1/1/d/11dd7071-c632-4a83-b950-d5eb3fdcf587/553.62_grid_win10_win11_server2019_server2022_dch_64bit_international_azure_swl.exe' -OutFile './553.62_grid_win10_win11_server2019_server2022_dch_64bit_international_azure_swl.exe' # https://learn.microsoft.com/en-us/azure/virtual-machines/windows/n-series-driver-setup
Start-Process -FilePath './553.62_grid_win10_win11_server2019_server2022_dch_64bit_international_azure_swl.exe' -ArgumentList '/s' -Wait
Remove-Item -Path './553.62_grid_win10_win11_server2019_server2022_dch_64bit_international_azure_swl.exe'
Invoke-WebRequest -Uri 'https://github.com/NatronGitHub/Natron/releases/download/v2.5.0/Natron-2.5.0-Windows-x86_64.zip' -OutFile './Natron-2.5.0-Windows-x86_64.zip' # https://natrongithub.github.io/
Expand-Archive -Path './Natron-2.5.0-Windows-x86_64.zip' -DestinationPath '.'
Start-Process -FilePath './Natron-2.5.0-Windows-x86_64\Setup.exe' -ArgumentList '/SILENT' -Wait
Remove-Item -Path './Natron-2.5.0-Windows-x86_64.zip', './Natron-2.5.0-Windows-x86_64' -Recurse
Restart-Computer -Force
