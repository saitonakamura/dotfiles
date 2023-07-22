## winget

## powershell

```cmd
winget install --id Microsoft.Powershell --source winget
```

## ssh

```powershell
gsudo { Remove-WindowsCapability -Online -Name OpenSSH.Client~~~~0.0.1.0 }
winget install Microsoft.OpenSSH.Beta
```

Add `C:/Program Files/OpenSSH` to PATH

## ideavim

```powershell
gsudo {
    New-Item -Item SymbolicLink -Force `
        -Target (Resolve-Path "~\dotfiles\.ideavimrc") `
        -Path "~\.ideavimrc"
}
```

