<# 
bool   : $false, $true
int    : 0,1
defaut : $true -> Value,Byname 
#>
Function TestParameterSet{
  [CmdletBinding(DefaultParameterSetName = "Fonctionnalite1")]
  Param (
      [Parameter(ValueFromPipeline, ParameterSetName="Fonctionnalite1")]
    [String] $Avariable,

      [Parameter(ValueFromPipeline = $false, ParameterSetName="Fonctionnalite2")]
    [Switch] $Bvariable,

      [Parameter(ValueFromPipeline = $true, ParameterSetName="Fonctionnalite3")]
    [Switch] $Cvariable,

      [Parameter(ParameterSetName="Fonctionnalite1")]
      [Parameter(ValueFromPipeline = 1, ParameterSetName="Fonctionnalite2")]
      [Parameter(ParameterSetName="Fonctionnalite3")]
    [String] $Dvariable,

      [Parameter(ValueFromPipeline = 0, ParameterSetName="Fonctionnalite3")]
    [Switch] $Evariable
  )
 
   process {
     Write-Verbose "Traitement..."
   }
}
