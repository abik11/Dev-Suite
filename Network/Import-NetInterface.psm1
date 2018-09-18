<#
    .SYNOPSIS
    Import-NetInterface
    .DESCRIPTION
    This function imports NIC configuration (address, subnet mask etc.) from
    XML config file. You can generate such config with Export-NetInterface
    function. This function internally uses Set-NetInterface for configuring 
    the NIC settings.
    .EXAMPLE
    ipnic .\config.xml
    .NOTES
     author: Albert
#>
function Import-NetInterface {
    [cmdletbinding()]
    Param(
        [Alias('file')]
        [string] $importXMLFile
    )

    [xml] $settings = Get-Content $importXMLFile
    $config = $settings.SelectSingleNode('//config')

    if($config){
        Write-Verbose "Connecting to $($config.nictype) network"
        Connect-NetInterface $config.nicType

        if(-not($config.ip.static -eq 'true')){
            Write-Verbose "Configuring $($config.nictype) interface address statically"
            Set-NetInterface $config.nicType address `
                $config.ip.address $config.ip.subnetmask $config.ip.gateway
        }
        else{
            Write-Verbose "Configuring $($config.nictype) interface address to use dhcp"
            Set-NetInterface $config.nicType address auto
        }

        if(-not($config.dns.static -eq 'true')){
            Write-Verbose "Configuring $($config.nictype) interface dns statically"
            if($config.dns.secondary){
                Write-Verbose "Configuring primary and secondary dns"
                Set-NetInterface $config.nicType dns $config.dns.primary $config.dns.secondary
            }
            else {
                Write-Verbose "Configuring primary dns only"
                Set-NetInterface $config.nicType dns $config.dns.primary
            }
        }
        else{
            Write-Verbose "Configuring $($config.nictype) interface dns to use dhcp"
            Set-NetInterface $config.nicType dns auto
        }

        Write-Verbose "Printing $($config.nictype) interface final configuration"
        $index = Get-NetInterfaceIndex interface $config.nicType
        netsh interface ipv4 show config $index
    }
}

New-Alias -Name Import-NIC -Value Import-NetInterface
New-Alias -Name ipnic -Value Import-NetInterface
Export-ModuleMember -Alias * -Function *