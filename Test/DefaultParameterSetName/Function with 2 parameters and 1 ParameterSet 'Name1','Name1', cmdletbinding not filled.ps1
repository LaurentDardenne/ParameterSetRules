Function TestParameterSet{
  [CmdletBinding()]
  Param (
   [Parameter(ParameterSetName="Name1")]
   [Switch] $Variable,

   [Parameter(ParameterSetName="Name1")]
   [Switch] $Switch
  )
  Write-Verbose "Traitement..."
}
