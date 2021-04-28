function Get-DotNet45Version {
  #https://docs.microsoft.com/en-us/dotnet/framework/migration-guide/how-to-determine-which-versions-are-installed
  return (Get-ItemProperty "HKLM:\SOFTWARE\Microsoft\NET Framework Setup\NDP\v4\Full").Version
}

New-Alias -Name dotNetVer -Value Get-DotNet45Version
Export-ModuleMember -Alias * -Function *
