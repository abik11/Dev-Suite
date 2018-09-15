<#
    .SYNOPSIS
    Set-PSRegistryProperty
    .EXAMPLE
     Set-PSRegistryProperty ColorTable00 0x00F0EDEE
     Set-PSRegistryProperty ColorTable07 0x00464646
     Set-PSRegistryProperty QuickEdit 0x00000001
    .NOTES
     author: Albert
#>
function Set-PSRegistryProperty {
    [cmdletbinding()]
    Param(
        $propertyName,
        $value
    )

    Begin {
        $currentLocation = Get-Location
        $hkcuConsole = "HKCU:\Console"
        $powershellRegKeyName = "%SystemRoot%_system32_WindowsPowerShell_v1.0_powershell.exe"
        Set-Location $hkcuConsole
    }

    Process {
        $powershellRegKey = Get-ChildItem | Where-Object { $_.Name -like '*powershell*' }
        if(-not ($powershellRegKey)){
            Write-Verbose "Creating new registry key..."
            New-Item $powershellRegKeyName
        }
        Set-Location $powershellRegKeyName

        Set-RegProperty $propertyName $value
    }

    End {
        Set-Location $currentLocation
    }
}

function Set-RegProperty([string]$propertyName, [int]$value){
    Write-Verbose "Creating new property for registry..."
    $property = Get-ItemProperty . $propertyName -errorAction 'silentlyContinue'
    if(-not ($property)){
        New-ItemProperty . $propertyName -type DWORD -value $value
    }
    else {
        Set-ItemProperty . $propertyName $value
    }
}