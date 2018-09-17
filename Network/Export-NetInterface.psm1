<#
    .SYNOPSIS
    Export-NetInterface
    .DESCRIPTION
    This function ...
    .EXAMPLE
    exnic
    .NOTES
     author: Albert
#>
function Export-NetInterface {
    [cmdletbinding()]
    Param(
        [Alias('file')]
        [string] $exportXMLFile
    )
    
    #TODO
}

New-Alias -Name Export-NIC -Value Export-NetInterface
New-Alias -Name exnic -Value Export-NetInterface
Export-ModuleMember -Alias * -Function *