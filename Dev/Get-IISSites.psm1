<#
    .SYNOPSIS
    Get-IISSites
    .DESCRIPTION
    This function lists the IIS sites. It can be run remotely (as default) or on local machine if 
    it has IIS installed. It is recommended to give admin credentials to be sure that the function 
    has access to C:\Windows\System32\inetsrv\appcmd.exe if you run it remotely.
    .EXAMPLE
    gsites sepmsrv193
    gsites -l
    .PARAMETER serverName
    The name of the server from which IIS sites will be listed
    .NOTES
    author: Albert
#>
function Get-IISSites {
  [cmdletbinding(DefaultParameterSetName='remote')]
  Param(
    [Parameter(ParameterSetName='remote')]
    [Alias('srv')]
    [String] $serverName,
    [Parameter(ParameterSetName='local')]
    [Alias('local')]
    [switch] $runLocal

  )

  $command = { & 'C:\Windows\System32\inetsrv\appcmd.exe' list site }

  if($runLocal){
    $command.Invoke()
  }
  else {
    $credential = Get-Credential -Message "Give me the credentials for the admin for $serverName"
    $session = New-PSSession -ComputerName $serverName -Credential $credential    
    Invoke-Command -Session $session -Command $command
  }
}

New-Alias -Name Get-Sites -Value Get-IISSites
New-Alias -Name gsites -Value Get-IISSites
Export-ModuleMember -Alias * -Function *