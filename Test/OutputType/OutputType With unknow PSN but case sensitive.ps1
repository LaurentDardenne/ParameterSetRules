function Test-OutputType
{
 [CmdletBinding(DefaultParameterSetName = "asInt")]
 [OutputType(ParameterSetName="asString", [string])]
  [OutputType(ParameterSetName="asInt",[int] )]
  [OutputType(ParameterSetName="asDouble", ([double], [single]))]
#  [OutputType("lie", [int])]
 
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
    "lie" { "Hello there"; break } }
 }
 
function Test-MyType {
[OutputType('Foo.Bar')]
param ()
    [PSCustomObject]@{
        Alfa = 1
        Beta = 2
        Gamma = 3
    }
} 

# $r=(Test-MyType).
#  $r.a

#  $res=(Test-OutputType -asInt).