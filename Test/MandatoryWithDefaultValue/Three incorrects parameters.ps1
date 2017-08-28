 function Test-DefaultValue { 
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

    [Parameter(Mandatory,ParameterSetName="Second")]
   $Evar=$(Get-Location).Path,
   
    [Parameter(Mandatory=$False,ParameterSetName="Second")]
   $FvarTwo=$(throw "Test error"),
   
    [Parameter(Mandatory=1,ParameterSetName="First")]
    [Parameter(ParameterSetName="Second")]
   $Gvar=$(Get-Location).Path,
   
    [Parameter(Mandatory=$true,ParameterSetName="First")]
    [Parameter(Mandatory=$true,ParameterSetName="Second")]
   $Hvar="Test error",
   
    [ValidateScript({ Write-Warning "Validation '$_'";$True})]
   $Ivar=10
  )
  write-verbose 'test'
}