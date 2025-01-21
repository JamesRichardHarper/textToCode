Set-StrictMode -Version Latest
###
<#
    Function to start the maine process
#>
function Start-Main {
    param (
        OptionalParameters
    )
    
}
###
Write-Host "Start Task"
###
# $hostFile = $PSScriptRoot
# $containedContents = Get-ChildItem $hostFile
$textFiles = Get-ChildItem -Path *.txt
$codeToSplit = ""
# TODO : Look at ShouldProcess functions
if ($textFiles.Length == 0) {
    <# TODO: Build something ot inform user nothing was found #>
} elseif ($textFiles -gt 1) {
    <# 
        TODO:
        for now, inform user that more than one text file was found
        but eventually add option to choose which file
    #>
} else {
    $codeToSplit = Get-Content $textFiles[0]
}
###
Write-Host "End Task"

function testFunction {
    param (
        $numberOne,
        $numberTwo
    )
    Write-Output $numberOne+$numberTwo
}

testFunction 1 2