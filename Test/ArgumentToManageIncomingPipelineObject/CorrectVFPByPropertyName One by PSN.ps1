Function TestParameterSet{
  [CmdletBinding(DefaultParameterSetName = "Fonctionnalite1")]
  Param (
      [Parameter(ValueFromPipelineByPropertyName=$false, ParameterSetName="Fonctionnalite1")]
    [String] $Avariable,

      [Parameter(ValueFromPipelineByPropertyName = $true, ParameterSetName="Fonctionnalite2")]
    [Int] $Bvariable,

    [Parameter(ValueFromPipelineByPropertyName = 1, ParameterSetName="Fonctionnalite3")]
    [Int] $Cvariable,

    [Parameter(ValueFromPipelineByPropertyName = 0, ParameterSetName="Fonctionnalite4")]
    [Int] $Dvariable
  )
 
   process {
     Write-Verbose "Traitement..."
   }
}
