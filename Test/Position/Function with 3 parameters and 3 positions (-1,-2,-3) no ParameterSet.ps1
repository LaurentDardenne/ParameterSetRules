Function TestParameterSet{
  Param (
    [Parameter(Position=-1)]
   [string] $Avariable,
    [Parameter(Position=-2)]
   [string] $Bvariable,
    [Parameter(Position=-3)]
   [string] $Cvariable
   )
 Write-Verbose "Test"
}
