Function TestParameterSet{
  [CmdletBinding(DefaultParameterSetName = "Name1")]
  Param (
    [Switch] $Variable
  )
  
  Write-Verbose "Traitement..."
}
