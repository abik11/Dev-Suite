function ConvertTo-ExcelReadableCSV([string] $csvFile, $delimeter = ";"){
    $csvContent = (Get-Content $csvFile) -replace $delimeter, "`t"
    $csvContent > $csvFile
 }

New-Alias -Name 2excel -Value ConvertTo-ExcelReadableCSV
Export-ModuleMember -Alias * -Function *
