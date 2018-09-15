<#
    .SYNOPSIS
    Invoke-CSC
    .EXAMPLE
     runcsc
     runcsc threading.cs
     runcsc adProgram.cs -r System.DirectoryServices.dll, System.DirectoryServices.AccountManagement.dll
    .NOTES
     author: Albert
#>
function Invoke-CSC {
    [cmdletbinding()]
    Param(
        [string]$in = "program.cs",
        [string]$out = "program.exe",
        [string]$target = "exe",
        [string]$csc = $cscFullPath,
        [string[]]$references
    )

    if($references.Length -gt 0){
        $refs = ($references -join ",")
        & "$csc" /r:$refs /out:$out /target:$target $in
    }

    else{
        & "$csc" /out:$out /target:$target $in
    }
}

New-Alias -Name Run-CSC -Value Invoke-CSC
New-Alias -Name runcsc -Value Invoke-CSC
Export-ModuleMember -Alias * -Function *