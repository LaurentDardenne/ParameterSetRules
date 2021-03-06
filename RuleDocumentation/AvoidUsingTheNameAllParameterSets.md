# AvoidUsingTheNameAllParameterSets
**Severity Level: Warning**

## Description
Avoid to use '__AllParameterSets' as name of a parameter set.

### Function :  ParameterSetRules\Measure-DetectingErrorsInDefaultParameterSetName

## How to Fix
Rename the parameter set name.

## Example
### Wrong：
```PowerShell
Function TestParameterSet{
  [CmdletBinding(defaultparameterSetName = "Feature2")]
  Param (
     [Parameter(ParametersetName="__AllParameterSets")]
    [Switch] $A,
     [Parameter(ParameterSetname="Feature2")]
    [Switch] $B,
     [Parameter(parameterSetName="Feature3")]
    [Switch] $C,
  )
  Write-Verbose "Processing..."
}
```

### Correct:
```PowerShell
Function TestParameterSet{
  [CmdletBinding(defaultparameterSetName = "Feature2")]
  Param (
     [Parameter(ParametersetName="Feature1")]
    [Switch] $A,
     [Parameter(ParameterSetname="Feature2")]
    [Switch] $B,
     [Parameter(parameterSetName="Feature3")]
    [Switch] $C,
  )
  Write-Verbose "Processing..."
}
```
