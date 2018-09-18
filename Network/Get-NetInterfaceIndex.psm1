<#
    .SYNOPSIS
    Get-NetInterfaceIndex
    .DESCRIPTION
    This function returns indexes of NIC (network interface card) or network interface
    (connection) of LAN or WLAN network. This function searches for the interfaces by
    the connection names, it uses a phrase that a connection name contains, you can specify
    the phrase as parameters. The function uses internally wmic command.
    .EXAMPLE
    Get-NetInterfaceIndex card wlan
    Get-NetInterfaceIndex interface lan
    .NOTES
     author: Albert
#>
function Get-NetInterfaceIndex {
    [cmdletbinding()]
    Param(
        [string] $indexType,
        [string] $networkType = 'LAN',
        [string] $phrase
    )

    Begin {
        $phrase = ""

        if($networkType -eq 'LAN'){
            $phrase = $defaultLanConnectionPhrase
        }
        elseif($networkType -in ('WLAN', 'WIFI')){
            $phrase = $defaultWlanConnectionPhrase
        }

        Write-Verbose "Searching $indexType index for the phrase: $phrase..."
    }
    
    Process {
        $indexesStr = `
            (wmic nic get Index,InterfaceIndex,NetConnectionID `
            | Select-String $phrase | Select -First 1).ToString().Trim()

        Write-Verbose "Phrase found in: $indexesStr"
        $cardIndex = $indexesStr.Substring(0,2)
        $interfaceIndex = $indexesStr.Substring(7,2)       
    }

    End {
        if($indexType -in ('card', 'c', 'nic')){
            Write-Verbose "Found index: $cardIndex"
            return [int]$cardIndex
        }
        elseif($indexType -in ('interface', 'i', 'iface')){
            Write-Verbose "Found index: $interfaceIndex"
            return [int]$interfaceIndex
        }
    }
}

New-Alias -Name getnetindex -Value Get-NetInterfaceIndex
Export-ModuleMember -Alias * -Function *