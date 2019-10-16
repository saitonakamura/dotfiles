#Import-Module posh-git

if ($host.Name -eq 'ConsoleHost')
{
#  Import-Module PSReadLine
}

New-Alias -Name "ss" Select-String
Remove-Alias -Name nv -Force
#Remove-Alias -Name gip -Force
New-Alias -Name "gip" Get-ItemProperty

function Refresh-PathEnv() {
  $env:Path = [System.Environment]::GetEnvironmentVariable("Path","Machine") + ";" + [System.Environment]::GetEnvironmentVariable("Path","User")
}

function Invoke-AsAdmin([scriptblock] $ScriptBlock) {
  Start-Process pwsh -Verb Runas -ArgumentList "-Command","$ScriptBlock" -Wait
}

New-Alias -Name "sudo" Invoke-AsAdmin

New-Alias -Name "time" Measure-Command

Function AssociateFileExtensions
{
  Param
  (
    [Parameter(Mandatory=$true)]
    [String[]] $FileExtensions,
    [Parameter(Mandatory=$true)]
    [String] $OpenAppPath,
    [String] $FileTypeName
  )

  if (-not (Test-Path $OpenAppPath))
  {
    throw "$OpenAppPath does not exist."
  }

  foreach ($extension in $FileExtensions)
  {
    $fileType = (cmd /c "assoc $extension")
    $fileType = (if ($fileType -ne $null) { $fileType } else { "" }).Split("=")

    if ($fileType.Length -gt 1) {
      $fileType = $fileType[-1]
    } else {
      $fileType = if ($FileTypeName -ne "") { $FileTypeName } else { $extension -Replace "\.","" }
      cmd /c "assoc $extension=$fileType"
    }
    cmd /c "ftype $fileType=""$OpenAppPath"" ""%1"""
  }
}
