using namespace System.Windows.Forms
using namespace System.Drawing

Set-StrictMode -Version Latest
Add-Type -AssemblyName System.Drawing

Add-Type -AssemblyName System.Windows.Forms 
Add-Type -AssemblyName System.Drawing

#Default Variables
$dContainerWidth = 300
$dContainerHeight = 200

[int32]$dTextboxWidth = ($dContainerWidth/100)*80
[int32]$dTextboxHeight = ($dContainerHeight/100)*20

$dButtonWidth = ($dContainerWidth/100)*20
$dButtonHeight = ($dContainerHeight/100)*20

$dText = ""

#Functions
# function createButton(
#     [Int32]$buttonX,
#     [Int32]$buttonY,
#     [Int32]$sizeX,
#     [Int32]$sizeY
# ){

# }
function alignH([Int32]$pWidth){
    #Given the width
    #When the function triggers
    #Then we return the location int needed to centre the object
    return $dContainerWidth - $pWidth
}
function setGenericMeasurements(
    $pObject,
    [Int32]$pWidth, 
    [Int32]$pHeight, 
    [Int32]$pX, 
    [Int32]$pY
){
    $pObject.Location = [Point]::new($pX, $pY)
    if (
        ($pObject).GetType().Name -ne "TextBox"
    ){
        $pObject.Size = [Size]::new($pWidth, $pHeight)
    }
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
try {
    # setGenericMeasurements($textPathInput, $dTextboxWidth, $dTextboxHeight, alignH(dTextboxWidth), 50)
    setGenericMeasurements
        $textPathInput 
        $dTextboxWidth
        $dTextboxHeight 
        50
        50
}
catch {
    Write-Output "Error:"
    Write-Output $_
}

$textPathInput.Location = [Point]::new(50,50)

###Output
$textPathOutput = [TextBox]::new()
# setGenericMeasurements($textPathOutput, $dTextboxWidth, $dTextboxHeight, alignH(dTextboxWidth), 50)
$textPathOutput.Location = [Point]::new(100,100)

#Buttons
$printButton = [Button]::new()

#Controls
$container.Controls.Add($textPathInput)
$container.Controls.Add($textPathOutput)
$container.Controls.Add($printButton)

# Show the form
$container.Topmost = $true
$container.Add_Shown(
    { 
        $container.Activate()
    }
)
$container.ShowDialog()
