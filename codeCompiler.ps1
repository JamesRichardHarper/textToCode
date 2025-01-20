Set-StrictMode -Version Latest
Write-Host "Start Task"
###
$hostFile = $PSScriptRoot
$containedContents = Get-ChildItem $hostFile
Write-Host $containedContents[0]
###
Write-Host "End Task"