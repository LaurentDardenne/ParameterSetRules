﻿Function TestParameterSet{
  [CmdletBinding(DefaultParameterSetName = "Name3")]
  Param (
    [Parameter(ParameterSetName="Name1")]
    [Switch] $Variable,

    [Parameter(ParameterSetName="Name2")]
    [Switch] $Switch
   )
 Write-Verbose "Traitement..."
}
