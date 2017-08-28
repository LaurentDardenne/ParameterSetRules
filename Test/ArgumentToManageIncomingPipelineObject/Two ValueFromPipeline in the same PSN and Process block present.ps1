Function TestParameterSet{
  [CmdletBinding(DefaultParameterSetName = "Fonctionnalite3")]
  Param (
      [Parameter(ValueFromPipeline = $true, ParameterSetName="Fonctionnalite1")]
    [String] $Avariable,

      [Parameter(ValueFromPipeline = $false, ParameterSetName="Fonctionnalite2")]
    [Switch] $Bvariable,

      [Parameter(ValueFromPipeline = $true, ParameterSetName="Fonctionnalite3")]
    [Switch] $Cvariable,

      [Parameter(ValueFromPipeline, ParameterSetName="Fonctionnalite1")]
      [Parameter(ValueFromPipeline, ParameterSetName="Fonctionnalite2")]
      [Parameter(ValueFromPipeline=$false,ParameterSetName="Fonctionnalite3")]
    [String] $Dvariable,

      [Parameter(ParameterSetName="Fonctionnalite2")]
    [Switch] $Evariable
  )
 
   process {
     Write-Verbose "Traitement..."
   }
}