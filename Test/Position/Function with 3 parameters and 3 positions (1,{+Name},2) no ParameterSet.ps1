Function TestParameterSet{
  Param (
    [Parameter(Position=1)]
   [string] $Avariable,
   [string] ${+Name},
    [Parameter(Position=2)]
   [string] $Cvariable
   )
  Write-Verbose "Test"
}
