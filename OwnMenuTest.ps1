using namespace System.Windows.Forms
using namespace System.Drawing

Set-StrictMode -Version Latest
Add-Type -AssemblyName System.Drawing

Add-Type -AssemblyName System.Windows.Forms 
Add-Type -AssemblyName System.Drawing

#Default Variables
$dContainerWidth = 450
$dContainerHeight = 300

[int32]$dTextboxWidth = ($dContainerWidth/100)*80
[int32]$dTextboxHeight = ($dContainerHeight/100)*20
[int32]$dButtonWidth = ($dContainerWidth/100)*20
[int32]$dButtonHeight = ($dContainerHeight/100)*10
[string]$dText = "notAssigned"

#Functions
function Set-HoriontalAlign([Int32]$pWidth){
    return $dContainerWidth/2 - $pWidth/2
}
function Set-VerticalAlign([Int32]$pAlignHeight){
    return $dContainerHeight/2 - $pAlignHeight/2
}
function Set-ControlProperties(
    [Control]$pObject,
    [Int32]$pWidth = 50,
    [Int32]$pHeight = 50,
    # [Int32]$pX = $dContainerWidth/2,
    [Int32]$pX = {Set-HoriontalAlign -pWidth $pWidth},
    [Int32]$pY = $dContainerHeight/2
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

#Object Setup
##Container
$container = [Form]::new()
$container.Text = "App"
$container.Size = [Size]::new($dContainerWidth,$dContainerHeight)
$container.StartPosition = "CenterScreen"

##Textboxs
###Input
$textPathInput = [TextBox]::new()
$textPathInput.Location = [Point]::new(50,50)

###Output
$textPathOutput = [TextBox]::new()
$textPathOutput.Location = [Point]::new(100,100)

#Buttons
$printButton = [Button]::new()
# $printbutton2 = New-Button -buttonX 50 -buttonY 100
$printbutton2 = New-Button -buttonX 100 -buttonY 100


#Controls
$container.Controls.Add($printbutton2)
# $container.Controls.Add($textPathInput)
# $container.Controls.Add($textPathOutput)
# $container.Controls.Add($printButton)

# Show the form
$container.Topmost = $true
$container.Add_Shown(
    { 
        $container.Activate()
    }
)
$container.ShowDialog()
