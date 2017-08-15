Function TestParameterSet{
[Diagnostics.CodeAnalysis.SuppressMessageAttribute( "Measure-ParameterNameShouldBePascalCase",
                                                     "", 
                                                     Justification="This test function does not target the PascalCase rule")]         
  [CmdletBinding(defaultparameterSetName = "F3")]
  [CmdletBinding(defaultparameterSetName = "F3")]  
  
  Param ( 
    [Parameter(Position=3,ParametersetName="F2")]
   [Switch] $Avariable,
    [Parameter(Position=2,ParameterSetname="F2")]
   [Switch] $Bvariable,
    [Parameter(Position=0,parameterSetName="F3")]
   [Switch] $Cvariable,
   
    [Parameter(Position=1,ParameterSetName="F2")]
    [Parameter(Position=2,ParameterSetName="F3")]
   [Switch] $Dvariable,
    [Parameter(Position=1,ParameterSetName="F3")]
   [Switch] $Evariable,

   [Switch] $Fvariable,
    
    [Parameter(Position=3)]
   [Int] $Gvariable=10,
   
    [Parameter(ParameterSetName="F4")]
   [Switch] $Hvariable,
    [Parameter(ParameterSetName="F4")]
   [Switch] $Ivariable,
    [Parameter(ParameterSetName="F4")]
    $Jvariable,

    [Parameter(Position=1,ParameterSetName="F5")]
   [Switch] $Kvariable,
    [Parameter(Position=2,ParameterSetName="F5")]
   [Switch] $Lvariable,
    [Parameter(Position=1,ParameterSetName="F5")]
    $Mvariable ,
    
    [Parameter(Position=5,ParameterSetName="F6")]
   [Switch] $Nvariable,
    [Parameter(Position=4,ParameterSetName="F6")]
   [Switch] $Ovariable,
    [Parameter(Position=3,ParameterSetName="F6")]
    $Pvariable,
    
    [Parameter(Position=1)]
    [Parameter(ParameterSetName="F6")]
    $Qvariable,
    
    [Parameter(Position=-3,ParameterSetName="F7")]
    ${32Bit},
    
    [Parameter()]
    ${Svariable}
   )
}