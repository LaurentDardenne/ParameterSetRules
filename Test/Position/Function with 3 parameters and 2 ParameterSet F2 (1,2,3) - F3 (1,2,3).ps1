Function TestParameterSet{
  [CmdletBinding(DefaultParameterSetName = "F2")]         
  Param (
    [Parameter(Position=1,ParametersetName="F2")]
   [string] $Avariable,
    [Parameter(Position=2,ParametersetName="F2")]
   [string] $Bvariable,
    [Parameter(Position=3,ParametersetName="F2")]
   [string] $Cvariable,
   
    [Parameter(Position=1,ParametersetName="F3")]
   [string] $Dvariable,
    [Parameter(Position=2,ParametersetName="F3")]
   [string] $Evariable,
    [Parameter(Position=3,ParametersetName="F3")]
   [string] $Fvariable   
   )
   Write-Verbose "ParameterSetName =$($PsCmdlet.ParameterSetName)"
}