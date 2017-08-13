﻿#
# Module manifest for module 'ParameterSetRules'
#
# Generated by: Laurent Dardenne
#
# Generated on: 08/15/2016
#

@{

# Script module or binary module file associated with this manifest.
RootModule = 'ParameterSetRules.psm1'

# Version number of this module.
ModuleVersion = '1.0.0'

# ID used to uniquely identify this module
GUID = 'cd244970-87c5-4d02-84f3-d29666f8fea4'

# Author of this module
Author = 'Laurent Dardenne'

# Company or vendor of this module
CompanyName = ''

# Copyright statement for this module
Copyright = 'CopyLeft'

# Description of the functionality provided by this module
Description = 'This module contains script analyzer rules to control the param block of a function.'

# Minimum version of the Windows PowerShell engine required by this module
PowerShellVersion = '4.0'

# Name of the Windows PowerShell host required by this module
# PowerShellHostName = ''

# Minimum version of the Windows PowerShell host required by this module
# PowerShellHostVersion = ''

# Minimum version of Microsoft .NET Framework required by this module
# DotNetFrameworkVersion = ''

# Minimum version of the common language runtime (CLR) required by this module
CLRVersion = '4.0'

# Processor architecture (None, X86, Amd64) required by this module
# ProcessorArchitecture = ''

# Modules that must be imported into the global environment prior to importing this module
RequiredModules=@(
#<DEFINE %DEBUG%>
 @{ModuleName="Log4Posh"; GUID="f796dd07-541c-4ad8-bfac-a6f15c4b06a0"; ModuleVersion="2.2.0"}
#<UNDEF %DEBUG%> 
 @{ModuleName="PSScriptAnalyzer"; GUID='d6245802-193d-4068-a631-8863a4342a18'; ModuleVersion="1.8.0"}
)

# bug PSScriptAnalyzer : https://github.com/PowerShell/PSScriptAnalyzer/issues/599
#RequiredAssemblies = @('System.Data.Entity.Design','System.Globalization')

# Script files (.ps1) that are run in the caller's environment prior to importing this module.
# ScriptsToProcess = @()

# Type files (.ps1xml) to be loaded when importing this module
# TypesToProcess = @()

# Format files (.ps1xml) to be loaded when importing this module
# FormatsToProcess = @()

# Modules to import as nested modules of the module specified in RootModule/ModuleToProcess
# NestedModules = @()

# Functions to export from this module
FunctionsToExport = @(
 'Measure-DetectingErrorsInParameterList',
 'Measure-DetectingErrorsInDefaultParameterSetName'
 #todo Measure-DetectingErrorsInOutputAttribut
)

# Cmdlets to export from this module
#CmdletsToExport = '*'

# Variables to export from this module
#VariablesToExport = '*'

# Aliases to export from this module
#AliasesToExport = '*'

# List of all modules packaged with this module
# ModuleList = @()

# List of all files packaged with this module
# FileList = @()

# Private data to pass to the module specified in RootModule/ModuleToProcess. This may also contain a PSData hashtable with additional module metadata used by PowerShell.
PrivateData = @{

    PSData = @{
          # Tags applied to this module. These help with module discovery in online galleries.
         Tags = @('PSScriptAnalyzer','PSScriptAnalyzerRule', 'Analyze','Rule','ParameterSet' )

          # A URL to the license for this module.
         LicenseUri =  'https://creativecommons.org/licenses/by-nc-sa/4.0/'

          # A URL to the main website for this project.
         ProjectUri='https://github.com/LaurentDardenne/PSScriptAnalyzerRules'
          # A URL to an icon representing this module.
         IconUri='https://github.com/LaurentDardenne/ParameterSetRules/blob/master/icon/ParameterSetRules.png'

         # ReleaseNotes of this module
        # ReleaseNotes =
        
        ExternalModuleDependencies = @('PSScriptAnalyzer')
    } # End of PSData hashtable
} # End of PrivateData hashtable

# HelpInfo URI of this module
# HelpInfoURI = ''

# Default prefix for commands exported from this module. Override the default prefix using Import-Module -Prefix.
# DefaultCommandPrefix = ''

}

