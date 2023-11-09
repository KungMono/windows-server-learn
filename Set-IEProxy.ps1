using namespace System.Management.Automation.Host


# Start scanstate on source machine
function Set-ProxyFBTA {
	Remove-ItemProperty -Path 'HKCU:\Software\Microsoft\Windows\CurrentVersion\Internet Settings' -Name ProxyServer -ErrorAction Ignore
	Set-ItemPropert -Path 'HKCU:\Software\Microsoft\Windows\CurrentVersion\Internet Settings' -name AutoConfigURL -value 'HTTP://SERVERNAME.DOMAIN.COM/TLSProxy/wpad.dat'
}

# Start loadstate on destination machine
function Set-ProxyPicsy {
	Remove-ItemProperty -Path 'HKCU:\Software\Microsoft\Windows\CurrentVersion\Internet Settings' -name AutoConfigURL -ErrorAction Ignore
	Set-ItemProperty -Path 'HKCU:\Software\Microsoft\Windows\CurrentVersion\Internet Settings' -Name ProxyServer -value "IPorDomain:Port"
}

# Show Menu
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
    
    $proxyfbta = [ChoiceDescription]::new('&FBTA', 'Set IE Proxy Settings for FBTA')
    $proxypicsy = [ChoiceDescription]::new('&Picsy', 'Set IE Proxy Settings Picsy')


    $options = [ChoiceDescription[]]($proxyfbta, $proxypicsy)

    $result = $host.ui.PromptForChoice($Title, $Question, $options, 0)

    switch ($result) {
        0 { Set-ProxyFBTA }
        1 { Set-ProxyPicsy }
    }

}

New-Menu -Title 'Confirm' -Question 'Which proxy configuration to use?'
