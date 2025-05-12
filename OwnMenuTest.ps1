using namespace System.Windows.Forms
using namespace System.Drawing

Set-StrictMode -Version Latest
Add-Type -AssemblyName System.Drawing

Add-Type -AssemblyName System.Windows.Forms 
Add-Type -AssemblyName System.Drawing

#Default Variables
$dContainerWidth = 300
$dContainerHeight = 200

$dTextboxWidth = ($dContainerWidth/100)*80
$dTextboxHeight = ($dContainerHeight/100)*20

$dButtonWidth = ($dContainerWidth/100)*20
$dButtonHeight = ($dContainerHeight/100)*20

$dText = ""

#Functions
function alignH([Int]$pWidth){
    #Given the width
    #When the function triggers
    #Then we return the location int needed to centre the object
    return $dContainerWidth - $pWidth
}
function setGenericMeasurements($pObject, $pWidth, $pHeight, $pX, $pY){
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
    setGenericMeasurements($textPathInput, $dTextboxWidth, $dTextboxHeight, alignH(dTextboxWidth), 50)
}
catch {
    Write-Output "Error:"
    Write-Output $_
}
# $textPathInput.Location = New-Object System.Drawing.Point(50,50)

###Output
$textPathOutput = [TextBox]::new()
# setGenericMeasurements($textPathOutput, $dTextboxWidth, $dTextboxHeight, alignH(dTextboxWidth), 50)
# $textPathOutput.Location = New-Object System.Drawing.Point(100,100)
# $PrintButton = New-Object [Button]

#Controls
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
