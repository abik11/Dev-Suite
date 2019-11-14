<#
    .SYNOPSIS
    Copy-ChangedFilesFromGit
    .DESCRIPTION
    This function uses git (git status --porcelain) to get list of files
    modified in local git repository and copies those files into a separate
    directory to serve as a backup of your changes. It also saves full paths
    of all coppied files in index.txt (as default), toegether with the
    backup.
    .PARAMETER repo
    Path to git project repository from which you want to copy files
    .EXAMPLE
    copygit c:\git\myproj
    .NOTES
     author: Albert
#>
function Copy-ChangedFilesFromGit {
    [cmdletbinding()]
    param(
        [string] $repo,
        [string] $output = "$home\Desktop\changes-backup\",
        [string] $index = "$output\index.txt"
    )
 
    if(Test-Path $output){
        Write-Verbose "Renaming previous backup"
        Rename-Item $output ($output + "_" + (Get-Date -format "ddhhmmss"))
    }
 
    Write-Verbose "Creating output directory"
    New-Item -Path $output -ItemType Directory
 
    $gitOutput = git --git-dir="$repo\.git" status --porcelain
    $files = $gitOutput -replace "/","\" -split "`n"
    $files | ForEach-Object {
        if($_[1] -ne 'D'){
            $file = Get-ChildItem "$repo\*$($_.Substring(3))" | Select-Object -ExpandProperty FullName
            Write-Verbose "Copying: $file to: $output"
            Copy-Item $file -Destination $output
            Out-File -File $index -InputObject $file -Append      
        }
    }
}
 
New-Alias -Name copygit -Value Copy-ChangedFilesFromGit
New-Alias -Name copychanges -Value Copy-ChangedFilesFromGit
New-Alias -Name cpgit -Value Copy-ChangedFilesFromGit
New-Alias -Name cpchanges -Value Copy-ChangedFilesFromGit
Export-ModuleMember -Alias * -Function *
