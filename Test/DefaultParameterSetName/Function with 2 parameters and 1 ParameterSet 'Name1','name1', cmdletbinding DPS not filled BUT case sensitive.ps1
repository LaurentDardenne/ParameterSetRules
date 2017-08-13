Function TestParameterSet{
  [CmdletBinding()]
  Param (
    [Parameter(ParameterSetName="Name1")]
   [Switch] $Variable,
   
    [Parameter(ParameterSetName="name1")]
   [Switch] $Switch
   )
  
  Write-Host "Traitement..."
}