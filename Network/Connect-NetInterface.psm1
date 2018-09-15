<#
    .SYNOPSIS
    Connect-NetInterface
    .DESCRIPTION
    This function disables (turns off) and enables (turns on) network interface cards.
    You can specify if you want to use LAN or WLAN (WIFI) network. In case of WLAN you
    can also put additional parameter - name of the wireless network to which you want
    to connect. This function uses wmic and Get-NetInterfaceIndex to find a NIC.
    .EXAMPLE
    nic lan
    nic wifi
    nic wifi SEPM4G_101
    .NOTES
     author: Albert
#>
function Connect-NetInterface {
    [cmdletbinding()]
    Param(
        [string] $type = 'LAN',
        [string] $wlanName,
        [int] $timeout = 15
    )

    Begin {
        $lanIndex = Get-NetInterfaceIndex card lan
        $wlanIndex = Get-NetInterfaceIndex card wlan
    }

    Process {
        if($type -eq 'LAN'){
            wmic path win32_networkadapter where index=$wlanIndex call disable
            wmic path win32_networkadapter where index=$lanIndex call enable
        }

        elseif($type -in 'WLAN', 'WIFI'){
            wmic path win32_networkadapter where index=$lanIndex call disable
            wmic path win32_networkadapter where index=$wlanIndex call enable

            if($wlanName){
                Connect-WlanProfile $wlanName $wlanIndex $timeout
            }
        }
    }
}

function Connect-WlanProfile([string]$wlanName, [int]$wlanIndex, [int]$timeout){
    Write-Verbose "Waiting for the NIC (index=$wlanIndex) to be ready..."
    $start = Get-Date
    while(-not((wmic nic index=$wlanIndex get NetConnectionStatus) -match "7")){
        $now = Get-Date
        $timeLeft = $now - $start
        if($timeLeft.TotalSeconds -gt $timeout){
            Write-Warning `
                "Timeout exceeded - NIC is not ready to connect in $timeout seconds"
            return
        }
    }
    start-sleep 1
    netsh wlan connect name="$wlanName"
}

New-Alias -Name Connect-NIC -Value Connect-NetInterface
New-Alias -Name nic -Value Connect-NetInterface
Export-ModuleMember -Alias * -Function Connect-NetInterface