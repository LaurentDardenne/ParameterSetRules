Function TestParameterSet{
  [CmdletBinding(DefaultParameterSetName = "Fonctionnalite3")]
  Param (
      [Parameter(ValueFromPipeline = $false,ParameterSetName="Fonctionnalite1")]
    [String] $Avariable,

      [Parameter(ValueFromPipelineByPropertyName = $false,ParameterSetName="Fonctionnalite2")]
    [Int] $Bvariable,

      [Parameter(ParameterSetName="Fonctionnalite3")]
    [Switch] $Cvariable,

      [Parameter(ParameterSetName="Fonctionnalite1")]
      [Parameter(ParameterSetName="Fonctionnalite2")]
      [Parameter(ParameterSetName="Fonctionnalite3")]
    [String] $Dvariable,

      [Parameter(ParameterSetName="Fonctionnalite2")]
    [Switch] $Evariable
  )
 
   process {
     Write-Verbose "Traitement..."
   }
}
