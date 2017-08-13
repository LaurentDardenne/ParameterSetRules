Function TestParameterSet{
  [CmdletBinding(DefaultParameterSetName = "Fonctionnalite3")]
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
    [Parameter(ParameterSetName="Fonctionnalite2")]
   [Switch] $Evariable

   )
  Write-Verbose "Traitement..."
}
