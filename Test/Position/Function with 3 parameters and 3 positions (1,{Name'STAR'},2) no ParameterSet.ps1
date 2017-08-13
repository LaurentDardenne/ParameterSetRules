Function TestParameterSet{
  Param (
    [Parameter(Position=1)]
   [string] $Avariable,
    [Parameter()]
   [string] ${Name*},
    [Parameter(Position=3)]
   [string] $Cvariable
   )
  Write-Verbose "Test"
}
