<#
    .SYNOPSIS
    Stop-VisualStudio
    .DESCRIPTION
    This function is stopping Visual Studio process in case it will crash. Also using
    the switch (-cordova), it will kill some other processes that could be spawn by 
    Visual Studio while working with the Cordova Framework. You can also automatically
    restart Visual Studio using the -reload switch.
    .EXAMPLE
    killvs
    kvs -c
    .NOTES
     author: Albert
#>
function Stop-VisualStudio {
    [cmdletbinding()]
    Param(
        [Alias('android')]
        [Switch] $cordova,
        [Switch] $reloadVS,
        [string] $visualStudioPath = $vsFullPath
    )

    Stop-Process "devenv" -ErrorAction SilentlyContinue
    
    if($cordova){
        #Stop-Process "conhost" -ErrorAction SilentlyContinue
        Stop-Process "java" -ErrorAction SilentlyContinue
        Stop-Process "Node" -ErrorAction SilentlyContinue
    }

    if($reloadVS){
        Start-Sleep -s 1
        Start-Process $visualStudioPath
    }
}

New-Alias -Name Kill-VisualStudio -Value Stop-VisualStudio
New-Alias -Name killvs -Value Stop-VisualStudio
New-Alias -Name kvs -Value Stop-VisualStudio
Export-ModuleMember -Alias * -Function Stop-VisualStudio
