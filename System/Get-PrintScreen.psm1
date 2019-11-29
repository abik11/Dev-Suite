 <#
    .SYNOPSIS
    Get-PrintScreen
    .EXAMPLE
    Get-PrintScreen 1600 900 C:\img.png
    .NOTES
     author: Albert
#>
function Get-PrintScreen {
    [cmdletbinding()]
    Param(
        [int] $width,
        [int] $height,
        [string] $path = 'C:\Temp\screenshot.png'
    )

    [Reflection.Assembly]::LoadWithPartialName("System.Drawing") | Out-Null
    $bounds = New-Object -TypeName System.Drawing.Rectangle
    $bounds.Width = $width
    $bounds.Height = $height

    $bmp = New-Object Drawing.Bitmap $bounds.width, $bounds.height
    $graphics = [System.Drawing.Graphics]::FromImage($bmp)
    $graphics.CopyFromScreen($bounds.Location, [System.Drawing.Point]::Empty, $bounds.size)

    [System.IO.Directory]::SetCurrentDirectory((Get-Location).ProviderPath)
    $bmp.Save($path)
    $graphics.Dispose()
    $bmp.Dispose()
}

Export-ModuleMember -Alias * -Function *
