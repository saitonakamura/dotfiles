# Adapted code from https://github.com/dahlbyk/posh-sshell since it's no longer being maintained

function setenv {
    param(
        [Parameter()]
        [string]
        $key,

        [Parameter()]
        [string]
        $value,

        [Parameter()]
        [ValidateSet("Process", "User")]
        [string]
        $Scope = "Process"
    )
    [void][Environment]::SetEnvironmentVariable($key, $value, $Scope)
    Set-TempEnv $key $value
}

function Get-TempEnv($key) {
    $path = Get-TempEnvPath($key)
    if (Test-Path $path) {
        $value =  Get-Content $path
        [void][Environment]::SetEnvironmentVariable($key, $value)
    }
}

function Set-TempEnv($key, $value) {
    $path = Get-TempEnvPath($key)
    if ($null -eq $value) {
        if (Test-Path $path) {
            Remove-Item $path
        }
    }
    else {
        New-Item $path -Force -ItemType File > $null
        $value | Out-File -FilePath $path -Encoding ascii -Force
    }
}

function Get-TempEnvPath($key){
    $path = Join-Path ([System.IO.Path]::GetTempPath()) ".ssh\$key.env"
    return $path
}

function Test-Administrator {
    # PowerShell 5.x only runs on Windows so use .NET types to determine isAdminProcess
    # Or if we are on v6 or higher, check the $IsWindows pre-defined variable.
    if (($PSVersionTable.PSVersion.Major -le 5) -or $IsWindows) {
        $currentUser = [Security.Principal.WindowsPrincipal]([Security.Principal.WindowsIdentity]::GetCurrent())
        return $currentUser.IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)
    }

    # Must be Linux or OSX, so use the id util. Root has userid of 0.
    return 0 -eq (id -u)
}
function Test-PoshSshImportedInScript {
    param (
        [Parameter(Position=0)]
        [string]
        $Path
    )

    if (!$Path -or !(Test-Path -LiteralPath $Path)) {
        return $false
    }

    $match = (@(Get-Content $Path -ErrorAction SilentlyContinue) -match 'posh-ssh').Count -gt 0
    if ($match) { Write-Verbose "posh-sshell found in '$Path'" }
    $match
}

function Get-PSModulePath {
    $modulePaths = $Env:PSModulePath -split ';'
    $modulePaths
}

function Test-InPSModulePath {
    param (
        [Parameter(Position=0, Mandatory=$true)]
        [ValidateNotNull()]
        [string]
        $Path
    )

    $modulePaths = Get-PSModulePath
    if (!$modulePaths) { return $false }

    $pathStringComparison = Get-PathStringComparison
    $Path = $ExecutionContext.SessionState.Path.GetUnresolvedProviderPathFromPSPath($Path)
    $inModulePath = @($modulePaths | Where-Object { $Path.StartsWith($_.TrimEnd([System.IO.Path]::DirectorySeparatorChar), $pathStringComparison) }).Count -gt 0

    if ($inModulePath -and ('src' -eq (Split-Path $Path -Leaf))) {
        Write-Warning 'posh-sshell repository structure is incompatible with %PSModulePath%.'
        Write-Warning 'Importing with absolute path instead.'
        return $false
    }

    $inModulePath
}

<#
.SYNOPSIS
    Gets the file encoding of the specified file.
.DESCRIPTION
    Gets the file encoding of the specified file.
.PARAMETER Path
    Path to the file to check.  The file must exist.
.EXAMPLE
    PS C:\> Get-FileEncoding $profile
    Get's the file encoding of the profile file.
.INPUTS
    None.
.OUTPUTS
    [System.String]
.NOTES
    Adapted from http://www.west-wind.com/Weblog/posts/197245.aspx
#>
function Get-FileEncoding($Path) {
    if ($PSVersionTable.PSVersion.Major -ge 6) {
        $bytes = [byte[]](Get-Content $Path -AsByteStream -ReadCount 4 -TotalCount 4)
    }
    else {
        $bytes = [byte[]](Get-Content $Path -Encoding byte -ReadCount 4 -TotalCount 4)
    }

    if (!$bytes) { return 'utf8' }

    switch -regex ('{0:x2}{1:x2}{2:x2}{3:x2}' -f $bytes[0],$bytes[1],$bytes[2],$bytes[3]) {
        '^efbbbf'   { return 'utf8' }
        '^2b2f76'   { return 'utf7' }
        '^fffe'     { return 'unicode' }
        '^feff'     { return 'bigendianunicode' }
        '^0000feff' { return 'utf32' }
        default     { return 'ascii' }
    }
}

<#
.SYNOPSIS
    Gets a StringComparison enum value appropriate for comparing paths on the OS platform.
.DESCRIPTION
    Gets a StringComparison enum value appropriate for comparing paths on the OS platform.
.EXAMPLE
    PS C:\> $pathStringComparison = Get-PathStringComparison
.INPUTS
    None
.OUTPUTS
    [System.StringComparison]
#>
function Get-PathStringComparison {
    # File system paths are case-sensitive on Linux and case-insensitive on Windows and macOS
    if (($PSVersionTable.PSVersion.Major -ge 6) -and $IsLinux) {
        [System.StringComparison]::Ordinal
    }
    else {
        [System.StringComparison]::OrdinalIgnoreCase
    }
}

function Get-SshPath($File = 'id_rsa') {
  # Avoid paths with path separator char since it is different on Linux/macOS.
  # Also avoid ~ as it is invalid if the user is cd'd into say cert:\ or hklm:\.
  # Also, apparently using the PowerShell built-in $HOME variable may not cut it for msysGit with has different
  # ideas about the path to the user's home dir e.g. /c/Users/Keith
  # $homePath = Invoke-NullCoalescing $Env:HOME $Home
  $homePath = if ($Env:HOME) {$Env:HOME} else {$Home}
  Join-Path $homePath (Join-Path .ssh $File)
}

<#
.SYNOPSIS
  Add a key to the SSH agent
.DESCRIPTION
  Adds one or more SSH keys to the SSH agent.
.EXAMPLE
  PS C:\> Add-SshKey
  Adds ~\.ssh\id_rsa to the SSH agent.
.EXAMPLE
  PS C:\> Add-SshKey ~\.ssh\mykey, ~\.ssh\myotherkey
  Adds ~\.ssh\mykey and ~\.ssh\myotherkey to the SSH agent.
.INPUTS
  None.
  You cannot pipe input to this cmdlet.
#>
function Add-SshKey([switch]$Quiet, [switch]$All) {
  if ($env:GIT_SSH -imatch 'plink') {
      $pageant = Get-Command pageant -Erroraction SilentlyContinue | Select-Object -First 1 -ExpandProperty Name
      $pageant = if ($pageant) { $pageant } else { Find-Pageant }
      if (!$pageant) {
          if (!$Quiet) {
              Write-Warning 'Could not find Pageant'
          }
          return
      }

      if ($args.Count -eq 0) {
          $keyPath = Join-Path $Env:HOME .ssh
          $keys = Get-ChildItem $keyPath/*.ppk -ErrorAction SilentlyContinue | Select-Object -ExpandProperty FullName
          if ($keys) {
              & $pageant $keys
          }
      }
      else {
          foreach ($value in $args) {
              & $pageant $value
          }
      }
  }
  else {
      $sshAdd = Get-Command ssh-add -TotalCount 1 -ErrorAction SilentlyContinue
      $sshAdd = if ($sshAdd) { $sshAdd } else { Find-Ssh('ssh-add') }
      if (!$sshAdd) {
          if (!$Quiet) {
              Write-Warning 'Could not find ssh-add'
          }
          return
      }

      if ($args.Count -eq 0) {
        # Win10 ssh agent will prompt for key password even if the key has already been added
        # Check to see if any keys have been added. Only add keys if it's empty.
        if (Get-NativeSshAgent) {
            (& $sshAdd -L) | Out-Null
            if ($LASTEXITCODE -eq 0) {
                # Keys have already been added
                if (!$Quiet) {
                    Write-Host Keys have already been added to the ssh agent.
                }
               return;
            }
        }

        if ($All) {
            # If All is specified, then parse the config file for keys to add.
            $config = Get-SshConfig
            foreach($entry in $config) {
                if ($entry['IdentityFile']) {
                    & $sshAdd $config['IdentityFile']
                }
            }
        }
        else {
            # Otherwise just run without args, so it'll add the default key.
            & $sshAdd
        }
    }
    else {
        foreach ($value in $args) {
            & $sshAdd $value
        }
    }
  }
}

function Get-NativeSshAgent {
    # $IsWindows is defined in PS Core.
    if (($PSVersionTable.PSVersion.Major -lt 6) -or $IsWindows) {
        # The ssh.exe binary version must include "OpenSSH"
        # The windows ssh-agent service must exist
        $service = Get-Service ssh-agent -ErrorAction Ignore
        $executableMatches = Get-Command ssh.exe -ErrorAction Ignore | ForEach-Object FileVersionInfo | Where-Object ProductVersion -match OpenSSH
        $valid = $service -and $executableMatches
        if ($valid) {
            return $service;
        }
    }
}

function Start-NativeSshAgent([switch]$Quiet, [string]$StartupType = 'Manual') {
    $service = Get-NativeSshAgent

    if (!$service) {
        return $false;
    }

    # Enable the servivce if it's disabled and we're an admin
    if ($service.StartType -eq "Disabled") {
        if (Test-Administrator) {
            Set-Service "ssh-agent" -StartupType $StartupType
        }
        else {
            Write-Error "The ssh-agent service is disabled. Please start the service and try again."
            # Exit with true so Start-SshAgent doesn't try to do any other work.
            return $true
        }
    }

    # Start the service
    if ($service.Status -ne "Running") {
        if (!$Quiet) {
            Write-Host "Starting ssh agent service."
        }
        Start-Service "ssh-agent"
    }

    if ($env:GIT_SSH) {
        if (!$Quiet) {
            Write-Host "GIT_SSH is set, not setting core.sshCommand in .gitconfig"
        }
    }
    else {
        # Make sure git is configured to use OpenSSH-Win32
        $sshCommand = (Get-Command ssh.exe -ErrorAction Ignore | Select-Object -ExpandProperty Path).Replace("\", "/")
        $sshCommand = "`"$sshCommand`""
        $configuredSshCommand = git config --global core.sshCommand

        if ($configuredSshCommand) {
            # If it's already set to something else, warn the user.
            if ($configuredSshCommand -ne $sshCommand) {
                Write-Warning "core.sshCommand in your .gitconfig is set to $configuredSshCommand, but it should be set to $sshCommand."
            }
        }
        else {
            if (!$Quiet) {
                Write-Host "Setting core.sshCommand to $sshCommand in .gitconfig"
            }
            git config --global core.sshCommand $sshCommand
        }
    }

    Add-SshKey -Quiet:$Quiet

    return $true
}

# Retrieve the current SSH agent PID (or zero). Can be used to determine if there
# is a running agent.
function Get-SshAgent() {
    if ($env:GIT_SSH -imatch 'plink') {
        $pageantPid = Get-Process | Where-Object { $_.Name -eq 'pageant' } | Select-Object -ExpandProperty Id -First 1
        if ($null -ne $pageantPid) { return $pageantPid }
    }
    elseif ($native = Get-NativeSshAgent) {
        return $native
    }
    else {
        $agentPid = $Env:SSH_AGENT_PID
        if ($agentPid) {
            $sshAgentProcess = Get-Process | Where-Object { ($_.Id -eq $agentPid) -and ($_.Name -eq 'ssh-agent') }
            if ($null -ne $sshAgentProcess) {
                return $agentPid
            }
            else {
                setenv 'SSH_AGENT_PID' $null
                setenv 'SSH_AUTH_SOCK' $null
            }
        }
    }

    return 0
}

# Attempt to guess $program's location. For ssh-agent/ssh-add.
function Find-Ssh($program = 'ssh-agent') {
    Write-Verbose "$program not in path. Trying to guess location."
    $gitItem = Get-Command git -CommandType Application -Erroraction SilentlyContinue | Get-Item
    if ($null -eq $gitItem) {
        Write-Warning 'git not in path'
        return
    }

    $sshLocation = join-path $gitItem.directory.parent.fullname bin/$program
    if (get-command $sshLocation -Erroraction SilentlyContinue) {
        return $sshLocation
    }

    $sshLocation = join-path $gitItem.directory.parent.fullname usr/bin/$program
    if (get-command $sshLocation -Erroraction SilentlyContinue) {
        return $sshLocation
    }
}

# Loosely based on bash script from http://help.github.com/ssh-key-passphrases/
function Start-SshAgent {
    param(
        [Parameter(Position = 0)]
        [ValidateSet("Automatic", "Boot", "Disabled", "Manual", "System")]
        [string]
        $StartupType = "Manual",

        [Parameter()]
        [switch]
        $Quiet,

        [Parameter()]
        [ValidateSet("Process", "User")]
        [string]
        $Scope = "Process"
    )

    # If we're using the win10 native ssh client,
    # we can just interact with the service directly.
    if (Start-NativeSshAgent -Quiet:$Quiet -StartupType:$StartupType) {
        return
    }

    [int]$agentPid = Get-SshAgent
    if ($agentPid -gt 0) {
        if (!$Quiet) {
            $agentName = Get-Process -Id $agentPid | Select-Object -ExpandProperty Name
            if (!$agentName) { $agentName = "SSH Agent" }
            Write-Host "$agentName is already running (pid $($agentPid))"
        }
        return
    }

    if ($env:GIT_SSH -imatch 'plink') {
        Write-Host "GIT_SSH set to $($env:GIT_SSH), using Pageant as SSH agent."

        $pageant = Get-Command pageant -CommandType Application -TotalCount 1 -Erroraction SilentlyContinue
        $pageant = if ($pageant) { $pageant } else { Find-Pageant }
        if (!$pageant) {
            if (!$Quiet) {
                Write-Warning 'Could not find Pageant'
            }
            return
        }

        Start-Process -NoNewWindow $pageant
    }
    else {
        $sshAgent = Get-Command ssh-agent -CommandType Application -TotalCount 1 -ErrorAction SilentlyContinue
        $sshAgent = if ($sshAgent) { $sshAgent } else { Find-Ssh('ssh-agent') }
        if (!$sshAgent) {
            if (!$Quiet) {
                Write-Warning 'Could not find ssh-agent'
            }
            return
        }

        & $sshAgent | ForEach-Object {
            if ($_ -match '(?<key>[^=]+)=(?<value>[^;]+);') {
                setenv $Matches['key'] $Matches['value'] $Scope
            }
        }
    }

    Add-SshKey -Quiet:$Quiet
}


# Stop a running SSH agent
function Stop-SshAgent() {
    if ($nativeAgent = Get-NativeSshAgent) {
        Stop-Service $nativeAgent.Name
        return
    }

    [int]$agentPid = Get-SshAgent
    if ($agentPid -gt 0) {
        # Stop agent process
        $proc = Get-Process -Id $agentPid -ErrorAction SilentlyContinue
        if ($null -ne $proc) {
            Stop-Process $agentPid
        }

        setenv 'SSH_AGENT_PID' $null
        setenv 'SSH_AUTH_SOCK' $null
    }
}