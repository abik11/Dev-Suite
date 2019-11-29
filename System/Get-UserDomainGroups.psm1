 <#
    .SYNOPSIS
    Get-UserGroups
    .DESCRIPTION
    This function returns the groups to which given user belings in the
    given domain.
    .EXAMPLE
    Get-UserDomainGroups j.smith
    Get-UserDomainGroups j.smith corp
    .PARAMETER user
    User name, for which you will try to find groups
    .PARAMETER domain
    Domain name, where you will try to find user's groups
    .NOTES
     author: Albert
#>
function Get-UserDomainGroups {
    [cmdletbinding()]
    Param(
        [String] $user,
        [String] $domain = 'corp'
    )

     Add-Type -AssemblyName System.DirectoryServices.AccountManagement
     Add-Type -AssemblyName System.DirectoryServices

     $vdomain = [System.DirectoryServices.AccountManagement.ContextType]::Domain
     $vsam = [System.DirectoryServices.AccountManagement.IdentityType]::SamAccountName

     $context = New-Object -TypeName System.DirectoryServices.AccountManagement.PrincipalContext $vdomain, $domain
     $userPrincipal = [System.DirectoryServices.AccountManagement.UserPrincipal]::FindByIdentity($context, $vsam, $user)
     $userPrincipal.GetGroups() | select SamAccountName, name | ft -a
}

Export-ModuleMember -Alias * -Function *