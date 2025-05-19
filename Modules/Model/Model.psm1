Set-StrictMode -Version Latest

[string]$global:extractBox = ""
[string]$global:compileBox = ""

<#
    Function to start the main process
#>
<#
    Function to take in the contents of a .txt file
#>
function Get-PathAssets(
    $Path
){
    return Get-ChildItem -Path $path -Recurse
}
function Convert-CodeToText(
    $Path
){
    $pathContents = Get-PathAssets -Path -$Path
    Write-Host $pathContents
}

function Get-ExtractedPath(){
    return $extractBox
}
function Set-ExtractedPath(
    [string]$textboxValue
){
    $extractBox = $textboxValue
}
function Start-LegacyModel(

){
    Write-Host "Start Task"
    # $hostFile = $PSScriptRoot
    # $containedContents = Get-ChildItem $hostFile
    $textFiles = Get-ChildItem -Path Input\*.txt
    # $regexMatch = '\/\*\n\* (\S+\.\S+)\n\*\/\n([\s\S]+?)(?=\/\*\n\* \S+.\S+\n\*\/|\z)'
    $regexMatch = '\/\*\n\* (\S+\.\S+)\n\*\/\n([\s\S]+?)(?=\/\*\n\* \S+.\S+\n\*\/|\z)'
    $codeToSplit = ""
    $codeToSplit2 = ""
    $seperatedCodeSnippets = ""
    # TODO : Look at ShouldProcess functions
    if ($textFiles.GetType() -eq [System.IO.FileInfo]) {
        $codeToSplit = Get-Content $textFiles -Raw
        $codeToSplit2 = Get-Content -Delimiter "~~~~~~" $textFiles
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
    } elseif ($textFiles.GetType() -eq [System.Object[]]) {
        <# 
            TODO:
            for now, inform user that more than one text file was found
            but eventually add option to choose which file
        #>
        Write-Host "More than 1 file found in Input folder"
    } else {
        Write-Host "File Type Not Matched"
        Write-Host "File Type Found: " + $textFiles
    }

    Write-Host "End Task"
}