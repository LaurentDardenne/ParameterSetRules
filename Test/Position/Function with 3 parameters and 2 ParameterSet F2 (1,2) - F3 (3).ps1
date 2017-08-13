Function TestParameterSet{
 [CmdletBinding(DefaultParameterSetName='F2')]       
  Param (
    [Parameter(Position=2,ParametersetName="F2")]
   [string] $Avariable,
    [Parameter(Position=3,ParametersetName="F2")]
   [string] $Bvariable,
    [Parameter(Position=4,ParametersetName="F3")]
   [string] $Cvariable
   )
   Write-Verbose "ParameterSetName =$($PsCmdlet.ParameterSetName)"
}