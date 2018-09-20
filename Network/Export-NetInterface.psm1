<#
    .SYNOPSIS
    Export-NetInterface
    .DESCRIPTION
    This function exports NIC configuration (address, subnet mask etc.) to
    XML config file. You can import such config file with Import-NetInterface
    function to automatically set NIC.
    .EXAMPLE
    exnic .\config.xml
    exnic .\wlan.xml wlan
    .NOTES
     author: Albert
#>
function Export-NetInterface {
    [cmdletbinding()]
    Param(
        [Alias('file')]
        [string] $exportXMLFile,
        [Alias('type')]
        [string] $networkType = 'LAN'
    )
    
    $index = Get-NetInterfaceIndex interface $networkType
    Write-Verbose "Getting settings of network interface of index: $index"
    $netconfig = Get-NetInterfaceConfig $index

    $ipstatic = $false

    [xml] $doc = New-Object System.Xml.XmlDocument
    $declaration = $doc.CreateXmlDeclaration('1.0', 'UTF-8', $null)
    $doc.AppendChild($declaration)

    $configurations = $doc.CreateElement('configurations')
    $config = $doc.CreateElement('config')
    $config.SetAttribute('nictype', '')

    $ip = $doc.CreateElement('ip')
    $ip.SetAttribute('static', @{$true = 'true'; $false = 'false'}[$ipstatic])
    if($ipstatic){
        $address = $doc.CreateElement('address')
        $address.InnerText = ''
        $subnetmask = $doc.CreateElement('subnetmask')
        $subnetmask.InnerText = ''
        $gateway = $doc.CreateElement('gateway')
        $gateway.InnerText = ''
        $ip.AppendChild($address)        
        $ip.AppendChild($subnetmask)        
        $ip.AppendChild($gateway)        
    }
    $config.AppendChild($ip)

    $dnsstatic = $false

    $dns = $doc.CreateElement('dns')
    $dns.SetAttribute('static', @{$true = 'true'; $false = 'false'}[$dnsstatic])
    if($dnsstatic){
        $primary = $doc.CreateElement('primary')
        $primary.InnerText = ''
        $secondary = $doc.CreateElement('secondary')
        $secondary.InnerText = ''
    }
    $config.AppendChild($dns)

    $configurations.AppendChild($config)
    $doc.AppendChild($configurations)
    $doc.Save($exportXMLFile)
}

New-Alias -Name Export-NIC -Value Export-NetInterface
New-Alias -Name exnic -Value Export-NetInterface
Export-ModuleMember -Alias * -Function *