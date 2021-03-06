﻿ function Test-DefaultValue { 
  [CmdletBinding(DefaultParameterSetName = "First")]
  param( 
   [string]$Avar,
   
    [Parameter(Mandatory=$true)]
   $Bvar,
   
    [Parameter(Mandatory=$false)]
   $BvarTwo,

    [Parameter(Mandatory=$true,ParameterSetName="First")]
   $Cvar,
    
    [Parameter(ParameterSetName="First")]
    [Parameter(ParameterSetName="Second")]
   $Dvar=10,

    [Parameter(Mandatory=1,ParameterSetName="Second")]
   $Evar=$(Get-Location).Path,
   
    [Parameter(Mandatory=0,ParameterSetName="Second")]
   $FvarTwo=$(throw "Test error")
  )
  write-verbose 'test'
}