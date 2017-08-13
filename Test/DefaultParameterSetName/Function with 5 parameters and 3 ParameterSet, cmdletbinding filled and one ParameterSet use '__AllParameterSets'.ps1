Function TestParameterSet{
  [CmdletBinding(defaultparameterSetName = "Fonctionnalite3")]
  Param (
    [Parameter(ParametersetName="__AllParameterSets")]
   [Switch] $Avariable,
    [Parameter(ParameterSetname="Fonctionnalite2")]
   [Switch] $Bvariable,
    [Parameter(parameterSetName="Fonctionnalite3")]
   [Switch] $Cvariable,
    [Parameter(parametersetname="__AllParameterSets")]
    [Parameter(ParameterSetName="Fonctionnalite2")]
    [Parameter(ParameterSetName="Fonctionnalite3")]
   [Switch] $Dvariable,
    [Parameter(ParameterSetName="Fonctionnalite2")]
   [Switch] $Evariable

   )
  Write-Verbose "Traitement..."
}