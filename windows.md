## ssh

```powershell
gsudo { Remove-WindowsCapability -Online -Name OpenSSH.Client~~~~0.0.1.0 }
winget install openssh
```

## ideavim

```powershell
gsudo {
    New-Item -Item SymbolicLink -Force `
        -Target (Resolve-Path "~\dotfiles\.ideavimrc") `
        -Path "~\.ideavimrc"
}
```

