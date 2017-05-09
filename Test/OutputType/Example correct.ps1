function Test-OutputType
{
 [CmdletBinding(DefaultParameterSetName = "1nt")]
 [OutputType("asInt", [int])]
 [OutputType("asString", [string])]
 [OutputType("asDouble", ([double], [single]))]
 [OutputType("lie", [int])]
 
 param (
    [parameter(ParameterSetName="asInt")] [switch] $asInt,
    [parameter(ParameterSetName="asString")] [switch] $asString,
    [parameter(ParameterSetName="asDouble")] [switch] $asDouble,
    [parameter(ParameterSetName="lie")] [switch] $lie
 )
  Write-Host "Parameter set: $($PSCmdlet.ParameterSetName)"
  switch ($PSCmdlet.ParameterSetName) {
    "asInt" { 1 ; break }
    "asString" { "1" ; break }
    "asDouble" { 1.0 ; break }
    "lie" { "Hello there"; break } 
  }
}