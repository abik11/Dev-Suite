<#
    .SYNOPSIS
    Show-Notification
    .DESCRIPTION
    This function shows tray icon notification - a little popup
    with message in the bottom right corner of the screen. It uses
    NotifyIcon class (WinForms).
    .EXAMPLE
    Show-Notification 'Little message' 'Hello world! This is a message!'
    Show-Notification 'Little message' 'Hello world! This is a message!' Warning 10
    .NOTES
     author: Albert
#>
function Show-Notification {
    [cmdletbinding()]
    Param(
        [string] $title,
        [string] $message,
        [string] $type = 'Info',
        [int] $timeout = 5
    )

    Add-Type -AssemblyName System.Windows.Forms
    $notification = New-Object System.Windows.Forms.NotifyIcon

    Write-Verbose "Registering event handlers that will dipose NotifyIcon"
    $eventsTable = @{'BalloonTipClosed'='NotificationClosed'; 'BalloonTipClicked'='NotificationClicked'}
    Register-DisposeEventSubscriber $notification $eventsTable       

    Write-Verbose "Setting the icon as the Powershell's icon"
    $path = Get-Process -id $pid | Select-Object -ExpandProperty Path
    $icon = [System.Drawing.Icon]::ExtractAssociatedIcon($path)
    $notification.Icon = $icon

    Write-Verbose "Setting tool tip icon type"
    $iconType = switch ($type){
        'None'      { [System.Windows.Forms.ToolTipIcon]::None }
        'Info'      { [System.Windows.Forms.ToolTipIcon]::Info }
        'Warning'   { [System.Windows.Forms.ToolTipIcon]::Warning }
        'Error'     { [System.Windows.Forms.ToolTipIcon]::Error }
    }
    $notification.BalloonTipIcon =  $iconType 

    Write-Verbose "Setting message and title and showing notification"
    $notification.BalloonTipText = $message
    $notification.BalloonTipTitle = $title
    $notification.Visible = $true
    $notification.ShowBalloonTip($timeout * 1000)
}

function Register-DisposeEventSubscriber($object, $eventsTable){
    #This little function registers event subscribers for each event given in $eventsTable.
    #Each subscriber will unregister itself and other subscribers whic are registered with this function.
    #Moreover each subscriber will dispose the object (event source).
    #Such behaviour might be useful if you have to dispose an object in more than one event.
    #When you no longer need the object, you also no longer need event subscribers of that object.
    #So simply:
    #with this function you can register event handlers that will dispose the object and event handlers itself.

    $eventData = New-Object PSObject -Property `
        @{ EventsTable = $eventsTable; Object = $object }

    $eventsTable.GetEnumerator() | Foreach-Object {
        #Registering event subscribers for every event given in $eventsTable
        [void](Register-ObjectEvent -InputObject $object `
            -EventName $_.Key -SourceIdentifier $_.Value -MessageData $eventData `
            -Action {
                $event.MessageData.Object.Dispose()
                #Unregistering all the event subscribers
                $event.MessageData.EventsTable.Values | Foreach-Object {
                    Unregister-Event -SourceIdentifier $_
                    Remove-Job -Name $_
                }
            })
    }

    #In case of any problems with the subscribers use: Get-EventSubscriber.
    #If everything works correctly there should be no subscribers registered after any of the events will fire,
    #before - you should see one subscriber for each event defined in $eventsTable.
}

Export-ModuleMember -Function *