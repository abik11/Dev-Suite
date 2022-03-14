function Measure-AverageQueryTime {
    [cmdletbinding()]
    param(
        [Parameter(Position = 0)]
        [int]$executionsCount,
        [Parameter(Position = 1)]
        [string]$query,
        [Parameter(Position = 2)]
        [string]$database,
        [Parameter(ParameterSetName = 'remote', Position = 3)]
        [string]$server,
        [Parameter(ParameterSetName = 'remote', Position = 4)]
        [string]$username,
        [Parameter(ParameterSetName = 'remote', Position = 5)]
        [string]$password
    )

    $measurements = New-Object System.Collections.Generic.List[System.Object]

    for ($i = 0; $i -lt $executionsCount; $i = $i + 1) {
        if ($PSCmdlet.ParameterSetName -eq 'remote') {
            $measurement = Measure-Query $query $database $server $username $password
        }
        else {
            $measurement = Measure-Query $query $database
        }

        $measurements.Add($measurement)
    }

    $cpuTime = $measurements | Measure-Object -Average -Maximum -Minimum -Property CPUTime
    $elapsedTime = $measurements | Measure-Object -Average -Maximum -Minimum -Property ElapsedTime
    
    return @($cpuTime, $elapsedTime)
}

New-Alias -Name queryavg -Value Measure-AverageQueryTime
New-Alias -Name qavg -Value Measure-AverageQueryTime
Export-ModuleMember -Alias * -Function *
