$OutputEncoding = [console]::InputEncoding = [console]::OutputEncoding = New-Object System.Text.UTF8Encoding

oh-my-posh init pwsh --config "$env:POSH_THEMES_PATH\emodipt-extend.omp.json" | Invoke-Expression

Import-Module -Name Terminal-Icons

# function make { mingw32-make }
function ll { Get-ChildItem -Force | Select-Object Mode, @{Name="LastWriteTime"; Expression={$_.LastWriteTime.ToString("yyyy/MM/dd HH:mm")}}, Length, Name | Format-Table -AutoSize}
function Debianssh { ssh lyj@192.168.93.27 }
function Ubuntussh { ssh baiyi@192.168.110.133 } 
function vcpkg_no_telemetry { vcpkg --disable-metrics } 

New-Alias tl tree
New-Alias grep Select-String
New-Alias make mingw32-make
New-Alias vcpkgd vcpkg_no_telemetry
