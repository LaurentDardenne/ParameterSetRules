Function TestParameterSet{
 [CmdletBinding(DefaultParameterSetName = "name1")]
 Param (
  [Parameter(ParameterSetName="Name1")]
  [Switch] $Variable
 )
 Write-Verbose "Traitement..."
}
