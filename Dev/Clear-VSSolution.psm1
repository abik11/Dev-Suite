<#
    .SYNOPSIS
    Clear-VSSolution
    .DESCRIPTION
    This function clears Visual Studio solution from packages, .vs and all 
    bin and obj directories from each project.
    .EXAMPLE
    clsvss .\MyTurboSolution\
    clsvss .
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
        dir bin, obj -Recurse | Remove-Item -Force -Recurse -ErrorAction SilentlyContinue
    }
    
    End {
        Set-Location $currentDir
    }
}

New-Alias -Name Clear-Solution -Value Clear-VSSolution
New-Alias -Name clsvss -Value Clear-VSSolution
Export-ModuleMember -Alias * -Function *