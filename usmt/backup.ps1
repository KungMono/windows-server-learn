using namespace System.Management.Automation.Host

if (-not (Test-Path -Path D:\USMT\amd64\scanstate.exe -PathType Leaf)) {
    Throw 'The file does not exist'
} else {
    # Continuing script if file exists...
}

if (-not (Test-Path -Path D:\USMT\amd64\loadstate.exe -PathType Leaf)) {
    Throw 'The file does not exist'
} else {
    # Continuing script if file exists...
}


# Write-Host 'Continuing script regardless if file exists or not...'



function New-Menu {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory)]
        [ValidateNotNullOrEmpty()]
        [string]$Title,

        [Parameter(Mandatory)]
        [ValidateNotNullOrEmpty()]
        [string]$Question
    )
    
    $backup = [ChoiceDescription]::new('&Backup', 'Backup files to USB')
    $blue = [ChoiceDescription]::new('&Restore', 'Restore files from USB')
    $yellow = [ChoiceDescription]::new('&Yellow', 'Favorite color: Yellow')

    $options = [ChoiceDescription[]]($backup, $blue, $yellow)

    $result = $host.ui.PromptForChoice($Title, $Question, $options, 0)

    switch ($result) {
        0 { $migdir = "C:\TEMP\MigrationStore\$env:COMPUTERNAME"
            $migdir
            .\scanstate.exe $migdir /i:Config.xml /o /vsc /ue:*\* /ui:fpcahk\$env:UserName /listfiles:$migdir\FilesMigrated.log /l:$migdir\scan.log /progress:$migdir\scan_progress.log /efs:abort /c
        }
        1 { 'Your favorite color is Blue' }
        2 { 'Your favorite color is Yellow' }
    }

}

New-Menu -Title 'Confirm' -Question 'How do you want to transfer your data?'




