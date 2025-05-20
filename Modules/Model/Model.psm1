Set-StrictMode -Version Latest

<#
    Function to start the main process
#>
<#
    Function to take in the contents of a .txt file
#>
function Get-PathAssets(
    $Path
){
    try {
        return Get-ChildItem -Path $Path -Recurse
    }
    catch {
        Write-Host "Error: " + $_
    }
}
function Convert-CodeToText(
    $Path
){
    try {
        $pathContents = Get-PathAssets -Path $Path
        Write-Host $pathContents
    }
    catch {
        Write-Host "Error in converting to text:"
        Write-Host $_
    }
}
function Find-PathContents(
    $filesFound
){
    if ($pathContents.GetType() -eq [System.IO.FileInfo]) {
        return $filesFound
    }elseif ($pathContents.GetType() -eq [System.Object[]]) {
        throw [System.IO.FileNotFoundException] "Multiple files found"
    } else {
        throw "Error occured when finding PathContents: $_"
    }
}
function Read-Text(
    $file
){
    # $regexMatch = '\/\*\n\* (\S+\.\S+)\n\*\/\n([\s\S]+?)(?=\/\*\n\* \S+.\S+\n\*\/|\z)'
    $regexMatch = '\/\*\n\* (\S+\.\S+)\n\*\/\n([\s\S]+?)(?=\/\*\n\* \S+.\S+\n\*\/|\z)'
    $codeToSplit = Get-Content $file -Raw
    $codeToSplit2 = Get-Content -Delimiter "~~~~~~" $file
    Write-Host "RawSplit:
    " $codeToSplit.GetType()
    Write-Host "DefaultSplit:
    " $codeToSplit2.GetType()
    # $seperatedCodeSnippets = [Regex]::Matches($codeToSplit2, $regexMatch)
    $seperatedCodeSnippets = $codeToSplit -match $regexMatch
    Write-Host "String Looked at:
        " $codeToSplit2
    Write-Host "Regex:
        " $regexMatch
    Write-Host "Output:
        " $seperatedCodeSnippets
}
function Convert-TextToCode(
    $Path
){
    Write-Host "Start Task"
    try {
        $pathContents = Get-PathAssets -Path $Path
        Write-Host $pathContents
        # $textFiles = Get-ChildItem -Path Input\*.txt
        # $pathContents = Get-ChildItem -Path $Path
        Find-PathContents $Path
        Read-Text $Path
        Write-Host "End Task"
    }
    catch {
        Write-Host "Error in converting to text:"
        Write-Host $_
    }
}