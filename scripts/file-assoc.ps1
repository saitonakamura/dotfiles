$nvimPath = get-command nvim-qt.exe | % Source
AssociateFileExtensions -FileExtensions ".log",".json" -OpenAppPath $nvimPath

