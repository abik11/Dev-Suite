<#
    .SYNOPSIS
    Set-NetInterface
    .DESCRIPTION
    This function sets network interface IP address, subnet mask, gateway and
    primary and secondary DNS server statically. It also allows to set all
    those parameters automatically from DHCP. It uses netsh command and 
    Get-NetInterfaceIndex to find a NIC.
    .EXAMPLE
    setnic lan address auto
    setnic lan dns auto
    setnic wlan address 100.110.82.15 255.255.255.0 100.110.85.1
    setnic wlan dns 100.110.90.62 100.110.90.61
    .NOTES
     author: Albert
#>
function Set-NetInterface {
    [cmdletbinding()]
    Param(
        [Parameter(mandatory=$true)]
        [string] $networkType,
        [Parameter(mandatory=$true)]
        [string] $config,
        [string] $addr1,
        [string] $addr2,
        [string] $addr3
    )

    Begin {
        if($networkType -eq 'LAN'){
            $index = Get-NetInterfaceIndex interface lan
        }
        elseif($networkType -in ('WLAN', 'WIFI')){
            $index = Get-NetInterfaceIndex interface wlan
        }
    }

    Process {
        if($config -eq "address"){
            if($addr1 -eq "auto"){
                netsh interface ipv4 set address $index source=dhcp
            }
            else {
                netsh interface ipv4 set address $index static $addr1 $addr2 $addr3
            }
        }

        elseif($config -eq "dns"){
            if($addr1 -eq "auto"){
                netsh interface ipv4 set dnsservers $index source=dhcp
            }
            else {
                netsh interface ipv4 set dnsservers $index static $addr1
                if($addr2){
                    netsh interface ipv4 add dnsserver $index $addr2 index=2
                }
            }
        }
    }
}

New-Alias -Name Set-NIC -Value Set-NetInterface
New-Alias -Name setnic -Value Set-NetInterface
Export-ModuleMember -Alias * -Function *