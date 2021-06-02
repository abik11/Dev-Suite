function Compare-Lists {
    [cmdletbinding(DefaultParameterSetName = 'string')]
    param(
        [Parameter(ParameterSetName = 'string', Position = 0)]
        [string] $listString1,
        [Parameter(ParameterSetName = 'string', Position = 1)]
        [string] $listString2,
        [Parameter(ParameterSetName = 'string', Position = 2)]
        [string] $separator = ';',
        [Parameter(ParameterSetName = 'list', Position = 0)]
        [string[]] $list1,
        [Parameter(ParameterSetName = 'list', Position = 1)]
        [string[]] $list2,
        [switch] $showCount
    )

    if ($PSCmdlet.ParameterSetName -eq 'string') {
        $list1 = $listString1 -split $separator | ForEach-Object { $_.Trim() }
        $list2 = $listString2 -split $separator | ForEach-Object { $_.Trim() }
    }
    
    $list1Count = $list1 | Measure-Object | Select-Object -ExpandProperty Count
    $list2Count = $list2 | Measure-Object | Select-Object -ExpandProperty Count
    
    if ($showCount) {
        Write-Host "List1 count: $list1Count"
        Write-Host "List2 count: $list2Count"
    }

    return @{
        Intersection = $list1 | Where-Object { $list2.Contains($_) };
        List1Only = $list1 | Where-Object { -not($list2.Contains($_)) };
        List2Only = $list2 | Where-Object { -not($list1.Contains($_)) }
    }
}
