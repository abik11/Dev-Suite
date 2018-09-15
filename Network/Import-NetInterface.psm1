<#
    .SYNOPSIS
    Import-NetInterface
    .DESCRIPTION
    This function ...
    .EXAMPLE
    exnic
    .NOTES
     author: Albert
#>
function Import-NetInterface {
    [cmdletbinding()]
    Param(
    )
    #todo
}

New-Alias -Name Import-NIC -Value Import-NetInterface
New-Alias -Name ipnic -Value Import-NetInterface
Export-ModuleMember -Alias * -Function *