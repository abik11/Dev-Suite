<#
    .SYNOPSIS
    Get-NetInterfaceConfig
    .DESCRIPTION
    This function...
    .EXAMPLE
    Get-NetInterfaceConfig 12
    getnetconfig 7
    .NOTES
     author: Albert
#>
function Get-NetInterfaceConfig {
    [cmdletbinding()]
    Param(
        [int] $index
    )

    #TODO
    #get DHCPEnabled,IPAddress,IPSubnet,DefaultIPGateway,DNSServerSearchOrder
    [PSCustomObject]@{ 
        IPStatic = Get-NetConfigSingleParameter("DHCPEnabled", $index) -eq 'TRUE'
        Address = Get-NetConfigSingleParameter("IPAddress", $index)
        SubnetMask = Get-NetConfigSingleParameter("IPSubnet", $index)
        Gateway = Get-NetConfigSingleParameter("DefaultIPGateway", $index)
        DNSStatic = ""
        PrimaryDNS = ""
        SecondaryDNS = ""
    }
}

function Get-NetConfigSingleParameter ([string] $parameter, [int]$index){
    $configStr = wmic NICConfig where interfaceIndex=$index get $parameter
    $configStr = $configStr | Select-Object -Index 2
    $configStr = $configStr.Trim().TrimStart('{"').TrimEnd('"}')
    return $configStr
}

New-Alias -Name getnetconfig -Value Get-NetInterfaceConfig
Export-ModuleMember -Alias * -Function *