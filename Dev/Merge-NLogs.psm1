<#
    .SYNOPSIS
    Merge-NLogs
    .DESCRIPTION
    This function merges all the logs from txt log files gathered in one
    directory. It is supposed to work with NLog, but if the logs are in the
    right format, it doesn't really matter how they are generated. The default
    separators are | and space, and the format of the logs can be one of these:

        Name|Date|Log_Type|Caller_Function/Method|Machine|Message
        Name Date Log_Type Caller_Function/Method Machine Message

    Which in NLog.config can correspond to log layout like this:

        APP_Logic_Module|${longdate}|${level}|${callsite}|${machinename}|${message}
        APP_Logic_Module ${longdate} ${level} ${callsite} ${machinename} ${message}

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
        [string] $delimeter = '\||\ '
    )

    $logs = Get-ChildItem $directory *.txt | ForEach-Object {
        $fileName = $_.FullName
        $file = Get-Content $fileName
        
        $file | ForEach-Object {
            $log = $_ -split $delimeter
            [PSCustomObject]@{ 
                Module=$log[0]; 
                Date=$log[1,2] -join ' ';
                Type=$log[3];
                Caller=$log[4];
                Machine=$log[5];
                Message=$log[6..($log.Length-1)] -join ' ';
                File=$fileName
            }
        }
    }

    $logs | Sort-Object -Property Date
}

Export-ModuleMember -Function *