function Measure-Query {
    [cmdletbinding()]
    param(
        [Parameter(Position = 0)]
        [string]$query,
        [Parameter(Position = 1)]
        [string]$database,
        [Parameter(ParameterSetName = 'remote', Position = 2)]
        [string]$server,
        [Parameter(ParameterSetName = 'remote', Position = 3)]
        [string]$username,
        [Parameter(ParameterSetName = 'remote', Position = 4)]
        [string]$password
    )
    
    $queryWithStats = "SET STATISTICS TIME ON;`r`n" + $query

    if ($PSCmdlet.ParameterSetName -eq 'remote') {
        $result = (Invoke-Sqlcmd -Query $queryWithStats -Database $database -Verbose `
                -ServerInstance $server -Username $username -Password $password -EncryptConnection) 4>&1
    }
    else {
        $result = (Invoke-Sqlcmd -Query $queryWithStats -Database $database -Verbose) 4>&1
    }
    
    $timesResult = $result | Where-Object { $_ -match 'time' }
    [regex]$regex = "\d+"
    $matched = $regex.Matches($timesResult)
    
    return New-Object -TypeName psobject -Property @{
        CPUTime     = [int]$matched[0].Value;
        ElapsedTime = [int]$matched[1].Value
    }
}

Export-ModuleMember -Alias * -Function *
