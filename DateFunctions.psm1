function Get-LastDayOfMonth {
    [cmdletbinding()]
    param (
        [int] $month = (Get-Date -Format 'MM'),
        [int] $year = (Get-Date -Format 'yyyy')
    )
 
    return (Get-Date -Year $year -Month $month -Day 1).AddMonths(1).AddDays(-1).ToString('dd')
}
 
function Test-WeekendDay {
    [cmdletbinding()]
    param(
        [Parameter(ValueFromPipeline=$true)]
        [DateTime] $datetime
    )

    return $datetime.DayOfWeek.ToString().StartsWith('S')
}
 
function Get-MonthWorkingHours {
    [cmdletbinding()]
    param (
        [int] $month = (Get-Date -Format 'MM'),
        [int] $year = (Get-Date -Format 'yyyy')
    )
 
    $workingDays = 0
    
    1..(Get-LastDayOfMonth $month $year) | ForEach-Object {
        if(!(Get-Date -Day $_ -Month $month -Year $year | Test-WeekendDay)){
            $workingDays = $workingDays + 1
        }
    }
 
    return $workingDays * 8
}

Export-ModuleMember -Alias * -Function *