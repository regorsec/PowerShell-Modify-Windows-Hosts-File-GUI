# This script provides a GUI Interface to Manage/Modify your Windows Hosts file. 
# By: RegorSec



Function MakeNewForm {

	$Form.Close()

	$Form.Dispose()

	MakeForm
}

Function MakeForm {

Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName System.Drawing

# Location of Hosts file
$hostfile = 'c:\windows\system32\drivers\etc\hosts';

# Generate the form
$form = New-Object System.Windows.Forms.Form
$form.Text = 'Hosts File Manager'
$form.Size = New-Object System.Drawing.Size(900,600)
$form.StartPosition = 'CenterScreen'
$form.Topmost = $true
$form.Add_Shown({$textBox.Select()})

# Generate Label #1
$txt = New-Object System.Windows.Forms.Label
$txt.Location = New-Object System.Drawing.Point(250,20)
$txt.Size = New-Object System.Drawing.Size(380,25)
$txt.Font = 'Microsoft Sans Serif,13'
$txt.Text = 'HOSTS FILE MANAGEMENT'
$form.Controls.Add($txt)

# Generate Label #2
$label = New-Object System.Windows.Forms.Label
$label.Location = New-Object System.Drawing.Point(360,125)
$label.Size = New-Object System.Drawing.Size(260,25)
$label.Font = 'Microsoft Sans Serif,10'
$label.Text = 'Add New Host:'
$form.Controls.Add($label)

# Generate Text Input field
$textBox = New-Object System.Windows.Forms.TextBox
$textBox.Location = New-Object System.Drawing.Point(260,155)
$textBox.Size = New-Object System.Drawing.Size(260,100)
$textBox.Width = 350
$textBox.Height = 100
$form.Controls.Add($textBox)

# Generate Save Button
$okButton = New-Object System.Windows.Forms.Button
$okButton.Location = New-Object System.Drawing.Point(390,185)
$okButton.Size = New-Object System.Drawing.Size(75,25)
$okButton.Text = 'OK'

# Map Button Click to specific code action.
$form.AcceptButton = $okButton
$form.Controls.Add($okButton)

$okbutton.Add_Click(
{

# Add the new content
Add-Content -Path $hostfile -Value $textBox.Text

# Show a success  message
[System.Windows.Forms.MessageBox]::Show("Host Added Successfully")

# This generates new form/application popup - required to work.
MakeNewForm


})


# Generate Label for Reading current hosts file entries
$Label03                     = New-Object system.Windows.Forms.Label
$Label03.text                = "Your Current Host File Entries"
$Label03.AutoSize            = $true
$Label03.width               = 25
$Label03.height              = 10
$Label03.location            = New-Object System.Drawing.Point(300,250)
$Label03.Font                = 'Microsoft Sans Serif,10'

$Form.Controls.Add($Label03)

# Generate text input field to show current hosts file entries
$textbox03                       = New-Object system.Windows.Forms.TextBox
$textbox03.multiline                = $true
$textbox03.width                    = 600
$textbox03.height                   = 140
$textbox03.location                 = New-Object System.Drawing.Point(160,280)
$textbox03.Font                     = 'Microsoft Sans Serif,10'
$textbox03.Scrollbars = "Vertical"
$textbox03.Lines = Get-Content $hostfile | Select-String -Pattern "#" -NotMatch |  % { $_.Line } | Out-String

$Form.Controls.Add($textbox03)

# Generate label for Reset button
$label = New-Object System.Windows.Forms.Label
$label.Location = New-Object System.Drawing.Point(350,465)
$label.Size = New-Object System.Drawing.Size(200,20)
$label.Font = 'Microsoft Sans Serif,10'
$label.Text = 'Reset Hosts File'
$form.Controls.Add($label)

# Generate Button for resetting hosts file
$resetButton = New-Object System.Windows.Forms.Button
$resetButton.Location = New-Object System.Drawing.Point(390,495)
$resetButton.Size = New-Object System.Drawing.Size(75,25)
$resetButton.Text = 'OK'

$form.AcceptButton = $resetButton
$form.Controls.Add($resetButton)

# Define the action that happens when reset button is clicked
$resetbutton.Add_Click(
{

# Clear the hosts file
Clear-Content $hostfile 

# Show success message
[System.Windows.Forms.MessageBox]::Show("Hosts File Reset Successfully")

# This generates new form/application popup - required to work.
MakeNewForm


})



$result = $form.ShowDialog()



 }

 MakeForm