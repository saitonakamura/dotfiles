#Import-Module posh-git

if ($host.Name -eq 'ConsoleHost')
{
#    Import-Module PSReadLine
}

New-Alias -Name "ss" Select-String
Remove-Alias -Name nv -Force

function Refresh-PathEnv() {
  $env:Path = [System.Environment]::GetEnvironmentVariable("Path","Machine") + ";" + [System.Environment]::GetEnvironmentVariable("Path","User")
}

function Invoke-AsAdmin([scriptblock] $ScriptBlock) {
  Start-Process pwsh -Verb Runas -ArgumentList "-Command","$ScriptBlock" -Wait
}

New-Alias -Name "sudo" Invoke-AsAdmin

New-Alias -Name "time" Measure-Command
