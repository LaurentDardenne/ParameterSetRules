Function TestParameterSet{
 [CmdletBinding(DefaultParameterSetName = "Name2")]
  Param (
    [Parameter(ParameterSetName="Name1")]
    [Switch] $Variable
  )
 Write-Verbose "Traitement..."
}

