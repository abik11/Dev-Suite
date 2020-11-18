function Enable-Device {
    [cmdletbinding()]
    Param(
        [string] $deviceName
    )
    $script = [scriptblock]::Create( `
        "Get-PnpDevice -FriendlyName '$deviceName' ``
        | Enable-PnpDevice -Confirm:`$false")
    Invoke-AsAdmin $script
}
Export-ModuleMember -Alias * -Function *