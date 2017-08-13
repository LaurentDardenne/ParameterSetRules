Function TestParameterSet{
  [CmdletBinding()]
  Param (
    [Parameter(ParameterSetName="Name1")]
   [Switch] $Variable
   )
 Write-Verbose "Traitement..."
}
