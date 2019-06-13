<#
    .SYNOPSIS
    Watch-Process
    .DESCRIPTION
    This function ...
    .EXAMPLE
    wproc Calculator
    .NOTES
     author: Albert
#>
function Watch-Process {
    [cmdletbinding()]
    Param(
        [string] $procName,
        [int] $waitSeconds = 1
    )
    
    if(-not(Get-Process $procName -ErrorAction SilentlyContinue)){
        Write-Host "No process"
        return $false
    }
 
    $procPath = Get-Process $procName | Select-Object -First 1 -ExpandProperty Path
 
    do {
        $proc = Get-Process $procName  | Select-Object -First 1
        Write-Host "Process ID ($procName): $($proc.Id)"
        $proc.WaitForExit()
        Start-Sleep -S $waitSeconds
        & $procPath
    }
    while ($true)
}

New-Alias -Name watchproc -Value Watch-Process
New-Alias -Name wproc -Value Watch-Process
Export-ModuleMember -Alias * -Function *
