using namespace System.Windows.Forms
using namespace System.Drawing

Set-StrictMode -Version Latest
Add-Type -AssemblyName System.Drawing

Add-Type -AssemblyName System.Windows.Forms 
Add-Type -AssemblyName System.Drawing

#Default Variables
$dFullWidth = 450
$dFullHeight = $dFullWidth * (9/16)
##Initial Container
$container = [Form]::new()
$container.Text = "App"
$container.Size = [Size]::new($dFullWidth,$dFullHeight)
$container.StartPosition = "CenterScreen"

$containerWidth = $container.ClientSize.Width
$containerHeight = $container.ClientSize.Height

[int32]$dTextboxWidth = ($containerWidth/100)*80
[int32]$dTextboxHeight = ($containerHeight/100)*20
[int32]$dButtonWidth = ($containerWidth/100)*20
[int32]$dButtonHeight = ($containerHeight/100)*10
[string]$dText = "notAssigned"

#Functions
function Set-HoriontalAlign([Int32]$pWidth){
    return $containerWidth/2 - $pWidth/2
}
function Set-VerticalAlign([Int32]$pAlignHeight){
    return $containerHeight/2 - $pAlignHeight/2
}
function Set-ControlProperties(
    [Control]$pObject,
    [Int32]$pWidth = 50,
    [Int32]$pHeight = 50,
    # [Int32]$pX = $containerWidth/2,
    [Int32]$pX = {Set-HoriontalAlign -pWidth $pWidth},
    [Int32]$pY = $containerHeight/2
){
    $pObject.Location = [Point]::new($px, $pY)
    $pObject.Size = [Size]::new($pWidth, $pHeight)
}
function New-Button(
    [string]$buttonText = $dText,
    [Int32]$buttonX,
    [Int32]$buttonY,
    [Int32]$buttonWidth = $dButtonWidth,
    [Int32]$buttonHeight = $dButtonHeight,
    [scriptblock]$buttonAction = {Write-Host "Not Assigned"}
){
    $functionButton = [Button]::new()
    $functionButton.Text = $buttonText
    Set-ControlProperties -pObject $functionButton -pWidth $buttonWidth -pHeight $buttonHeight -pX $buttonX -pY $buttonY
    $functionButton.Add_Click($buttonAction)

    return $functionButton
}
# function New-Textbox(
#     [Int32]$textboxX,
#     [Int32]$textboxY,
#     [Int32]$textboxWidth = $dButtonWidth,
#     [Int32]$textboxHeight = $dButtonHeight,
#     [scriptblock]$buttonAction = {Write-Host "Not Assigned"}
# ){
#     $functionButton = [Button]::new()
#     $functionButton.Text = $buttonText
#     Set-ControlProperties -pObject $functionButton -pWidth $buttonWidth -pHeight $buttonHeight -pX $buttonX -pY $buttonY
#     $functionButton.Add_Click($buttonAction)

#     return $functionButton
# }
# function New-Button(
#     [string]$controlType = "Button",
#     [string]$buttonText = $dText,
#     [Int32]$buttonX,
#     [Int32]$buttonY,
#     [Int32]$buttonWidth = $dButtonWidth,
#     [Int32]$buttonHeight = $dButtonHeight,
#     [scriptblock]$buttonAction = {Write-Host "Not Assigned"}
# ){
#     $functionButton = [Button]::new()
#     $functionButton.Text = $buttonText
#     Set-ControlProperties -pObject $functionButton -pWidth $buttonWidth -pHeight $buttonHeight -pX $buttonX -pY $buttonY
#     $functionButton.Add_Click($buttonAction)

#     return $functionButton
# }
#Object Setup
##Textboxs
###Input
$textPathInput = [TextBox]::new()
$textPathInput.Location = [Point]::new(50,50)

###Output
$textPathOutput = [TextBox]::new()
$textPathOutput.Location = [Point]::new(100,100)

#Buttons
$exitButton = New-Button -buttonText "exit" -buttonX ($containerWidth-($dButtonWidth*1.75)) -buttonY ($containerHeight-($dButtonHeight*2))
$printButton = New-Button -buttonText "testConsole" -buttonX ($dButtonWidth*0.75) -buttonY ($containerHeight-($dButtonHeight*2))


#Controls
$container.Controls.Add($exitButton)
$container.Controls.Add($printButton)
$container.Controls.Add($textPathInput)
$container.Controls.Add($textPathOutput)

# Show the form
$container.Topmost = $true
$container.Add_Shown(
    { 
        $container.Activate()
    }
)
$container.ShowDialog()
