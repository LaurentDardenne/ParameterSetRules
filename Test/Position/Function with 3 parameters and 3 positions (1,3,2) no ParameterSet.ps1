Function TestParameterSet{
  Param (
    [Parameter(Position=1)]
   [string] $Avariable,
    [Parameter(Position=3)]
   [string] $Bvariable,
    [Parameter(Position=2)]
   [string] $Cvariable
   )
  Write-Verbose "Test"
}
