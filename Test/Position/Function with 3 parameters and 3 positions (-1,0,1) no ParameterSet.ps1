Function TestParameterSet{
  Param (
    [Parameter(Position=-1)]
   [string] $Avariable,
    [Parameter(Position=0)]
   [string] $Bvariable,
    [Parameter(Position=1)]
   [string] $Cvariable
   )
  Write-Verbose "Test"
}
