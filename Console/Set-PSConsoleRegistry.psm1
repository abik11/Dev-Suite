<#
    .SYNOPSIS
    Set-PSConsoleRegistry
    .DESCRIPTION
    This function changes the background and foreground colors of Windows Powershell
    console by setting some Windows Registry keys. It also turns on Quick Edit mode. 
    It should be run once actually because the changes in Windows Registry are persistent,
    so you don't have to change them every time when you run the Powershell.
    .EXAMPLE
     setonce
    .NOTES
     author: Albert
#>
function Set-PSConsoleRegistry {
    [cmdletbinding()]
    Param(
        [Parameter(Position=0)]
        [int]$fgColor = $defaultFgColor,
        [Parameter(Position=1)]
        [int]$bgColor = $defaultBgColor,
        [Parameter(Position=2)]
        [int]$quickEdit = 1
    )

     Set-PSRegistryProperty ColorTable00 $defaultBgColor
     Set-PSRegistryProperty ColorTable07 $defaultFgColor
     Set-PSRegistryProperty QuickEdit $quickEdit
}

New-Alias -Name Set-Console -Value Set-PSConsoleRegistry
New-Alias -Name setconsole -Value Set-PSConsoleRegistry
New-Alias -Name setonce -Value Set-PSConsoleRegistry
Export-ModuleMember -Alias * -Function *