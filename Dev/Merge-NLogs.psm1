<#
    .SYNOPSIS
    Merge-NLogs
    .DESCRIPTION
    This function merges all the logs from txt log files gathered in one
    directory. It is supposed to work with NLog, but if the logs are in the
    right format, it doesn't really matter how they are generated. The default
    separator is |, and the format of the logs should be like this:

        Name|Date|Log Type|Caller Function/Method|Message

    Which in NLog.config can correspond to log layout like this:

        APP LOGIC Module|${longdate}|${level}|${callsite}|${message}

    It is a really nice idea to pipe the result of this function to Out-GridView
    cmdlet, being able to visualy analyze the logs, filter and sortem them.
    Keep in mind that this function is very simple (not intelligent) and it 
    will not work with different format - only separator can be changed.
    Probably it will be improved in the future.
    .EXAMPLE
    Merge-NLogs .\logs
    Merge-NLogs .\logs | Out-GridView
    .NOTES
     author: Albert
#>
function Merge-NLogs {
    [cmdletbinding()]
    Param(
        $directory,
        [string] $delimeter = '\|'
    )

    $logs = Get-ChildItem $directory *.txt | ForEach-Object {
        $file = Get-Content $_
        $file | ForEach-Object {
            $log = $_ -split $delimeter
            [PSCustomObject]@{ 
                Module=$log[0]; 
                Date=$log[1];
                Type=$log[2];
                Caller=$log[3];
                Other=$log[4];
            }
        }
    }

    $logs | Sort-Object -Property Date
}

Export-ModuleMember -Function *