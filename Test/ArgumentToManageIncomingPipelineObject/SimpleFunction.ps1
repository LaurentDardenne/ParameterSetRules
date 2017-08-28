Function TestParameterSet{
  [CmdletBinding(DefaultParameterSetName = "Fonctionnalite1")]
  Param (
      [Parameter(ValueFromPipelineByPropertyName=$false, ParameterSetName="Fonctionnalite1")]
    [String] $Avariable,

      [Parameter(ParameterSetName="Fonctionnalite2")]
    [Int] $Bvariable,

    [Parameter(ValueFromPipeline = 0, ParameterSetName="Fonctionnalite3")]
    [Int] $Cvariable
  )

     Write-Verbose "Traitement..."
}
