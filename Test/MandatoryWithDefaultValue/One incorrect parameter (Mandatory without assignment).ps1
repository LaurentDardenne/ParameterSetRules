 function Test-DefaultValue { 
  [CmdletBinding(DefaultParameterSetName = "First")]
  param( 
     [Parameter(Mandatory,ParameterSetName="Second")]
   $Avar=$(Get-Location).Path,
        [Parameter(Mandatory,ParameterSetName="First")]
   $Bvar
  )
  write-verbose 'test'
}