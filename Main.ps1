using namespace System.Windows.Forms
using namespace System.Drawing

Set-StrictMode -Version Latest
Import-Module .\Modules\Model -Force
Add-Type -AssemblyName System.Drawing
Add-Type -AssemblyName System.Windows.Forms 
Add-Type -AssemblyName System.Drawing

#Default Variables
##Init variables needed
$dScreenRatio = (9 / 16)
$dFullWidth = 450
$dFullHeight = $dFullWidth * $dScreenRatio
##Initial Container
$container = [Form]::new()
$container.Text = "App"
$container.Size = [Size]::new($dFullWidth, $dFullHeight)
$container.StartPosition = "CenterScreen"

##Relative Container Size
$containerWidth = $container.ClientSize.Width
$containerHeight = $container.ClientSize.Height

##Textbox Size
[int32]$dTextboxWidth = 200

##Button Size
[int32]$dButtonWidth = 75
[int32]$dButtonHeight = $dButtonWidth * $dScreenRatio

##Default Text
[string]$dText = "notAssigned"

#Functions
function Set-HoriontalAlign([Int32]$pWidth) {
    return $containerWidth / 2 - $pWidth / 2
}
function Set-VerticalAlign([Int32]$pAlignHeight) {
    return $containerHeight / 2 - $pAlignHeight / 2
}
function Set-ControlProperties(
    [Control]$pObject,
    [Int32]$pWidth = 50,
    [Int32]$pHeight = 50,
    # [Int32]$pX = $containerWidth/2,
    [Int32]$pX = { Set-HoriontalAlign -pWidth $pWidth },
    [Int32]$pY = $containerHeight / 2
) {
    $pObject.Location = [Point]::new($px, $pY)
    $pObject.Size = [Size]::new($pWidth, $pHeight)
}
function New-Button(
    [string]$buttonText = $dText,
    [Int32]$buttonX,
    [Int32]$buttonY,
    [Int32]$buttonWidth = $dButtonWidth,
    [Int32]$buttonHeight = $dButtonHeight,
    # [scriptblock]$buttonAction = {Write-Host "Not Assigned"},
    $buttonAction = { Write-Host "Not Assigned" }
) {
    $functionButton = [Button]::new()
    $functionButton.Text = $buttonText
    Set-ControlProperties -pObject $functionButton -pWidth $buttonWidth -pHeight $buttonHeight -pX $buttonX -pY $buttonY
    $functionButton.Add_Click($buttonAction)
    return $functionButton
}
function New-Textbox(
    [Int32]$textBoxX,
    [Int32]$textBoxY,
    [Int32]$textBoxWidth = $dTextboxWidth
) {
    $functionTextBox = [TextBox]::new()
    Set-ControlProperties -pObject $functionTextBox -pWidth $textBoxWidth -pX $textBoxX -pY $textBoxY
    return $functionTextBox
}

#Object Setup
##Object Locations
$panelY = $containerHeight * (5 / 100)
$panelX = $containerWidth * (5 / 100)
$rowSpacing = 10
$columnSpacing = 10

##Initial Label
$bigLabel = [Label]::new()
$bigLabel.Text = "Folder Paths"
$bigLabel.Location = [Point]::new($panelX, $panelY)

##Panel 1
$panelOne = [Panel]::new()
$panelOne.AutoSize = $true
$panelOne.Location = [Point]::new($panelX, $bigLabel.Bottom + $rowSpacing)

$inputLabelOne = [Label]::new()
$inputLabelOne.Text = "Code:"
$inputLabelOne.Location = [Point]::new(0, (0))
$inputLabelOne.AutoSize = $true
$inputLabelOne.Padding = [Padding]::new(0)
##TODO: Having to manually set the width otherwise it defaults to 100
$inputLabelOne.Width = 30
$extractTextBox = New-Textbox -textBoxX ($inputLabelOne.ClientSize.Width + $columnSpacing) -textBoxY (0)
$extractButtonOne = New-Button -buttonX ($extractTextBox.Right + $columnSpacing) -buttonY (0) -buttonText "Extract" -buttonAction {Write-Host $extractTextBox.Text}

$panelOne.Controls.Add($inputLabelOne)
$panelOne.Controls.Add($extractTextBox)
$panelOne.Controls.Add($extractButtonOne)

##Panel 2
$panelTwo = [Panel]::new()
$panelTwo.AutoSize = $true
$panelTwo.Location = [Point]::new($panelX, $panelOne.Bottom + $rowSpacing)

$inputLabelTwo = [Label]::new()
$inputLabelTwo.Text = "Text:"
$inputLabelTwo.Location = [Point]::new(0, (0))
$textPathInputTwo = New-Textbox -textBoxX ($inputLabelTwo.ClientSize.Width + $columnSpacing) -textBoxY (0)
$compileButtonTwo = New-Button -buttonX ($textPathInputTwo.Right + $columnSpacing) -buttonY (0) -buttonText "Compile"

$panelTwo.Controls.Add($inputLabelTwo)
$panelTwo.Controls.Add($textPathInputTwo)
$panelTwo.Controls.Add($compileButtonTwo)

#Controls
$container.Controls.Add($bigLabel)
$container.Controls.Add($panelOne)
$container.Controls.Add($panelTwo)

$container.Topmost = $true
$container.Add_Shown(
    { 
        $container.Activate()
    }
)
$container.ShowDialog()
