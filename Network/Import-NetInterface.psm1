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

    [xml] $settings = Get-Content
    $config = $settings.SelectSingleNode('//config')

    if($config){
        if(-not($config.ip.static -eq 'true')){
            Set-NetInterface $config.nicType address `
                $config.ip.address $config.ip.subnetmask $config.ip.gateway
        }
        else{
            Set-NetInterface $config.nicType address auto
        }

        if(-not($config.dns.static -eq 'true')){
            Set-NetInterface $config.nicType dns `
                $config.dns.primary $config.dns.secondary
        }
        else{
            Set-NetInterface $config.nicType dns auto
        }        
    }
}

New-Alias -Name Import-NIC -Value Import-NetInterface
New-Alias -Name ipnic -Value Import-NetInterface
Export-ModuleMember -Alias * -Function *