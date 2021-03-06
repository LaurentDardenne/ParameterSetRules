# AvoidDuplicateParameterAttribut
**Severity Level: Error**

## Description
An attribute [Parameter()] can not be duplicated or contain contradictory statements.

### Function :  ParameterSetRules\Measure-DetectingErrorsInParameterList
## How to Fix
Remove the duplicated parameter attribute

## Example
### Wrong：
```PowerShell
Function TestParameterSet{
  [CmdletBinding(defaultparameterSetName = "F3")]
  
  Param ( 
    [Parameter(Position=1)]
    [Parameter(Position=1,ParametersetName="F2")]
   [Switch] $A,

    [Parameter(Position=2,ParameterSetname="F2")]
    [Parameter(Position=2,ParameterSetname="F2")]
   [Switch] $B,

    [Parameter(Position=0)]
    [Parameter(Position=0,parameterSetName="F3")]
    [Parameter(Position=1)]
   [Switch] $C   
  )
  Write-Verbose "Processing..."
}
```

### Correct:
```PowerShell
Function TestParameterSet{
  [CmdletBinding(defaultparameterSetName = "F3")]
  
  Param ( 
    [Parameter(Position=1)]
    [Parameter(Position=1,ParametersetName="F2")]
   [Switch] $A,

    [Parameter(Position=2,ParameterSetname="F2")]
   [Switch] $B,

    [Parameter(Position=0,parameterSetName="F3")]
   [Switch] $C   
  )
  Write-Verbose "Processing..."
}
```
