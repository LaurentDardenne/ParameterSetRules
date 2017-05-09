Function TestOutputType{

 [CmdletBinding()]
 [OutputType([Microsoft.Windows.PowerShell.ScriptAnalyzer.Generic.DiagnosticRecord[]])]

 Param(
       [Parameter(Mandatory = $true)]
       [ValidateNotNullOrEmpty()]
       [System.Management.Automation.Language.FunctionDefinitionAst]
      $FunctionDefinitionAst
 )
 Write-host "Test"
 }
