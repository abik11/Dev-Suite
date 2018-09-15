<#
    .SYNOPSIS
    Set-PSConsoleSize
    .DESCRIPTION
    This function changes the WindowSize and BufferSize properties of RawUI object.
    It allows to control the size of Powershell console window to fit your needs.
    .EXAMPLE
     setsize 140 54
     set-consoleSize -w 140 -h 54
    .NOTES
     author: Albert
#>
function Set-PSConsoleSize {
    [cmdletbinding()]
    Param(
        [Parameter(Position=0)]
        [int]$Width = $defaultWidth,
        [Parameter(Position=1)]
        [int]$Height = $defaultHeight
    )

    if($width -gt 10 -and $height -gt 10){
        $windowSize = $Host.UI.RawUI.WindowSize
        $windowSize.Width = $Width
        $windowSize.Height = $Height 

        $bufferSize = $Host.UI.RawUI.WindowSize
        $bufferSize.Width = $Width
        $bufferSize.Height = 1024

        $Host.UI.RawUI.BufferSize = $bufferSize
        $Host.UI.RawUI.WindowSize = $windowSize
    }
}

New-Alias -Name Set-ConsoleSize -Value Set-PSConsoleSize
New-Alias -Name setsize -Value Set-PSConsoleSize
Export-ModuleMember -Alias * -Function *