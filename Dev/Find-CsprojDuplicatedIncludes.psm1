<#
    .SYNOPSIS
    Find-CsprojDuplicatedIncludes
    .DESCRIPTION
    This function finds all duplicated content include markups in .csproj file.
    It might be useful after merging two branches in TFS or other source control
    system. If you merge without caution it might cause some mess in your .csproj
    file.
    .EXAMPLE
    finddup .\tfs\EnterpriseProj\EnterpriseProj.Web\EnterpriseProj.Web.csproj
    .NOTES
     author: Albert
#>
function Find-CsprojDuplicatedIncludes {
    [cmdletbinding()]
    Param(
        [Alias('FilePath', 'Path')]
        [string] $csprojFilePath = $vsFullPath
    )
 
    $duplicateHash = @{}
    Get-content $csprojFilePath | `
        Where-Object { $_ -match "<Content Include=`".*`"( /)?>" } | `
        ForEach-Object {
            $_ = $_.Trim()
            if($duplicateHash[$_]) {
                $duplicateHash[$_] = $duplicateHash[$_] + 1
            }
            else {
                $duplicateHash[$_] = 1
            }
        }
   
    $duplicateHash.GetEnumerator() | `
        Where-Object { $_.Value -gt 1 } | `
        ForEach-Object { $_.Name }
}
 
New-Alias -Name Find-CsprojDup -Value Find-CsprojDuplicatedIncludes
New-Alias -Name finddup -Value Find-CsprojDuplicatedIncludes
Export-ModuleMember -Alias * -Function Find-CsprojDuplicatedIncludes
