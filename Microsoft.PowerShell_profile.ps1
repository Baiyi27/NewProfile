$OutputEncoding = [console]::InputEncoding = [console]::OutputEncoding = New-Object System.Text.UTF8Encoding
oh-my-posh init pwsh --config 'C:\Users\admin\AppData\Local\Programs\oh-my-posh\themes\emodipt-extend.omp.json' | Invoke-Expression
Import-Module -Name Terminal-Icons

New-Alias -Name "tl" -Value "tree"
function make { mingw32-make }
function ll { Get-ChildItem -Force | Select-Object Mode, @{Name="LastWriteTime"; Expression={$_.LastWriteTime.ToString("yyyy/MM/dd HH:mm")}}, Length, Name | Format-Table -AutoSize
}

function Debianssh { ssh lyj@192.168.93.27 }