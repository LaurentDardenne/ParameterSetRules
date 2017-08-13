Function TestParameterSet{
  [CmdletBinding(DefaultParameterSetName = "Fonctionnalite3")]
  Param (
    [Parameter(ParameterSetName="Fonctionnalite1")]
   [Switch] $Avariable,
    [Parameter(ParameterSetName="Fonctionnalite2")]
   [Switch] $Bvariable,
    [Parameter(ParameterSetName="Fonctionnalite3")]
   [Switch] $Cvaraible,
    [Parameter(ParameterSetName="Fonctionnalite1")]
    [Parameter(ParameterSetName="Fonctionnalite2")]
    [Parameter(ParameterSetName="Fonctionnalite3")]
   [Switch] $Dvariable,
    [Parameter(ParameterSetName="Fonctionnalite2")]
   [Switch] $Evaraible

   )
  Write-Verbose "Traitement..."
}
