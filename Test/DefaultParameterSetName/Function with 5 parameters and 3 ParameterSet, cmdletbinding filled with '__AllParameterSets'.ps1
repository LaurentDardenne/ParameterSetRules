Function TestParameterSet{
  [CmdletBinding(defaultparametersetname = "__AllParameterSets")]
  Param (
    [Parameter(ParameterSetName="Fonctionnalite1")]
   [Switch] $Avariable,
    [Parameter(ParameterSetName="Fonctionnalite2")]
   [Switch] $Bvariable,
    [Parameter(ParameterSetName="Fonctionnalite3")]
   [Switch] $Cvariable,
    [Parameter(ParameterSetName="Fonctionnalite1")]
    [Parameter(ParameterSetName="Fonctionnalite2")]
    [Parameter(ParameterSetName="Fonctionnalite3")]
   [Switch] $Dvariable,
    [Parameter(parametersetname="Fonctionnalite2")]
   [Switch] $Evariable

   )
  Write-Host "Traitement..."
}
