Set-StrictMode -Version Latest
###
<#
    Function to start the maine process
#>
# function Start-Main {
#     param (
#         OptionalParameters
#     )
#     Write-Host "Start Task"

#     Write-Host "End Task"
# }
<#
    Function to take in the contents of a .txt file
#>
# function Get-Split-Code-Files{
#     param (
#         $textContents,
#         $regexQuery
#     )
#     return ($textContents -split $regexQuery)
# }
###
Write-Host "Start Task"
# $hostFile = $PSScriptRoot
# $containedContents = Get-ChildItem $hostFile
$textFiles = Get-ChildItem -Path Input\*.txt
$regexMatch = '\/\*\n\* (\S+.\S+)\n\*\/\n([\s\S]+?)(?=\/\*\n\* \S+.\S+\n\*\/|\z)'
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
    $seperatedCodeSnippets = [Regex]::Matches($codeToSplit2, $regexMatch)
    Write-Host "String Looked at:
        " $codeToSplit2
    Write-Host "Regex:
        " $regexMatch
    Write-Host "Output:
        " $seperatedCodeSnippets.Count
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
###

# function testFunction {
#     param (
#         $numberOne,
#         $numberTwo
#     )
#     Write-Output $numberOne+$numberTwo
# }

# testFunction 1 2