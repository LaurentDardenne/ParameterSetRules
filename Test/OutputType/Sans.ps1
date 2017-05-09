Function TestOutputType{

 [CmdletBinding()]

 Param(
       [Parameter(Mandatory = $true)]
       [ValidateNotNullOrEmpty()]
       [System.Management.Automation.Language.FunctionDefinitionAst]
      $FunctionDefinitionAst
 )
 Write-host "Test"
 }
