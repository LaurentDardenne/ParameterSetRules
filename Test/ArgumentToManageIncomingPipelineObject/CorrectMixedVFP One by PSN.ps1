﻿Function TestParameterSet{
  [CmdletBinding(DefaultParameterSetName = "Fonctionnalite3")]
  Param (
      [Parameter(ValueFromPipeline = $true,ParameterSetName="Fonctionnalite1")]
    [String] $Avariable,

      [Parameter(ParameterSetName="Fonctionnalite2")]
    [Switch] $Bvariable,

      [Parameter(ValueFromPipelineByPropertyName = $true,ParameterSetName="Fonctionnalite3")]
    [Switch] $Cvariable,

      [Parameter(ParameterSetName="Fonctionnalite1")]
      [Parameter(ValueFromPipelineByPropertyName = $true,ParameterSetName="Fonctionnalite2")]
      [Parameter(ParameterSetName="Fonctionnalite3")]
    [String] $Dvariable
  )
  process {
    Write-Verbose "Traitement..."
  }
}
