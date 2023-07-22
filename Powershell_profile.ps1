$DefaultUser = 'saito'

# Import-Module posh-git
# Import-Module oh-my-posh

oh-my-posh init pwsh --config "$env:POSH_THEMES_PATH\powerlevel10k_modern.omp.json" | Invoke-Expression
Import-Module PSReadLine

$env:FZF_DEFAULT_COMMAND='fd'
$env:FZF_CTRL_T_COMMAND='fd'
$env:FZF_ALT_C_COMMAND='fd --type d'

Import-Module PSFzf

Set-PsFzfOption -PSReadlineChordProvider 'Ctrl+t' -PSReadlineChordReverseHistory 'Ctrl+r'
Set-PSReadLineKeyHandler -Key Tab -ScriptBlock { Invoke-FzfTabCompletion }
Set-PsFzfOption -TabExpansion

fnm env --use-on-cd | Out-String | Invoke-Expression

$dotfiles = get-item $profile | select-object -ExpandProperty Target
$dotfilesDir = (get-item $dotfiles).Directory.FullName
. "$dotfilesDir\PSModules\posh-sshell.ps1"
Start-SshAgent -Quiet

# function Set-Location-Fzf([string] $Path = ".") {
#   Set-Location $(fd --type directory --hidden --exclude .git . $Path | fzf)
# }

# Set-Alias -Name nd -Value Set-Location-Fzf -Force

# function Open-File-Fzf([string] $Path = ".", [string] $Editor = "nvim-qt.exe") {
#   & $Editor $(fd --type file --hidden --exclude .git . $Path | fzf)
# }

# Set-Alias -Name nf -Value Open-File-Fzf -Force

# Set-Alias -Name pd -Value Get-ChildItem -Force

# Git

# Set-Alias -Name gd -Value "git diff"
# Set-Alias -Name gds -Value "git diff --staged"
# Set-Alias -Name gl -Value git pull
# Set-Alias -Name gp -Value git push
# Set-Alias -Name gpf -Value git push --force-with-lease
# Set-Alias -Name gs -Value git status
# Set-Alias -Name gss -Value git status --short
# Set-Alias -Name gf -Value git fetch
# Set-Prompt
# Set-Theme Paradox
# Set-PoshPrompt -Theme powerlevel10k_modern
