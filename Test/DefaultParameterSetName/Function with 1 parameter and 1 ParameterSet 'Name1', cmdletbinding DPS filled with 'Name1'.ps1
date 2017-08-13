Function TestParameterSet{
 [CmdletBinding(DefaultParameterSetName = "Name1")]
  Param (
    [Parameter(ParameterSetName="Name1")]
    [Switch] $Variable
  )
 Write-Verbose "Traitement..."

}
