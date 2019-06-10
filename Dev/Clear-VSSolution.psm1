<#
    .SYNOPSIS
    Clear-VSSolution
    .DESCRIPTION
    This function removes packages and .vs directories from given Visual Studio
    solution and removes bin and obj directories from projects inside of the
    solution.
    .EXAMPLE
    clsvss .\MyTurboSolution\
    clsvss .
    
    To clear all solutions in a directory:
    ls | % { Clear-VSSolution $_ }
    .NOTES
     author: Albert
#>
function Clear-VSSolution {
    [cmdletbinding()]
    Param (
        [string] $solutionDirectory
    )

    Begin {
        $currentDir = Get-Location
    }

    Process {
        Set-Location $solutionDirectory
        Remove-Item packages, .vs -Force -Recurse -ErrorAction SilentlyContinue
        Get-ChildItem bin, obj -Recurse | 
            Remove-Item -Force -Recurse -ErrorAction SilentlyContinue
    }
    
    End {
        Set-Location $currentDir
    }
}

New-Alias -Name Clear-Solution -Value Clear-VSSolution
New-Alias -Name clsvss -Value Clear-VSSolution
New-Alias -Name clsvs -Value Clear-VSSolution
Export-ModuleMember -Alias * -Function *
