Function TestParameterSet{
  Param (
    [Parameter()]
   [Switch] $Avariable,
   
    [Parameter(Mandatory)]
   [Switch] $Bvariable,
   
    [Parameter(Position=1)]
   [Switch] $Cvariable,
   
    $Dvariable
   )
  Write-Verbose "Traitement..."
}