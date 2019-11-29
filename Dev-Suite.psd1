#
# Module manifest for module 'Dev-Suite'
#
# Generated by: a.kozak
#
# Generated on: 2018-06-27
#

@{

# Script module or binary module file associated with this manifest.
# RootModule = ''

# Version number of this module.
ModuleVersion = '1.0'

# ID used to uniquely identify this module
GUID = '065a25e4-39e9-433a-9e32-17514359beb4'

# Author of this module
Author = 'Albert Kozak'

# Company or vendor of this module
# CompanyName = 'Unknown'

# Copyright statement for this module
Copyright = '(c) 2018 Albert Kozak. All rights reserved.'

# Description of the functionality provided by this module
Description = 'This module contains a bunch of functions that try to automize developers repetitive work.'

# Minimum version of the Windows PowerShell engine required by this module
PowerShellVersion = '5.0.10586.117'

# Name of the Windows PowerShell host required by this module
# PowerShellHostName = ''

# Minimum version of the Windows PowerShell host required by this module
# PowerShellHostVersion = ''

# Minimum version of Microsoft .NET Framework required by this module
# DotNetFrameworkVersion = ''

# Minimum version of the common language runtime (CLR) required by this module
CLRVersion = '4.0.30319.42000'

# Processor architecture (None, X86, Amd64) required by this module
# ProcessorArchitecture = ''

# Modules that must be imported into the global environment prior to importing this module
# RequiredModules = @()

# Assemblies that must be loaded prior to importing this module
# RequiredAssemblies = @()

# Script files (.ps1) that are run in the caller's environment prior to importing this module.
# ScriptsToProcess = @()

# Type files (.ps1xml) to be loaded when importing this module
# TypesToProcess = @()

# Format files (.ps1xml) to be loaded when importing this module
# FormatsToProcess = @()

# Modules to import as nested modules of the module specified in RootModule/ModuleToProcess
NestedModules = @('.\Variables.psm1',
                '.\DateFunctions.psm1',
                '.\Console\Set-PSConsoleSize.psm1',
                '.\Console\Set-PSConsoleRegistry.psm1',
                '.\Console\Set-PSRegistryProperty.psm1',
                '.\Dev\Stop-VisualStudio.psm1',
                '.\Dev\Clear-VSSolution.psm1',
                '.\Dev\Get-IISSites.psm1',
                '.\Dev\Invoke-CSC.psm1',
                '.\Dev\Merge-NLogs.psm1',
                '.\System\Show-Notification.psm1',
                '.\Network\Get-NetInterfaceIndex.psm1',
                '.\Network\Get-NetInterfaceConfig.psm1',
                '.\Network\Connect-NetInterface.psm1',
                '.\Network\Set-NetInterface.psm1',
                '.\Network\Import-NetInterface.psm1',
                '.\Network\Export-NetInterface.psm1')

# Functions to export from this module
FunctionsToExport = '*'

# Cmdlets to export from this module
CmdletsToExport = '*'

# Variables to export from this module
VariablesToExport = '*'

# Aliases to export from this module
AliasesToExport = '*'

# DSC resources to export from this module
# DscResourcesToExport = @()

# List of all modules packaged with this module
# ModuleList = @()

# List of all files packaged with this module
# FileList = @()

# Private data to pass to the module specified in RootModule/ModuleToProcess. This may also contain a PSData hashtable with additional module metadata used by PowerShell.
PrivateData = @{

    PSData = @{

        # Tags applied to this module. These help with module discovery in online galleries.
        # Tags = @()

        # A URL to the license for this module.
        # LicenseUri = ''

        # A URL to the main website for this project.
        # ProjectUri = ''

        # A URL to an icon representing this module.
        # IconUri = ''

        # ReleaseNotes of this module
        # ReleaseNotes = ''

    } # End of PSData hashtable

} # End of PrivateData hashtable

# HelpInfo URI of this module
HelpInfoURI = 'https://github.com/abik11/tips-tricks/blob/master/Powershell.md'

# Default prefix for commands exported from this module. Override the default prefix using Import-Module -Prefix.
# DefaultCommandPrefix = ''

}