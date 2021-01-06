$nvimPath = get-command nvim-qt.exe | % Source
$codePath = get-command code.exe | % Source
$nvimFiles = @(".log", ".json", ".csproj", ".txt", ".md", ".gitignore")
$codeFiles = @(".log", ".json", ".csproj", ".txt", ".md", ".gitignore")
# AssociateFileExtensions -FileExtensions $nvimFiles -OpenAppPath $nvimPath
AssociateFileExtensions -FileExtensions $codeFiles -OpenAppPath $codePath

