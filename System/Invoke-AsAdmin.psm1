function Invoke-AsAdmin {
    [cmdletbinding()]
    Param(
        [Parameter(Mandatory=$true)]
        [ScriptBlock] $scriptBlock,
        [Alias('autoCorrect')]
        [switch] $replaceQuotes
    )
    if(Test-Admin){
        $scriptBlock.Invoke()
    }
    else {        
        $scriptText = $scriptBlock.ToString()
        if($scriptText.Contains("`"")){
            if($replaceQuotes){
                Write-Warning "Replacing all `" with '"
                $scriptText = $scriptText -replace "`"", "'"
            }
            else {
                Write-Error "It is not allowed to use `" in your script block"
                return
            }
        }
        Write-Warning "You are not Administrator, so separate elevated PowerShell window has started to run the command, it will close automatically."
        Start-Process powershell -Verb runas -ArgumentList "-NoProfile -Command $scriptText"
    }
}
New-Alias -Name runadmin -Value Invoke-AsAdmin
New-Alias -Name radm -Value Invoke-AsAdmin
Export-ModuleMember -Alias * -Function *