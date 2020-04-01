New-Item -Item SymbolicLink -Force `
    -Target (Resolve-Path ".\WindowsTerminal-profiles.json") `
    -Path "~\AppData\Local\Packages\Microsoft.WindowsTerminal_8wekyb3d8bbwe\LocalState\profiles.json"

mkdir ~\AppData\Local\nvim\autoload

$uri = 'https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
(New-Object Net.WebClient).DownloadFile(
  $uri,
  $ExecutionContext.SessionState.Path.GetUnresolvedProviderPathFromPSPath(
    "~\AppData\Local\nvim\autoload\plug.vim"
  )
)

New-Item -Item SymbolicLink -Force `
    -Target (Resolve-Path ".\init.vim") `
    -Path "~\AppData\Local\nvim\init.vim"


New-Item -Item SymbolicLink -Force `
    -Target (Resolve-Path ".\Powershell_profile.ps1") `
    -Path "$profile"
