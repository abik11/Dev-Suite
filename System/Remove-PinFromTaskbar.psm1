function Remove-PinFromTaskbar {
    [cmdletbinding()]
    Param(
        [Parameter(Mandatory = $true)]
        [string] $applicationName
    )

    $application = (New-Object -Com Shell.Application).`
        NameSpace('shell:::{4234d49b-0245-4df3-b780-3893943456e1}').`
        Items() | Where-Object { $_.Name -eq $applicationName }

    if($null -eq $application) {
        Write-Error "Couldn't find given application"
        return 0 | Out-Null
    }

    $unpinVerb = $application.Verbs() `
        | Where-Object { $_.Name.replace('&', '') -match 'Unpin from taskbar' }

    if($null -eq $unpinVerb) {
        Write-Error "Couldn't unpin given application (probably it is already unpinned)"
        return 0 | Out-Null
    }

    $unpinVerb.DoIt()
}

New-Alias -Name Unpin-App -Value Remove-PinFromTaskbar
New-Alias -Name unpin -Value Remove-PinFromTaskbar
Export-ModuleMember -Alias * -Function *
