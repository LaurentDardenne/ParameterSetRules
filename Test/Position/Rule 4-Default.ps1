Function TestParameterSet{
   
  Param (
    [Parameter(Position=2)]
   [string] $Avariable,
    [Parameter(Position=3)]
   [string] $Bvariable,
    [Parameter(Position=4)]
   [string] $Cvariable
   )
   Write-Verbose "ParameterSetName =$($PsCmdlet.ParameterSetName)"
}