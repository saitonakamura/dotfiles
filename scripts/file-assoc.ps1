$nvimPath = get-command nvim-qt.exe | % Source
$nvimFiles = @(".log", ".json", ".csproj", ".txt", ".md", ".gitignore")
AssociateFileExtensions -FileExtensions $nvimFiles -OpenAppPath $nvimPath

