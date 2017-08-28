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
   $Dvar=10
  )
  write-verbose 'test'
}