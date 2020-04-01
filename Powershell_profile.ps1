$env:FZF_DEFAULT_COMMAND='fd --hidden'

function Set-Location-Fzf([string] $Path = ".") {
  Set-Location $(fd --type directory --hidden --exclude .git . $Path | fzf)
}

Set-Alias -Name nd -Value Set-Location-Fzf -Force

function Open-File-Fzf([string] $Path = ".", [string] $Editor = "nvim-qt.exe") {
  & $Editor $(fd --type file --hidden --exclude .git . $Path | fzf)
}

Set-Alias -Name nf -Value Open-File-Fzf -Force

# Git

# Set-Alias -Name gd -Value "git diff"
# Set-Alias -Name gds -Value "git diff --staged"
# Set-Alias -Name gl -Value git pull
# Set-Alias -Name gp -Value git push
# Set-Alias -Name gpf -Value git push --force-with-lease
# Set-Alias -Name gs -Value git status
# Set-Alias -Name gss -Value git status --short
# Set-Alias -Name gf -Value git fetch
