New-Item -Item SymbolicLink -Force `
    -Target (Resolve-Path "~\dotfiles\WindowsTerminal-profiles.json") `
    -Path "~\AppData\Local\Packages\Microsoft.WindowsTerminal_8wekyb3d8bbwe\LocalState\settings.json"

mkdir ~\AppData\Local\nvim\autoload

$uri = 'https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
(New-Object Net.WebClient).DownloadFile(
  $uri,
  $ExecutionContext.SessionState.Path.GetUnresolvedProviderPathFromPSPath(
    "~\AppData\Local\nvim\autoload\plug.vim"
  )
)

New-Item -Item SymbolicLink -Force `
    -Target (Resolve-Path "~\dotfiles\init.vim") `
    -Path "~\AppData\Local\nvim\init.vim"

New-Item -Item SymbolicLink -Force `
    -Target (Resolve-Path "~\dotfiles\Powershell_profile.ps1") `
    -Path "$profile"

# New-Item -Item SymbolicLink -Force `
#     -Target (Resolve-Path "~\dotfiles\vscode\settings.json") `
#     -Path "~\AppData\Roaming\Code\User\settings.json"

# New-Item -Item SymbolicLink -Force `
#     -Target (Resolve-Path "~\dotfiles\vscode\keybindings.json") `
#     -Path "~\AppData\Roaming\Code\User\keybindings.json"

New-Item -Item SymbolicLink -Force `
    -Target (Resolve-Path "~\dotfiles\.gitconfig") `
    -Path "~\.gitconfig"

New-Item -Item SymbolicLink -Force `
    -Target (Resolve-Path "~\dotfiles\.yarnrc.yml") `
    -Path "~\.yarnrc.yml"

New-Item -Item SymbolicLink -Force `
    -Target (Resolve-Path "~\dotfiles\.ideavimrc") `
    -Path "~\.ideavimrc"

Install-Module posh-git -Scope CurrentUser -Force
Install-Module oh-my-posh -Scope CurrentUser -Force
# Windows 10 PS6+ Already have PSReadLine
# Install-Module -Name PSReadLine -AllowPrerelease -Scope CurrentUser -Force -SkipPublisherCheck
