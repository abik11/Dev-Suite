function Test-Admin {
    $winPrincipal = [Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()
    return $winPrincipal.IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)
}