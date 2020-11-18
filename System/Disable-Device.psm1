function Disable-Device {
    [cmdletbinding()]
    Param(
        [string] $deviceName
    )
    $script = [scriptblock]::Create( `
        "Get-PnpDevice -FriendlyName '$deviceName' ``
        | Disable-PnpDevice -Confirm:`$false")
    Invoke-AsAdmin $script
}
Export-ModuleMember -Alias * -Function *