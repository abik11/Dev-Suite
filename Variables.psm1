$cscPath = "C:\Windows\Microsoft.NET\Framework64\v4.0.30319"
$cscFullPath = "$cscPath\csc.exe"
$vsFullPath = "C:\Program Files (x86)\Microsoft Visual Studio\2017\Professional\Common7\IDE\devenv.exe"
Export-ModuleMember -variable cscPath, cscFullPath, vsFullPath

$defaultWidth = 140
$defaultHeight = 38
$defaultFgColor = 0x00464646
$defaultBgColor = 0x00F0EDEE
Export-ModuleMember -variable defaultWidth, defaultHeight, defaultFgColor, defaultBgColor

$defaultLanConnectionPhrase = 'lokalne'
$defaultWlanConnectionPhrase = 'bezprzewodowej'
Export-ModuleMember -variable defaultLanConnectionPhrase, defaultWlanConnectionPhrase