function Test-Admin {
    $user = [Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()
    return $user.IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)
    #return $host.UI.RawUI.WindowTitle.Contains("Administrator")
}
