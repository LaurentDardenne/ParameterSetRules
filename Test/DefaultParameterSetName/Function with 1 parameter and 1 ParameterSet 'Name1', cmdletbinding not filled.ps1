﻿Function TestParameterSet{
  [CmdletBinding()]
  Param (
    [Parameter(ParameterSetName="Name1")]
   [Switch] $A
   )
  Write-Host "Traitement..."
}
